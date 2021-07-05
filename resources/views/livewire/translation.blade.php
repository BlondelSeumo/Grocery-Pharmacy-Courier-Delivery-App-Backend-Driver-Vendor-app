@section('title', 'Tanslation')
    <div>

        <x-baseview title="Tanslation">
            <x-form action="translate">
                <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
                    <div>
                        <p>Text(new line for new text)</p>
                        <textarea class="w-full h-64 p-2 border rounded" wire:model.defer='text'></textarea>
                    </div>
                    <div>
                        <p>Language Codes(seperate lines with ;)</p>
                        <textarea class="w-full p-2 mb-4 border rounded" wire:model.defer='languages'></textarea>
                        <p>For backend</p>
                        <x-checkbox title="Enable" name="forBackend" :defer="true" />
                    </div>

                    <x-buttons.primary title="Translate" />
                </div>
            </x-form>

            <div>
                {!! $translatedString !!}
                
            </div>
        </x-baseview>


    </div>
