@section('title', 'Cities')
    <div>

        <x-baseview title="Cities">
            <livewire:tables.vendor-city-table />
        </x-baseview>

        <div x-data="{ open: @entangle('showCreate') }">
            <x-modal confirmText="Save" action="save">
                <p class="text-xl font-semibold">New Operation City</p>
                <x-select title="Country" :options='$countries' name="country_id" :defer="false" onchange="countryChanged" />
                <x-select title="State" :options='$states' name="state_id" :defer="false" onchange="stateChanged" />
                <x-select title="City" :options='$cities' name="city_id" :defer="false" />
                <x-checkbox title="Active" name="isActive" />
            </x-modal>
        </div>

        <div x-data="{ open: @entangle('showEdit') }">
            <x-modal confirmText="Update" action="update">

                <p class="text-xl font-semibold">Edit Operation City</p>
                <x-select title="Country" :options='$countries' name="country_id" :defer="false" />
                <x-select title="State" :options='$states' name="state_id" :defer="false" />
                <x-select title="City" :options='$cities' name="city_id" :defer="false" />
                <x-checkbox title="Active" name="isActive" />

            </x-modal>
        </div>

    </div>
