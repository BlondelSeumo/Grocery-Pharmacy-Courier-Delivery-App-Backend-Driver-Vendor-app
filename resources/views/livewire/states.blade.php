@section('title', 'States')
    <div>

        <x-baseview title="States">
            <livewire:tables.state-table />
        </x-baseview>

        <div x-data="{ open: @entangle('showCreate') }">
            <x-modal confirmText="Save" action="save">
                <p class="text-xl font-semibold">Create State</p>
                <x-select title="Country" :options='$countries' name="country_id" :defer="false" />
                <x-input title="Name" name="name" placeholder="" />
            </x-modal>
        </div>

        <div x-data="{ open: @entangle('showEdit') }">
            <x-modal confirmText="Update" action="update">

                <p class="text-xl font-semibold">Edit State</p>
                <x-select title="Country" :options='$countries' name="country_id" :defer="false" />
                <x-input title="Name" name="name" placeholder="" />


            </x-modal>
        </div>

    </div>
