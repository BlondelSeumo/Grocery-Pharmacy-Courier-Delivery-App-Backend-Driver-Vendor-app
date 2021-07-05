<?php

namespace App\Observers;

use App\Models\Order;
use App\Mail\OrderUpdateMail;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class OrderObserver
{


    public function creating(Order $model)
    {
        $model->code = Str::random(10);
        $model->verification_code = Str::random(5);
        $model->user_id = Auth::id();
    }

    public function created(Order $model)
    {
        //sending notifications base on status change of the order
        $model->sendOrderStatusChangeNotification($model, true);
        $this->sendOrderUpdateMail($model);
        $model->notifyDeliveryBoys();
    }


    public function updated(Order $model)
    {
        //sending notifications base on status change of the order
        $model->sendOrderStatusChangeNotification($model);
        $this->sendOrderUpdateMail($model);
        $model->updateEarning();
        $model->refundUser();
        $model->notifyDeliveryBoys();
        $model->clearFirestore();
    }

    public function sendOrderUpdateMail($model)
    {   
        //only delivered
        if (in_array($model->status, ['delivered'])) {
            //send mail
            try {
                \Mail::to($model->user->email)
                    ->cc([$model->vendor->email])
                    ->send(new OrderUpdateMail($model));
            } catch (\Exception $ex) {
                logger("Mail Error", [$ex]);
            }
        }
    }
}
