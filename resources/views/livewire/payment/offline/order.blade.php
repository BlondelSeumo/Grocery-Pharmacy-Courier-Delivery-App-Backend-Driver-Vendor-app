<div>
    <div class="">

        <div wire:loading.flex>
            <div class="w-11/12 p-12 mx-auto mt-10 border rounded shadow md:w-6/12 lg:w-4/12">
                <x-heroicon-o-clock class="w-12 h-12 mx-auto text-gray-400 md:h-24 md:w-24" />
                <p class="text-xl font-medium text-center">Order Payment</p>
                <p class="text-sm text-center">Please wait while we process your payment</p>
            </div>
        </div>

        <div wire:loading.remove.saveOfflinePayment
            class="w-11/12 p-4 mx-auto mt-10 border rounded shadow md:w-6/12 lg:w-4/12 md:grid-cols-2">

            {{-- form --}}
            <div class="{{ $done ? 'hidden' : 'block' }}">
                <div class="flex items-center pb-1 my-1 border-b">
                    <div class="">
                        Order Payment
                    </div>
                    <div class="ml-auto text-right">
                        <p class="text-2xl font-bold">{{ setting('currency') . '' . $selectedModel->total }}</p>
                        <p class="text-sm font-light">{{ $selectedModel->payment_method->name }}</p>
                    </div>
                </div>
                {{-- instruction --}}
                <p class="mt-1 text-lg font-medium">Instructions</p>
                <p class="text-md">{!! nl2br(e($selectedModel->payment_method->instruction)) !!}</p>

                <p class="pt-2 mt-2 text-lg font-medium border-t">Payment Details</p>
                {{-- form --}}
                <x-form action="saveOfflinePayment" :noClass="true">
                    <x-input title="Transaction Code" name="paymentCode" />
                    <x-media-upload title="Transaction Photo" name="photo" :photo="$photo" :photoInfo="$photoInfo"
                        types="PNG or JPEG" rules="image/*" />
                    <x-buttons.primary title="Submit" />
                </x-form>
            </div>


            {{-- completed --}}
            <div class="{{ $done ? 'block' : 'hidden' }}">
                <x-heroicon-o-emoji-sad
                    class="w-12 h-12 mx-auto {{ $error ? 'text-red-500' : 'text-green-500' }} md:h-24 md:w-24" />
                {{-- <p class="text-xl font-medium text-center">Payment Failed</p> --}}
                <p class="text-sm font-medium text-center">{{ $errorMessage }}</p>
            </div>

        </div>





        {{-- close --}}
        <p class="{{ $done ? 'block' : 'hidden' }} w-full p-4 text-sm text-center text-gray-500">You can close this window</p>
        <p class="{{ $done ? 'hidden' : 'block' }} w-full p-4 text-sm text-center text-gray-500">Do not close this window</p>
    </div>
</div>
