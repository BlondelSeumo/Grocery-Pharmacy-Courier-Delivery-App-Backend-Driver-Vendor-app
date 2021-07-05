<?php

namespace App\Http\Livewire;

use App\Traits\SystemUpdateTrait;

class UpgradeLivewire extends BaseLivewireComponent
{

    use SystemUpdateTrait;
    public $terminalCommand;
    public $terminalError;
    public $phone_code;
    public $verison_code;


    public function render()
    {

        $this->verison_code = setting('appVerisonCode', "1");
        return view('livewire.settings.upgrade', [
            "verisonCodes" => $this->versionCodes(),
        ]);
    }

    public function versionCodes()
    {

        $appVersionCode = setting('appVerisonCode', "1");
        $verisons = [];
        $startCount = $appVersionCode - 3;
        for ($i = $startCount; $i <= $appVersionCode; $i++) {
            array_push($verisons, $i);
        }
        return $verisons;
    }

    public function upgradeAppSystem()
    {

        try {
            //
            $this->isDemo();
            $this->runUpgradeAppSystemCommands();
            $this->showSuccessAlert("System Updated Successfully!");
        } catch (\Exception $ex) {
            $this->showErrorAlert($ex->getMessage() ?? "Failed");
        }
    }



    public function rollBackUpgrade()
    {
        try {
            //
            $this->isDemo();
            setting([
                'appVerisonCode' =>  $this->verison_code,
            ])->save();
            $this->runUpgradeAppSystemCommands();
            $this->showSuccessAlert("Rollback Updated Successfully!");
        } catch (\Exception $ex) {
            $this->showErrorAlert($ex->getMessage() ?? "Failed");
        }
    }


    public function runTerminalCommand()
    {

        $this->terminalError = "";

        try {

            //
            $this->isDemo();
            $this->systemTerminalRun($this->terminalCommand);
            $this->showSuccessAlert("Terminal command successfully!");
        } catch (\Exception $error) {
            $this->terminalError = $error->getMessage() ?? "Terminal command failed!";
        }
    }
}
