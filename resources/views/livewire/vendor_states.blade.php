@section('title', 'States')
<div>

    <x-baseview title="States">
        <livewire:tables.vendor-state-table />
    </x-baseview>

    <div x-data="{ open: @entangle('showCreate') }">
        <x-modal confirmText="Save" action="save">
            <p class="text-xl font-semibold">New Operation State</p>
            <x-select title="Country" :options='$countries' name="country_id" :defer="false"
                onchange="countryChanged" />
            <x-select title="State" :options='$states' name="state_id" :defer="false" onchange="stateChanged" />
            <x-checkbox title="Active" name="isActive" />
        </x-modal>
    </div>

    <div x-data="{ open: @entangle('showEdit') }">
        <x-modal confirmText="Update" action="update">

            <p class="text-xl font-semibold">Edit Operation City</p>
            <x-select title="Country" :options='$countries' name="country_id" :defer="false" />
            <x-select title="State" :options='$states' name="state_id" :defer="false" />
            <x-checkbox title="Active" name="isActive" />

        </x-modal>
    </div>

</div>
