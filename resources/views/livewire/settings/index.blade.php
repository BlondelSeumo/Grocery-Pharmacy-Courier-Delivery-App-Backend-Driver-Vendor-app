@section('title', 'Settings')
<div>

    <x-baseview title="Settings">

        <div class="grid grid-cols-1 gap-6 mt-10 md:grid-cols-2 lg:grid-cols-3">

            {{-- OneSignal settings --}}
            <x-settings-item title="Push notification (Firebase)" wireClick="notificationSetting" >
                <x-heroicon-o-speakerphone class="w-5 h-5 mr-4" />
            </x-settings-item>

            {{-- app settings --}}
            <x-settings-item title="Web App Settings" wireClick="appSettings" >
                <x-heroicon-o-cog class="w-5 h-5 mr-4" />
            </x-settings-item>

            {{-- Privacy policy --}}
            <x-settings-item title="Privacy & Policy" wireClick="privacySettings" >
                <x-heroicon-o-eye-off class="w-5 h-5 mr-4" />
            </x-settings-item>

            {{-- Contact info --}}
            <x-settings-item title="Contact Info" wireClick="contactSettings" >
                <x-heroicon-o-chat class="w-5 h-5 mr-4" />
            </x-settings-item>

        </div>

    </x-baseview>

</div>
