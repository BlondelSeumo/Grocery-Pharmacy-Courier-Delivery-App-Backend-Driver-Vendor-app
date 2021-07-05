@section('title', 'Countries')
    <div>

        <x-baseview title="Countries">
            <livewire:tables.vendor-country-table />
        </x-baseview>

        <div x-data="{ open: @entangle('showCreate') }">
            <x-modal confirmText="Save" action="save">
                <p class="text-xl font-semibold">New Operation Country</p>
                <x-select title="Country" :options='$countries' name="country_id" :defer="false" onchange="countryChanged" />
                <x-checkbox title="Active" name="isActive" />
            </x-modal>
        </div>

        <div x-data="{ open: @entangle('showEdit') }">
            <x-modal confirmText="Update" action="update">

                <p class="text-xl font-semibold">Edit Operation Country</p>
                <x-select title="Country" :options='$countries' name="country_id" :defer="false" />
                <x-checkbox title="Active" name="isActive" />

            </x-modal>
        </div>

    </div>
