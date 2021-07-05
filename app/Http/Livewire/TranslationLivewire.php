<?php

namespace App\Http\Livewire;

use Exception;
use Google\Cloud\Translate\V2\TranslateClient;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class TranslationLivewire extends BaseLivewireComponent
{

    //
    public $text;
    public $languages = "fr;es;de;pt;ar;ko";
    public $translatedString;
    public $forBackend = false;

    public function render()
    {
        // $this->languages = "fr;es;de;pt;ar;ko";
        return view('livewire.translation');
    }


    public function translate()
    {

        $this->translatedString = "";

        try {

            $texts = explode("\n", trim($this->text));
            $languagesArray = explode(";", trim($this->languages));

            //
            $translate = new TranslateClient(
                [
                    "keyFile" => json_decode(Storage::get(setting('serviceKeyPath', 'vault/firebase_service.json')), true),
                ]
            );



            //
            if (!$this->forBackend) {
                for ($i = 0; $i < count($texts); $i++) {

                    //text to be translated
                    $text = $texts[$i];
                    $translatedObject = [];
                    //
                    $translatedObject["en"] = $text;

                    //translating
                    foreach ($languagesArray as $language) {

                        $result = $translate->translate($text, [
                            'target' => $language,
                            'format' => 'text'
                        ]);

                        // logger("Result", $result);
                        //
                        $translatedObject[$language] = $result["text"];
                    }



                    //logging it
                    // logger("".$text."");
                    // logger("".utf8_encode(json_encode($translatedObject))."");


                    if ($i != 0) {
                        $this->translatedString .= "+";
                    }
                    $this->translatedString .= stripcslashes(json_encode($translatedObject, JSON_UNESCAPED_UNICODE));
                }
            } else {

                //
                $fullyTransalatedResult = "";
                //
                foreach ($languagesArray as $language) {

                    //
                    $translatedObject = [];
            
                    for ($i = 0; $i < count($texts); $i++) {

                        //text to be translated
                        $text = $texts[$i];
                        // $translatedObject = [];
                        //
                        $result = $translate->translate($text, [
                            'target' => $language,
                            'format' => 'text'
                        ]);
    
                        // logger("Result", $result);
                        //
                        $translatedObject[$text] = $result["text"];


                        //logging it
                        // logger("".$text."");
                        // logger("".utf8_encode(json_encode($translatedObject))."");

                        // array_push($languageTranslatedObject, $translatedObject);
                    }
                    $fullyTransalatedResult .= "<br/><br/>".$language."<br/>".json_encode($translatedObject, JSON_UNESCAPED_UNICODE);
                }

                //
                $this->translatedString = $fullyTransalatedResult;
            }

            // logger("".utf8_decode($this->translatedString)."");

        } catch (Exception $error) {
            logger("Error", [$error]);
            $this->showErrorAlert($error->getMessage() ?? "Translation failed");
        }
    }
}
