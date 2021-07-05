<?php

namespace App\Traits;

use MrShan0\PHPFirestore\FirestoreClient;
use MrShan0\PHPFirestore\FirestoreDocument;
use MrShan0\PHPFirestore\Fields\FirestoreObject;


trait FirebaseDBTrait
{

    use FirebaseAuthTrait;

    public function saveToFCDB($order)
    {


        // if( empty($order->delivery_address_id) && empty($order->pickup_location_id)  ){
        //     return;
        // }

        try {
            $firestoreClient = new FirestoreClient(setting('projectId', ""), setting('apiKey', ""), [
                'database' => '(default)',
            ]);

            $document = new FirestoreDocument;
            $document->setObject('pickup', new FirestoreObject(
                [
                    'lat' => $order->type == "regular" ? $order->vendor->latitude : $order->pickup_location->latitude,
                    'long' => $order->type == "regular" ? $order->vendor->longitude : $order->pickup_location->longitude,
                    'address' => $order->type == "regular" ? $order->vendor->address : $order->pickup_location->address,
                    'city' => $order->type == "regular" ? "" : $order->pickup_location->city,
                ]
            ));
            $document->setObject('dropoff', new FirestoreObject(
                [
                    'lat' => $order->type == "regular" ? $order->delivery_address->latitude : $order->dropoff_location->latitude,
                    'long' => $order->type == "regular" ? $order->delivery_address->longitude : $order->dropoff_location->longitude,
                    'address' => $order->type == "regular" ? $order->delivery_address->address : $order->dropoff_location->address,
                    'city' => $order->type == "regular" ? "" : $order->dropoff_location->city,
                ]
            ));
            //amount
            $document->setString('amount', (string)$order->delivery_fee);
            $document->setInteger('vendor_id', $order->vendor_id);
            $document->setBoolean('is_parcel', $order->type != "regular");
            if ($order->type != "regular") {
                $document->setString('package_type', $order->package_type->name);
            }
            $document->setInteger('id', $order->id);
            $document->setInteger('range', $order->vendor->delivery_range);

            $firestoreClient->addDocument("newOrders", $document, $order->code);
        } catch (\Exception $ex) {
            logger("Error", [$ex]);
        }
    }

    //
    public function deleteFromFCDB($order)
    {

        try {
            $firestoreClient = new FirestoreClient(setting('projectId', ""), setting('apiKey', ""), [
                'database' => '(default)',
            ]);
            $firestoreClient->deleteDocument("newOrders/" . $order->code . "");
        } catch (\Exception $ex) {
            logger("Error", [$ex]);
        }
    }
}
