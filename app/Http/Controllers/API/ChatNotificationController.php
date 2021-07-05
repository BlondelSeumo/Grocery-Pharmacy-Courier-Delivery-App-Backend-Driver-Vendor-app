<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Traits\FirebaseMessagingTrait;
use Illuminate\Http\Request;
use App\Models\User;

class ChatNotificationController extends Controller
{
    use FirebaseMessagingTrait;
    //
    public function send(Request $request)
    {

        //
        $peerUser = User::with('roles')->where('id', $request->peer['id'] )->first();
        $peer = $request->peer;
        $peer["role"] = $peerUser->roles->first;
        $peer = json_encode($peer);

        //
        try {
            $orderData = [
                'is_chat' => "1",
                'path' => $request->path,
                'user' => json_encode($request->user),
                'peer' => $peer,
            ];
            $this->sendFirebaseNotification($request->topic, $request->title, $request->body, $orderData);

            //
            return response()->json([
                "message" => "Notification sent successfully"
            ], 200);
        } catch (\Exception $ex) {
            return response()->json([
                "message" => $ex->getMessage() ?? "Notification failed"
            ], 400);
        }
    }
}
