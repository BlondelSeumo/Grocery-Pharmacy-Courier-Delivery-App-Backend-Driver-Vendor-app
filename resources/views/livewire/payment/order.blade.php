@section('title', 'Order Payment')
@if($selectedModel->payment_method->slug != 'offline')
    <div class="" wire:init="initPayment">
        <div class="w-11/12 p-12 mx-auto mt-20 border rounded shadow md:w-6/12 lg:w-4/12">
            <x-heroicon-o-clock class="w-12 h-12 mx-auto text-gray-400 md:h-24 md:w-24" />
            <p class="text-xl font-medium text-center">Order Payment</p>
            <p class="text-sm text-center">Please wait while we process your payment</p>
            @if( $selectedModel->payment_method->slug == "paypal" )
                <div id="paypal-button-container" class="py-12"></div>
            @endif
        </div>

        {{-- close --}}
        <p class="w-full p-4 text-sm text-center text-gray-500">Do not close this window</p>
    </div>

@else
    @include('livewire.payment.offline.order')
@endif
@push('scripts')
    @if($selectedModel->payment_method->slug == 'stripe')
        <script src="https://js.stripe.com/v3/"></script>
    @elseif( $selectedModel->payment_method->slug == "razorpay" )
        <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    @elseif( $selectedModel->payment_method->slug == "flutterwave" )
        <script src="https://checkout.flutterwave.com/v3.js"></script>
    @elseif( $selectedModel->payment_method->slug == "paystack" )
        <script src="https://js.paystack.co/v1/inline.js"></script>
    @elseif( $selectedModel->payment_method->slug == "billplz" )
        <script src="https://js.paystack.co/v1/inline.js"></script>
    @elseif( $selectedModel->payment_method->slug == "paypal" )
        <script src="https://www.paypal.com/sdk/js?client-id={{ $selectedModel->payment_method->public_key }}&currency={{ setting('currencyCode', 'USD') }}&intent=capture">
        </script>
    @endif

    <script src="{{ asset('js/payment.js') }}"></script>
@endpush
