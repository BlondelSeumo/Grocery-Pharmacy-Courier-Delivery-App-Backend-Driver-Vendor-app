@section('title', 'Notification')
    <div>

        <x-baseview title="Send Notification" showButton="true">

            <x-form backPressed="" action="sendNotification">

                <div class="w-full md:w-4/5 lg:w-6/12">
                    <x-input title="Title" name="headings" />
                    <x-label title="Message" />
                    <textarea wire:model.defer="message" class="w-full h-40 p-2 mt-1 border rounded"></textarea>
                    @error('message')
                        <span class="mt-1 text-xs text-red-700">{{ $message }}</span>
                    @enderror
                    {{-- receiver --}}
                    <div class="grid grid-cols-2 gap-2">
                        <x-checkbox title="All" name="allReceiver" description="Send to all users" :defer="false" />
                        <x-checkbox title="Custom" name="customReceiver" description="Send Directly to roles"
                            :defer="false" />
                    </div>
                    <div class="flex flex-wrap mt-2 mb-6 space-x-5" x-data="{ open: @entangle('customReceiver') }" x-show="open">
                        @foreach ($roles as $key => $role)
                            <x-checkbox title="{{ $role->name }}" name="customReceiverRoles.{{ $key }}" value="{{ $role->name }}" :defer="false" />
                        @endforeach
                    </div>
                    <x-buttons.primary title="Send Notification" />
                    <div>

            </x-form>

        </x-baseview>


    </div>
