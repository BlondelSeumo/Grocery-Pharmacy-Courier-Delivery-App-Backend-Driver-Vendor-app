@section('title', 'Server Settings')
<div>

    <x-baseview title="Server Settings">



        <div class='grid grid-cols-1 gap-4 space-x-10 md:grid-cols-2'>
            <div>
                <x-form action="saveMailSettings">
                    <p class="text-2xl font-body">Mail Setting</p>
                    <x-input title="Host" name="mailHost" />
                    <x-input title="Port" name="mailPort" />
                    <x-input title="Username" name="mailUsername" />
                    <x-input title="Password" name="mailPassword" type="password" />
                    <x-input title="From Email" name="mailFromAddress" />
                    <div class="h-1 my-4 bg-gray-500 border-3"></div>
                    <x-input title="Android App Download Link" name="androidDownloadLink" />
                    <x-input title="iOS App Download Link" name="iosDownloadLink" />
                    <x-buttons.primary title="Save Changes" />
                </x-form>
            </div>
        </div>

    </x-baseview>

</div>
