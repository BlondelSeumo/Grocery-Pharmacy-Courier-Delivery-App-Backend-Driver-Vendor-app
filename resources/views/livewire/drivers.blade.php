@section('title', 'Users')
<div>

    <x-baseview title="Delivery Boys">
        <livewire:tables.driver-table />
    </x-baseview>

    <div x-data="{ open: @entangle('showCreate') }">
        <x-modal confirmText="Save" action="save">
            <p class="text-xl font-semibold">Create User Account</p>
            <x-input title="Name" name="name" placeholder="John" />
            <x-input title="Email" name="email" placeholder="info@mail.com" />
            <x-input title="Phone" name="phone" placeholder="" />
            <x-input title="Login Password" name="password" type="password" placeholder="**********************" />
            <x-input title="Commission" name="commission" placeholder="" />
            <x-input title="Wallet Balance" name="walletBalance" placeholder="" />
        </x-modal>
    </div>

    <div x-data="{ open: @entangle('showEdit') }">
        <x-modal confirmText="Update" action="update">

            <p class="text-xl font-semibold">Edit User Account</p>
            <x-input title="Name" name="name" placeholder="John" />
            <x-input title="Email" name="email" placeholder="info@mail.com" />
            <x-input title="Phone" name="phone" placeholder="" />
            <x-input title="Login Password" name="password" type="password" placeholder="**********************" />
            <x-input title="Commission" name="commission" placeholder="" />
            <x-input title="Wallet Balance" name="walletBalance" placeholder="" />

        </x-modal>
    </div>
</div>


