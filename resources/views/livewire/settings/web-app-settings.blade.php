<div>

    <x-baseview title="Web App Settings">

        <x-form action="saveAppSettings" backPressed="$set('showApp', false)">

            <div class="grid grid-cols-1 gap-5 md:grid-cols-2">
                <div class="">
                    <x-input title="Website Name" name="websiteName" />
                    <div>
                        <x-input title="Website Color" name="websiteColor" type="color" class="h-10" />
                        <p class="text-sm text-gray-500">Note: You will need to refresh the page for the color to take
                            effect</p>
                    </div>


                    <div>
                        <x-input title="Phone Country Code (Country of operations)" name="countryCode" />
                        <a href="https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2" target="_blank"
                            class="mt-1 text-xs text-gray-500 underline">List Of Country Codes</a>
                        <p class="text-sm text-gray-500">Note: For example if you want to allow phone from Ghana you
                            enter
                            GH</p>
                        <p class="text-sm text-gray-500">Note: if you want to allow phone from any country enter AUTO
                        </p>
                    </div>

                    {{-- timeZone --}}
                    <div>
                        <x-input title="Timezone" name="timeZone" />
                        <a href="https://www.php.net/manual/en/timezones.php" target="_blank"
                            class="mt-1 text-xs text-gray-500 underline">List Of Supported timezones</a>
                    </div>
                    <div class="grid grid-cols-1 gap-5 md:grid-cols-2">
                        {{-- schedule max days --}}
                        <div>
                            <x-input title="Max Schedule Order Days" name="maxScheduledDay" type="number" />
                            <p class="mt-1 text-xs text-gray-500">The max number of days customers are allowed to schedule an order</p>
                        </div>
                        {{-- schedule order time --}}
                        <div>
                            <x-input title="Schedule Order Time" name="minScheduledTime" type="number" />
                            <p class="mt-1 text-xs text-gray-500">Hours before pickup time for system to move order from
                                'scheduled' to 'pending'</p>
                        </div>
                        {{-- schedule order time --}}
                        <div>
                            <x-input title="Max Schedule Time" name="maxScheduledTime" type="number" />
                            <p class="mt-1 text-xs text-gray-500">Hours from close time that customer still allow to book for</p>
                        </div>
                    </div>
                </div>
                <div>
                    {{-- logo --}}
                    <div class="flex items-center mt-5 space-x-10">
                        <img src="{{ $websiteLogo != null ? $websiteLogo->temporaryUrl() : $oldWebsiteLogo }}"
                            class="w-24 h-24 rounded" />
                        <x-input title="Website Logo" name="websiteLogo" :defer="false" type="file" />
                    </div>

                    {{-- favicon --}}
                    <div class="flex items-center mt-5 space-x-10">
                        <img src="{{ $favicon != null ? $favicon->temporaryUrl() : $oldFavicon }}"
                            class="w-24 h-24 rounded" />
                        <x-input title="Website Favicon" name="favicon" :defer="false" type="file" />
                    </div>

                    {{-- loginImage --}}
                    <div class="flex items-center mt-5 space-x-10">
                        <img src="{{ $loginImage != null ? $loginImage->temporaryUrl() : $oldLoginImage }}"
                            class="w-24 h-24 rounded" />
                        <x-input title="Login Image" name="loginImage" :defer="false" type="file" />
                    </div>

                    {{-- registerImage --}}
                    <div class="flex items-center my-5 space-x-10">
                        <img src="{{ $registerImage != null ? $registerImage->temporaryUrl() : $oldRegisterImage }}"
                            class="w-24 h-24 rounded" />
                        <x-input title="Register Image" name="registerImage" :defer="false" type="file" />
                    </div>
                    <x-buttons.primary title="Save Changes" />
                </div>
                <div>
        </x-form>

    </x-baseview>

</div>
