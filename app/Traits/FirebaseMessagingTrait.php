<?php

namespace App\Traits;

use App\Models\Order;
use App\Models\UserToken;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Messaging\AndroidConfig;
use Kreait\Firebase\Messaging\WebPushConfig;
use Illuminate\Support\Facades\App;

trait FirebaseMessagingTrait
{

    use FirebaseAuthTrait;


    //
    private function sendFirebaseNotification($topic, $title, $body, array $data = null)
    {

        //getting firebase messaging
        $messaging = $this->getFirebaseMessaging();
        $message = CloudMessage::fromArray([
            'topic' => $topic,
            'notification' => [
                'title' => $title,
                'body' => $body,
                'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
                "sound" => "alert.aiff",
            ],
            'data' => $data,
        ]);

        //android configuration
        $config = AndroidConfig::fromArray([
            'ttl' => '3600s',
            'priority' => 'high',
            'data' => $data,
            'notification' => [
                'title' => $title,
                'body' => $body,
                'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
                "channel_id" => "high_importance_channel",
                "sound" => "alert",
            ],
        ]);

        $message = $message->withAndroidConfig($config);
        if (App::environment('production')) {
            $messaging->send($message);
        }
    }

    private function sendFirebaseNotificationToTokens(array $tokens, $title, $body, array $data = null)
    {
        if (!empty($tokens)) {
            //getting firebase messaging
            $messaging = $this->getFirebaseMessaging();
            $message = CloudMessage::new();
            //
            $config = WebPushConfig::fromArray([
                'notification' => [
                    'title' => $title,
                    'body' => $body,
                    'icon' => setting('websiteLogo', asset('images/logo.png')),
                ],
                'fcm_options' => [
                    'link' => $data[0],
                ],
            ]);
            //
            $message = $message->withWebPushConfig($config);
            if (App::environment('production')) {
                $messaging->sendMulticast($message, $tokens);
            }
        }
    }










    //
    public function sendOrderStatusChangeNotification(Order $order)
    {

        //order data
        $orderData = [
            'is_order' => "1",
            'order_id' => (string)$order->id,
        ];

        //
        $managersId = $order->vendor->managers->pluck('id')->all();
        $managersTokens = UserToken::whereIn('user_id', $managersId)->pluck('token')->toArray();

        //'pending','preparing','ready','enroute','delivered','failed','cancelled'
        if ($order->status == "pending") {
            $this->sendFirebaseNotification($order->user_id, "New Order", "Your order is pending", $orderData);
            //web
            $this->sendFirebaseNotificationToTokens($managersTokens, "New Order", "Order #" . $order->code . " has just been placed with you", [route('orders')]);
            //vendor
            $this->sendFirebaseNotification("v_" . $order->vendor_id, "New Order", "Order #" . $order->code . " has just been placed with you", $orderData);
        } else if ($order->status == "preparing") {
            $this->sendFirebaseNotification($order->user_id, "Order Update", "Your order is now being prepared", $orderData);
        } else if ($order->status == "ready") {
            $this->sendFirebaseNotification($order->user_id, "Order Update", "Your order is now ready for delivery/pickup", $orderData);
        } else if ($order->status == "enroute") {

            //web
            $this->sendFirebaseNotificationToTokens($managersTokens, "Order Update", "Order #" . $order->code . " has been assigned to a delivery boy", [route('orders')]);


            //user
            $this->sendFirebaseNotification($order->user_id, "Order Update", "Order #" . $order->code . " has been assigned to a delivery boy", $orderData);
            //vendor
            $this->sendFirebaseNotification("v_" . $order->vendor_id, "Order Update", "Order #" . $order->code . " has been assigned to a delivery boy", $orderData);

            //driver
            if (!empty($order->driver_id)) {
                $this->sendFirebaseNotification($order->driver_id, "Order Update", "Order #" . $order->code . " has been assigned to you", $orderData);
            }
        } else if ($order->status == "delivered") {
            $this->sendFirebaseNotification($order->user_id, "Order Update", "Order #" . $order->code . " has been has been delivered", $orderData);
        } else if (!empty($order->status)) {
            $this->sendFirebaseNotification($order->user_id, "Order Update", "Order #" . $order->code . " has been " . $order->status . "", $orderData);
        }
    }

    //notificat chat parties
    public function sendChatNotification(Order $order)
    {
        // //chat sample
        // $this->sendFirebaseNotification($topic, $this->headings, $this->message, [
        //     'is_chat' => "1",
        //     'code' => "hfjh27hj",
        //     'vendor' => json_encode([
        //         "id" => 1,
        //         "name" => "Meme Inc.",
        //         "photo" => "https://img.icons8.com/cute-clipart/344/apple-app-store.png",
        //     ]),
        //     'user' => json_encode([
        //         "id" => 6,
        //         "name" => "Client User",
        //         "photo" => "https://img.icons8.com/cute-clipart/344/apple-app-store.png",
        //     ]),
        // ]);
    }
}
