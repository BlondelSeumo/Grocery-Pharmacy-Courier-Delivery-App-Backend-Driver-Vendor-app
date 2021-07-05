@section('title', 'Earning '.Str::ucfirst($type))
<div>

    <x-baseview title="Earning {{ Str::ucfirst($type) }}">
        {{-- <livewire:tables.earning-table /> --}}
        @livewire('tables.earning-table', [
            "type" => $type
        ])
    </x-baseview>

    {{-- payout --}}
    <div x-data="{ open: @entangle('showCreate') }">
        <x-modal confirmText="Payout" action="payout">
            <p class="text-xl font-semibold">Pay {{ Str::ucfirst(Str::singular($type ?? '')) }}</p>
            <x-input title="Amount" name="amount" placeholder="10" />
            <x-select title="Payment Method" :options="$paymentMethods" name="payment_method_id" />
            <x-input title="Note" name="note" placeholder="" />
        </x-modal>
    </div>


</div>


