@section('title', 'Options Group')
<div>

    <x-baseview title="Options Group">
        <livewire:tables.options-group-table />
    </x-baseview>

    {{--  new form  --}}
    <div x-data="{ open: @entangle('showCreate') }">
        <x-modal confirmText="Save" action="save">
            <p class="text-xl font-semibold">Create Option Group</p>

            <x-input title="Name" name="name" />
            <x-checkbox title="Multiple" description="Allow customers to select multiple options under this option group" name="multiple" :defer="false" />
            <x-checkbox title="Active" name="isActive" :defer="false" />

        </x-modal>
    </div>

    {{--  update form  --}}
    <div x-data="{ open: @entangle('showEdit') }">
        <x-modal confirmText="Update" action="update">
            <p class="text-xl font-semibold">Update Option Group</p>

            <x-input title="Name" name="name" />
            <x-checkbox title="Multiple" description="Allow customers to select multiple options under this option group" name="multiple" :defer="false" />
            <x-checkbox title="Active" name="isActive" :defer="false" />

        </x-modal>
    </div>

</div>

