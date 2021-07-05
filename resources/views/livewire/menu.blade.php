@section('title', 'Menu')
<div>

    <x-baseview title="Menu">
        <livewire:tables.menu-table />
    </x-baseview>

    {{--  new form  --}}
    <div x-data="{ open: @entangle('showCreate') }">
        <x-modal confirmText="Save" action="save">
            <p class="text-xl font-semibold">Create Menu</p>

            <x-input title="Name" name="name" />
            <x-checkbox title="Active" name="isActive" :defer="false" />

        </x-modal>
    </div>

    {{--  update form  --}}
    <div x-data="{ open: @entangle('showEdit') }">
        <x-modal confirmText="Update" action="update">
            <p class="text-xl font-semibold">Update Menu</p>

            <x-input title="Name" name="name" />
            <x-checkbox title="Active" name="isActive" :defer="false" />

        </x-modal>
    </div>

</div>

