@section('title', 'Order Payment')
    <div class="">
        <div class="w-11/12 p-12 mx-auto mt-20 text-center border rounded shadow md:w-6/12 lg:w-4/12">
            @if ($error)
                <x-heroicon-o-emoji-sad class="w-12 h-12 mx-auto text-red-500 md:h-24 md:w-24" />
                <p class="text-xl font-medium text-center">Payment Failed</p>
                <p>{{ $errorMessage }}</p>
            @else
                <x-heroicon-o-emoji-happy class="w-12 h-12 mx-auto text-green-500 md:h-24 md:w-24" />
                <p class="text-xl font-medium text-center">Payment Successful</p>
                <p>Order Payment was successful</p>
            @endif

        </div>

        {{-- close --}}
        <p class="w-full p-4 text-sm text-center text-gray-500">You may close this window</p>
    </div>
