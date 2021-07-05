@section('title', 'Cities')
    <div>

        <x-baseview title="Cities">
            <livewire:tables.city-table />
        </x-baseview>

        <div x-data="{ open: @entangle('showCreate') }">
            <x-modal confirmText="Save" action="save">
                <p class="text-xl font-semibold">Create City</p>
                <x-select title="Country" :options='$countries' name="country_id" :defer="false" />
                <x-select title="State" :options='$states' name="state_id" :defer="false" />
                <x-input title="Name" name="name" placeholder="" />
            </x-modal>
        </div>

        <div x-data="{ open: @entangle('showEdit') }">
            <x-modal confirmText="Update" action="update">

                <p class="text-xl font-semibold">Edit City</p>
                <x-select title="Country" :options='$countries' name="country_id" :defer="false" />
                <x-select title="State" :options='$states' name="state_id" :defer="false" />
                <x-input title="Name" name="name" placeholder="" />


            </x-modal>
        </div>

    </div>
