<div>

    <x-baseview title="Push notification setting(Firebase)">

        <x-form action="saveNotificationSetting" backPressed="$set('showNotification', false)">
            <div class="w-full md:w-4/5 lg:w-5/12">
                <x-input title="API Key" name="apiKey"/>
                <x-input title="Project ID" name="projectId"/>
                <x-input title="Message Sender ID" name="messagingSenderId"/>
                <x-input title="App ID" name="appId"/>
                <x-input title="Web Push Key Pair" name="vapidKey"/>
                <x-media-upload title="Service Account" name="photo" :photo="$photo" :photoInfo="$photoInfo"
                    :image="false" types="JSON" rules="application/JSON" />
                <x-buttons.primary title="Save Changes" />
                <div>
        </x-form>

    </x-baseview>

</div>
