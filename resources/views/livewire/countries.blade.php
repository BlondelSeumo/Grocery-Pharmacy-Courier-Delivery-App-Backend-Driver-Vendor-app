@section('title', 'Countries')
    <div>

        <x-baseview title="Countries">
            <livewire:tables.country-table />
        </x-baseview>

        <div x-data="{ open: @entangle('showCreate') }">
            <x-modal confirmText="Save" action="save">
                <p class="text-xl font-semibold">Create Country</p>
                <x-input title="Name" name="name" placeholder="" />
            </x-modal>
        </div>

        <div x-data="{ open: @entangle('showEdit') }">
            <x-modal confirmText="Update" action="update">

                <p class="text-xl font-semibold">Edit Country</p>
                <x-input title="Name" name="name" placeholder="" />


            </x-modal>
        </div>


    </div>
