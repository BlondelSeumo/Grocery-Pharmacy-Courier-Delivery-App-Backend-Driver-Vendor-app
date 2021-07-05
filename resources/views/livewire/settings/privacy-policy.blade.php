<div>

    <x-baseview title="Privacy Policy">

        <x-form action="savePrivacyPolicy" backPressed="$set('showPrivacy', false)">
            <div class="w-full md:w-4/5 lg:w-7/12">

                <div class="mb-4">
                    <x-label title="Privacy & Policy"/>
                    <p class="text-xs italic text-red-500">* Html code allowed</p>
                </div>
                {{-- <div class="hidden ">
                    <x-input title="" name="privacyPolicy"  />
                </div> --}}
                {{-- <textarea id="privacyPolicy" class="w-7/12 h-screen"></textarea> --}}
                
                <textarea id="privacyPolicy" wire:model.defer="privacyPolicy" class="w-full h-screen p-2 border border-black rounded-sm"></textarea>
                <x-buttons.primary title="Save Changes" />

            <div>
        </x-form>

    </x-baseview>



</div>




