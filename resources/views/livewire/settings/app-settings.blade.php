@section('title', 'Mobile App Settings')
<div>

    <x-baseview title="Mobile App Settings">

        <x-form action="saveAppSettings">

            <div class="">
                <div class='grid grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-3'>
                    <x-input title="App Name" name="appName" />
                    <div>
                        <x-input title="Google Map Key" name="googleMapKey" />
                        <p class="mt-1 text-xs">Insert google maps key <br />
                            ( <a href="https://console.developers.google.com/apis/dashboard" target="_blank"
                                class="underline text-primary-500">https://console.developers.google.com/apis/dashboard</a>
                            )
                        </p>
                    </div>
                    {{-- What3words --}}
                    <div>
                        <x-input title="What3words Api Key" name="what3wordsApiKey" />
                        <a href="https://what3words.com/select-plan?currency=USD" target="_blank"
                            class="mt-1 text-xs text-gray-500 underline">Get api key</a>
                    </div>

                    {{-- country code --}}
                    <div>
                        <x-input title="Country Code" name="appCountryCode" />
                        <a href="https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2" target="_blank"
                            class="mt-1 text-xs text-gray-500 underline">List Of Country Codes</a>
                        <p class="text-sm text-gray-500">Note: For example if you want to allow phone from Ghana you
                            enter
                            GH</p>
                    </div>
                    {{-- Working --}}
                    <div class="block mt-4 text-sm">
                        <p>Enable Firebase Phone OTP for verification</p>
                        <x-checkbox title="Enable" name="enableOTP" :defer="true" />
                    </div>

                    <div class="block mt-4 text-sm">
                        <p>Driver Wallet System</p>
                        <x-checkbox title="Enable" name="enableDriverWallet" :defer="true" />
                    </div>

                    {{-- refer --}}
                    <div class="block mt-4 text-sm">
                        <p>Refer System</p>
                        <x-checkbox title="Enable" name="enableReferSystem" :defer="true" />
                    </div>
                    <div x-data="{ open: @entangle('enableReferSystem') }">
                        <x-input title="Refer Amount" name="referRewardAmount" />
                    </div>
                    <div></div>
                    <div class="block mt-4 text-sm">
                        <p>Multiple Stops(Parcel Delivery)</p>
                        <x-checkbox title="Enable" name="enableParcelMultipleStops" :defer="true" />
                    </div>
                    <div class="block mt-4 text-sm">
                        <x-input title="Max Stops(Parcel Delivery)" name="maxParcelStops" type="number" />
                    </div>
                </div>

                {{-- App Layout --}}
                <p class="pt-4 mt-10 text-2xl border-t">App Layout</p>
                <div class='grid grid-cols-1 gap-4 mb-10 md:grid-cols-2 lg:grid-cols-3'>
                    <div class="block mt-4 text-sm">
                        <p>Enable Parcel Delivery</p>
                        <x-checkbox title="Enable" name="enableParcel" :defer="true" />
                    </div>
                    <div class="block mt-4 text-sm">
                        <p>Enable Food/Grocery Delivery</p>
                        <x-checkbox title="Enable" name="enableFood" :defer="true" />
                    </div>
                    <div class="block mt-4 text-sm">
                        <p>Single-Vendor Mode</p>
                        <x-checkbox title="Enable" name="enableSingleVendor" :defer="true" />
                    </div>
                    <div class="block mt-4 text-sm">
                        <p>Proof of delivery by delivery boy</p>
                        <x-checkbox title="Enable" name="enableProofOfDelivery" :defer="true" />
                    </div>
                    <div class="block mt-4 text-sm">
                        <p>Grocery mode (+/- by the product item)</p>
                        <x-checkbox title="Enable" name="enableGroceryMode" :defer="true" />
                    </div>
                    <div class="block mt-4 text-sm">
                        <p>Chat Option</p>
                        <x-checkbox title="Enable" name="enableChat" :defer="true" />
                    </div>
                    <div class="block mt-4 text-sm">
                        <p>Webview Direction (Payments etc)</p>
                        <x-select title="" :options="['LTR','RTL']" name="webviewDirection" :defer="true" />
                    </div>
                </div>



                <p class="pt-4 mt-4 text-2xl border-t">Theme</p>
                <p class="mt-4 text-lg border-b">Main Colors</p>
                <div class='grid grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-3'>
                    <x-input title="Accent Color" name="accentColor" type="color" class="h-10" />
                    <x-input title="Primary Color" name="primaryColor" type="color" class="h-10" />
                    <x-input title="Primary Dark Color" name="primaryColorDark" type="color" class="h-10" />
                </div>
                {{-- other --}}
                <p class="mt-4 text-lg border-b">Onboarding Colors</p>
                <div class='grid grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-3'>
                    <x-input title="Onboarding Page 1 Background Color" name="onboarding1Color" type="color"
                        class="h-10" />
                    <x-input title="Onboarding Page 2 Background Color" name="onboarding2Color" type="color"
                        class="h-10" />
                    <x-input title="Onboarding Page 3 Background Color" name="onboarding3Color" type="color"
                        class="h-10" />
                    {{-- next --}}
                    <x-input title="Onboarding Indicator Dot Color" name="onboardingIndicatorDotColor" type="color"
                        class="h-10" />
                    <x-input title="Onboarding Indicator Active Dot Color" name="onboardingIndicatorActiveDotColor"
                        type="color" class="h-10" />
                </div>
                <p class="mt-4 text-lg border-b">Order Status Colors</p>
                <div class='grid grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-3'>
                    <x-input title="Open Color" name="openColor" type="color" class="h-10" />
                    <x-input title="Close Color" name="closeColor" type="color" class="h-10" />
                    <x-input title="Delivery Color" name="deliveryColor" type="color" class="h-10" />
                    <x-input title="Pickup Color" name="pickupColor" type="color" class="h-10" />
                    <x-input title="Rating Color" name="ratingColor" type="color" class="h-10" />
                </div>
                <p class="mt-4 text-lg border-b">Order Status Colors</p>
                <div class='grid grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-3'>
                    {{-- other status colors --}}
                    <x-input title="Pending Color" name="pendingColor" type="color" class="h-10" />
                    <x-input title="Preparing Color" name="preparingColor" type="color" class="h-10" />
                    <x-input title="Enroute Color" name="enrouteColor" type="color" class="h-10" />
                    <x-input title="Failed Color" name="failedColor" type="color" class="h-10" />
                    <x-input title="Cancelled Color" name="cancelledColor" type="color" class="h-10" />
                    <x-input title="Delivered Color" name="deliveredColor" type="color" class="h-10" />
                    <x-input title="Successful Color" name="successfulColor" type="color" class="h-10" />
                </div>
                <x-buttons.primary title="Save Changes" />
                <div>
        </x-form>

    </x-baseview>

</div>
