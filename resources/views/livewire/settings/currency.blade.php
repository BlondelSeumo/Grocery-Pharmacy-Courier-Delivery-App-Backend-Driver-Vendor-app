@section('title', 'Settings')
<div>

    <x-baseview title="Currencies">
        <livewire:tables.currency-table />
    </x-baseview>

    <div x-data="{ open: @entangle('showCreate') }">
        <x-modal confirmText="Save" action="save">
            <p class="text-xl font-semibold">New Currency</p>
            <x-input title="Name" name="name" />
            <x-input title="Code" name="code" />
            <x-input title="Country Code" name="country_code" />
            <x-input title="Symbol" name="symbol" />
        </x-modal>
    </div>

    <div x-data="{ open: @entangle('showEdit') }">
        <x-modal confirmText="Update" action="update">
            <p class="text-xl font-semibold">Edit Currency</p>
            <x-input title="Name" name="name" />
            <x-input title="Code" name="code" />
            <x-input title="Country Code" name="country_code" />
            <x-input title="Symbol" name="symbol" />
        </x-modal>
    </div>

</div>
