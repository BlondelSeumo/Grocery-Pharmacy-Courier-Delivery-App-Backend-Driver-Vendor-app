<?php
namespace App\Traits;
use Kreait\Firebase\Factory;
use Illuminate\Support\Facades\Storage;


trait FirebaseAuthTrait
{

    private function getFirebaseFactory(){
        return (new Factory)->withServiceAccount( Storage::get(setting('serviceKeyPath' ,'vault/firebase_service.json')) );
    }

    private function getFirebaseMessaging(){
        return $this->getFirebaseFactory()->createMessaging();
    }

    private function getFirebaseAuth(){
        return $this->getFirebaseFactory()->createAuth();
    }


    public function verifyFirebaseIDToken($idTokenString){
        //
        $auth = $this->getFirebaseAuth();
        $verifiedIdToken = $auth->verifyIdToken($idTokenString);
        $uid = $verifiedIdToken->claims()->get('sub');
        return $auth->getUser($uid);

    }

}
