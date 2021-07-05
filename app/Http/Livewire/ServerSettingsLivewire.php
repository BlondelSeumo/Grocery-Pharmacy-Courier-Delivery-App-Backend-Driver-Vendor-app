<?php

namespace App\Http\Livewire;

use Exception;
use Brotzka\DotenvEditor\DotenvEditor;

class ServerSettingsLivewire extends BaseLivewireComponent
{

    // App settings
    public $mailHost;
    public $mailPort;
    public $mailUsername;
    public $mailPassword;
    public $mailFromAddress;
    public $androidDownloadLink;
    public $iosDownloadLink;


    public function mount()
    {
        //
        $this->mailHost = env('MAIL_HOST');
        $this->mailPort = env('MAIL_PORT');
        $this->mailUsername = env('MAIL_USERNAME');
        $this->mailPassword = env('MAIL_PASSWORD');
        $this->mailFromAddress = env('MAIL_FROM_ADDRESS');
        $this->androidDownloadLink = setting('androidDownloadLink');
        $this->iosDownloadLink = setting('iosDownloadLink');
    }

    public function render()
    {

        $this->mount();
        return view('livewire.settings.server-settings');
    }


    public function saveMailSettings()
    {

        $this->validate([
            "mailHost" => "required",
            "mailPort" => "required",
            "mailUsername" => "required",
            "mailPassword" => "required",
            'mailFromAddress' => "required",
        ]);

        try {

            $this->isDemo();
            $env = new DotenvEditor();

            $env->changeEnv([
                'MAIL_HOST'   => $this->mailHost,
                'MAIL_PORT'   => $this->mailPort,
                'MAIL_USERNAME'   => "'".$this->mailUsername."'",
                'MAIL_PASSWORD'   => "'".$this->mailPassword."'",
                'MAIL_FROM_ADDRESS'   => "'".$this->mailFromAddress."'",
            ]);

            $appSettings = [
                'androidDownloadLink' =>  $this->androidDownloadLink,
                'iosDownloadLink' =>  $this->iosDownloadLink,
            ];
            // update app download links
            setting($appSettings)->save();

            $this->showSuccessAlert("Mail Settings saved successfully!");
            $this->reset();
        } catch (Exception $error) {
            $this->showErrorAlert($error->getMessage() ?? "Mail Settings save failed!");
        }
    }
}
