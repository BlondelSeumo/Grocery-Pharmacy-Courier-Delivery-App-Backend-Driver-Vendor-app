@section('title', 'Payment Methods')
<div>

    <x-baseview title="Payment Methods">
        <livewire:tables.vendor-payment-method-table />
    </x-baseview>

    {{-- assign form --}}
    <div x-data="{ open: @entangle('showCreate') }">
        <x-modal confirmText="Assign" action="assignPaymentMethods" :clickAway="false">

            <p class="text-xl font-semibold">Assign Payment Methods To Vendor</p>
            <x-select2 title="Managers" :options="$paymentMethods" name="paymentMethodIds" id="paymentMethodSelect2" :multiple="true"
                width="100" :ignore="true" />

        </x-modal>
    </div>
</div>


