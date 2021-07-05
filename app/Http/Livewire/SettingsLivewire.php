<?php

namespace App\Http\Livewire;

use Exception;
use Illuminate\Support\Facades\Storage;
use League\CommonMark\CommonMarkConverter;
use Brotzka\DotenvEditor\DotenvEditor;

class SettingsLivewire extends BaseLivewireComponent
{

    public $showNotification = false;
    public $showApp = false;
    public $showPrivacy = false;
    public $showContact = false;

    // App settings
    public $websiteName;
    public $countryCode;
    public $websiteColor;
    public $websiteLogo;
    public $oldWebsiteLogo;
    public $favicon;
    public $oldFavicon;
    public $loginImage;
    public $oldLoginImage;
    public $registerImage;
    public $oldRegisterImage;
    public $timeZone;
    public $maxScheduledDay;
    public $maxScheduledTime;
    public $minScheduledTime;

    //Privacy Settings
    public $privacyPolicy;
    public $contactInfo;

    //firebase
    public $apiKey;
    public $projectId;
    public $messagingSenderId;
    public $appId;
    public $vapidKey;

    protected $listeners = [
        'deleteModel',
        'refreshTable' => '$refresh',
    ];


    public function render()
    {
        if ($this->showNotification) {
            return view('livewire.settings.notification');
        } else if ($this->showApp) {
            return view('livewire.settings.web-app-settings');
        } else if ($this->showPrivacy) {
            return view('livewire.settings.privacy-policy');
        } else if ($this->showContact) {
            return view('livewire.settings.contact');
        } else {
            return view('livewire.settings.index');
        }
    }

    //Notification settings
    public function notificationSetting()
    {
        $this->apiKey = setting('apiKey', "");
        $this->projectId = setting('projectId', "");
        $this->messagingSenderId = setting('messagingSenderId', "");
        $this->appId = setting('appId', "");
        $this->vapidKey = setting('vapidKey', "");
        $this->showNotification = true;
    }

    public function saveNotificationSetting()
    {

        try {

            $this->isDemo();

            setting([
                "apiKey" => $this->apiKey,
                "projectId" => $this->projectId,
                "messagingSenderId" => $this->messagingSenderId,
                "appId" => $this->appId,
                "vapidKey" => $this->vapidKey,
            ])->save();

            //change firenase service worker js file
            $file_name = base_path()."/public/firebase-messaging-sw.js";
            $this->fileEditContents($file_name, "13", "apiKey: '".$this->apiKey."',");
            $this->fileEditContents($file_name, "14", "projectId: '".$this->projectId."',");
            $this->fileEditContents($file_name, "15", "messagingSenderId: '".$this->messagingSenderId."',");
            $this->fileEditContents($file_name, "16", "appId: '".$this->appId."',");

            if ($this->photo != null) {

                $this->validate([
                    "photo" => "required|mimes:json",
                ]);




                //
                $serviceKeyPath = $this->photo->storeAs('vault', 'firebase_service.json');

                setting([
                    'serviceKeyPath' =>  $serviceKeyPath ?? "",
                ])->save();
            }

            $this->showSuccessAlert("Settings saved successfully!");
            $this->reset();
        } catch (Exception $error) {
            $this->showErrorAlert($error->getMessage() ?? "Settings save failed!");
        }
    }

    //App settings
    public function appSettings()
    {
        $this->websiteName = setting('websiteName', env("APP_NAME"));
        $this->websiteColor = setting('websiteColor', '#21a179');
        $this->countryCode = setting('countryCode', "GH");
        $this->timeZone = setting('timeZone', "UTC");
        $this->maxScheduledDay = setting('maxScheduledDay', 5);
        $this->maxScheduledTime = setting('maxScheduledTime', 2);
        $this->minScheduledTime = setting('minScheduledTime', 2);
        $this->oldWebsiteLogo = setting('websiteLogo', asset('images/logo.png'));
        $this->oldFavicon = setting('favicon', asset('images/logo.png'));
        $this->oldLoginImage = setting('loginImage', asset('images/login-office.jpeg'));
        $this->oldRegisterImage = setting('registerImage', asset('images/login-office.jpeg'));
        $this->showApp = true;
    }

    public function saveAppSettings()
    {

        $this->validate([
            "websiteLogo" => "sometimes|nullable|image|max:1024",
            "favicon" => "sometimes|nullable|image|mimes:png|max:48",
            "loginImage" => "sometimes|nullable|image|max:3072",
            "registerImage" => "sometimes|nullable|image|max:3072",
        ]);

        try {

            $this->isDemo();

            // store new logo
            if ($this->websiteLogo) {
                $this->oldWebsiteLogo = Storage::url($this->websiteLogo->store('public/logos'));
            }

            // store new logo
            if ($this->favicon) {
                $this->oldFavicon = Storage::url($this->favicon->store('public/favicons'));
            }

            // store new logo
            if ($this->loginImage) {
                $this->oldLoginImage = Storage::url($this->loginImage->store('public/auth/login'));
            }

            // store new logo
            if ($this->registerImage) {
                $this->oldRegisterImage = Storage::url($this->registerImage->store('public/auth/register'));
            }


            //
            $env = new DotenvEditor();
            $env->changeEnv([
                'APP_NAME'   => "'".$this->websiteName."'",
            ]);

            $appSettings = [
                'websiteName' =>  $this->websiteName,
                'websiteColor' =>  $this->websiteColor,
                'countryCode' =>  $this->countryCode,
                'timeZone' =>  $this->timeZone,
                'maxScheduledDay' =>  $this->maxScheduledDay,
                'maxScheduledTime' =>  $this->maxScheduledTime,
                'minScheduledTime' =>  $this->minScheduledTime,
                'websiteLogo' =>  $this->oldWebsiteLogo,
                'favicon' =>  $this->oldFavicon,
                'loginImage' =>  $this->oldLoginImage,
                'registerImage' =>  $this->oldRegisterImage,
            ];

            // update the site name
            setting($appSettings)->save();



            $this->showSuccessAlert("App Settings saved successfully!");
            $this->reset();
        } catch (Exception $error) {
            $this->showErrorAlert($error->getMessage() ?? "App Settings save failed!");
        }
    }




    //Meeeting settings
    public function privacySettings()
    {
        $this->privacyPolicy = setting('privacyPolicy', "");
        $this->showPrivacy = true;
        // $this->dispatchBrowserEvent('privacyPolicyChange', ["value" => $this->privacyPolicy]);
    }

    public function savePrivacyPolicy()
    {

        try {

            $this->isDemo();
            $converter = new CommonMarkConverter([
                'html_input' => 'unstrip',
                'allow_unsafe_links' => false,
            ]);
    
            $this->privacyPolicy = $converter->convertToHtml($this->privacyPolicy);
            setting([
                'privacyPolicy' =>  $this->privacyPolicy,
            ])->save();

            $this->showSuccessAlert("Privacy Policy Settings saved successfully!");
            $this->reset();
        } catch (Exception $error) {
            // $this->showErrorAlert( $error->getMessage() ?? "Privacy Policy Settings save failed!");
            $this->showErrorAlert("Privacy Policy ===> " . $this->privacyPolicy . "");
        }
    }


    //
    public function contactSettings()
    {
        $this->contactInfo = setting('contactInfo', "");
        $this->showContact = true;
    }

    public function saveContactInfo()
    {

        try {

            $this->isDemo();

            setting([
                'contactInfo' =>  $this->contactInfo,
            ])->save();

            $this->showSuccessAlert("Contact Info saved successfully!");
            $this->reset();
        } catch (Exception $error) {
            // $this->showErrorAlert( $error->getMessage() ?? "Privacy Policy Settings save failed!");
            $this->showErrorAlert("Contact Info ===> " . $this->privacyPolicy . "");
        }
    }




    //
    function fileEditContents($file_name, $line, $new_value)
    {
        $file = explode("\n", rtrim(file_get_contents($file_name)));
        $file[$line] = $new_value;
        $file = implode("\n", $file);
        file_put_contents($file_name, $file);
    }
}
