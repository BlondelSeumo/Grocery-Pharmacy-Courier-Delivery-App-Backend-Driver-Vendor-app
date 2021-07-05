<ul class="mt-6">


    {{-- dashboard --}}
    <x-menu-item title="Dashboard" route="dashboard">
        <x-heroicon-o-template class="w-5 h-5" />
    </x-menu-item>

    @role('admin')
        <x-menu-item title="Banners" route="banners">
            <x-heroicon-o-photograph class="w-5 h-5" />
        </x-menu-item>


        <x-group-menu-item routePath="categories*" title="Categories" categories="true">

            <x-menu-item title="Categories" route="categories">
                <x-heroicon-o-folder class="w-5 h-5" />
            </x-menu-item>
            <x-menu-item title="SubCategories" route="subcategories">
                <x-heroicon-o-document-duplicate class="w-5 h-5" />
            </x-menu-item>
        </x-group-menu-item>
    @endrole

    {{-- Vendors --}}
    <x-menu-item title="Vendors" route="vendors">
        <x-heroicon-o-shopping-cart class="w-5 h-5" />
    </x-menu-item>
    @role('manager')
        <x-menu-item title="Delivery Boys" route="drivers">
            <x-heroicon-o-user-group class="w-5 h-5" />
        </x-menu-item>
    @endhasanyrole

    @role('admin')
        <x-menu-item title="Reviews" route="reviews">
            <x-heroicon-o-thumb-up class="w-5 h-5" />
        </x-menu-item>
    @endrole



    {{-- Products --}}
    @showProduct
        <x-group-menu-item routePath="product/*" title="Products" products="true">

            <x-menu-item title="Products" route="products">
                <x-heroicon-o-archive class="w-5 h-5" />
            </x-menu-item>

            <x-menu-item title="Menus" route="products.menus">
                <x-heroicon-o-book-open class="w-5 h-5" />
            </x-menu-item>

            <x-menu-item title="Option Groups" route="products.options.group">
                <x-heroicon-o-collection class="w-5 h-5" />
            </x-menu-item>

            <x-menu-item title="Options" route="products.options">
                <x-heroicon-o-dots-horizontal class="w-5 h-5" />
            </x-menu-item>
            @role('admin')
                <x-menu-item title="Favourites" route="favourites">
                    <x-heroicon-o-star class="w-5 h-5" />
                </x-menu-item>
            @endrole
        </x-group-menu-item>
    @endshowProduct

    {{-- Package --}}
    @showPackage
        <x-group-menu-item routePath="package/*" title="Package Delivery" package="true">

            @hasanyrole('city-admin|admin')
                <x-menu-item title="Package Types" route="package.types">
                    <x-heroicon-o-archive class="w-5 h-5" />
                </x-menu-item>

                <x-menu-item title="Countries" route="package.countries">
                    <x-heroicon-o-globe class="w-5 h-5" />
                </x-menu-item>

                <x-menu-item title="States" route="package.states">
                    <x-heroicon-o-globe-alt class="w-5 h-5" />
                </x-menu-item>

                <x-menu-item title="Cities" route="package.cities">
                    <x-heroicon-o-map class="w-5 h-5" />
                </x-menu-item>
            @endhasanyrole

            {{-- manager package delivery options --}}
            @role('manager')
                <x-menu-item title="Pricing" route="package.pricing">
                    <x-heroicon-o-currency-dollar class="w-5 h-5" />
                </x-menu-item>

                <x-menu-item title="Cities" route="package.cities.my">
                    <x-heroicon-o-location-marker class="w-5 h-5" />
                </x-menu-item>

                <x-menu-item title="States" route="package.states.my">
                    <x-heroicon-o-globe-alt class="w-5 h-5" />
                </x-menu-item>

                <x-menu-item title="Countries" route="package.countries.my">
                    <x-heroicon-o-globe class="w-5 h-5" />
                </x-menu-item>

            @endhasanyrole

        </x-group-menu-item>

    @endshowPackage

    {{-- orders --}}
    <x-group-menu-item routePath="order/*" title="Orders" orders="true">

        <x-menu-item title="Orders" route="orders">
            <x-heroicon-o-shopping-bag class="w-5 h-5" />
        </x-menu-item>
        @hasanyrole('city-admin|admin')
            <x-menu-item title="Delivery Address" route="delivery.addresses">
                <x-heroicon-o-location-marker class="w-5 h-5" />
            </x-menu-item>
        @endhasanyrole

    </x-group-menu-item>

    @hasanyrole('city-admin|admin')
        <x-menu-item title="Coupons" route="coupons">
            <x-heroicon-o-receipt-tax class="w-5 h-5" />
        </x-menu-item>

    @endhasanyrole

    {{-- Users --}}
    @hasanyrole('city-admin|admin')
        <x-menu-item title="Users" route="users">
            <x-heroicon-o-user-group class="w-5 h-5" />
        </x-menu-item>
    @endhasanyrole

    @hasanyrole('admin')

        {{-- wallet transactions --}}
        <x-menu-item title="Wallet Transactions" route="wallet.transactions">
            <x-heroicon-o-collection class="w-5 h-5" />
        </x-menu-item>

    @endhasanyrole

    {{-- Earings --}}
    <x-group-menu-item routePath="earnings/*" title="Earnings" earnings="true">
        @hasanyrole('city-admin|admin')
            <x-menu-item title="Vendor Earnings" route="earnings.vendors">
                <x-heroicon-o-shopping-bag class="w-5 h-5" />
            </x-menu-item>
        @endhasanyrole

        <x-menu-item title="Driver Earnings" route="earnings.drivers">
            <x-heroicon-o-truck class="w-5 h-5" />
        </x-menu-item>

    </x-group-menu-item>

    {{-- Payouts --}}
    <x-group-menu-item routePath="payouts*" title="Payouts" payouts="true">
        @hasanyrole('city-admin|admin')
            <x-menu-item title="Vendor Payouts" route="payouts"
                rawRoute="{{ route('payouts', ['type' => 'vendors']) }}">
                <x-heroicon-o-shopping-bag class="w-5 h-5" />
            </x-menu-item>
        @endhasanyrole
        <x-menu-item title="Driver Payouts" route="payouts"
            rawRoute="{{ route('payouts', ['type' => 'drivers']) }}">
            <x-heroicon-o-truck class="w-5 h-5" />
        </x-menu-item>

    </x-group-menu-item>

    {{-- Payment methods --}}
    @hasanyrole('manager')
        <x-menu-item title="Payment Methods" route="payment.methods.my">
            <x-heroicon-o-cash class="w-5 h-5" />
        </x-menu-item>
    @endhasanyrole


    @hasanyrole('admin')
        {{-- notifications --}}
        <x-menu-item title="Notifications" route="notification.send">
            <x-heroicon-o-bell class="w-5 h-5" />
        </x-menu-item>
        <x-group-menu-item routePath="operations/*" title="Operations" icon="heroicon-o-server">

            {{-- backups --}}
            <x-menu-item title="Backup" route="backups">
                <x-heroicon-o-database class="w-5 h-5" />
            </x-menu-item>

            {{-- import --}}
            <x-menu-item title="Import" route="imports">
                <x-heroicon-o-cloud-upload class="w-5 h-5" />
            </x-menu-item>

            {{-- logs --}}
            <x-menu-item title="Logs" route="logs" ex="true">
                <x-heroicon-o-shield-exclamation class="w-5 h-5" />
            </x-menu-item>
        </x-group-menu-item>


        {{-- Settings --}}
        <x-group-menu-item routePath="setting/*" title="Settings" icon="heroicon-o-cog">

            {{-- Currencies --}}
            <x-menu-item title="Currencies" route="currencies">
                <x-heroicon-o-currency-dollar class="w-5 h-5" />
            </x-menu-item>

            {{-- Payment methods --}}
            <x-menu-item title="Payment Methods" route="payment.methods">
                <x-heroicon-o-cash class="w-5 h-5" />
            </x-menu-item>

            {{-- App Settings --}}
            <x-menu-item title="Mobile App Settings" route="settings.app">
                <x-heroicon-o-device-mobile class="w-5 h-5" />
            </x-menu-item>

            {{-- Settings --}}
            <x-menu-item title="General Settings" route="settings">
                <x-heroicon-o-cog class="w-5 h-5" />
            </x-menu-item>

            {{-- Mail Settings --}}
            <x-menu-item title="Server Settings" route="settings.server">
                <x-heroicon-o-server class="w-5 h-5" />
            </x-menu-item>

            {{-- translation --}}
            <x-menu-item title="Translation" route="translation">
                <x-heroicon-o-translate class="w-5 h-5" />
            </x-menu-item>

            {{-- upgrade --}}
            <x-menu-item title="Upgrade" route="upgrade">
                <x-heroicon-o-cloud-upload class="w-5 h-5" />
            </x-menu-item>
        </x-group-menu-item>
    @endhasanyrole



</ul>
