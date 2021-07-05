@section('title','System Upgrade')
<div>

    <x-baseview title="System Update">

        <div class="grid grid-cols-1 gap-6 mt-10 md:grid-cols-2 lg:grid-cols-3">

            {{-- update --}}
            <x-settings-item title="Update System" wireClick="upgradeAppSystem" >
                <x-heroicon-o-cloud-upload class="w-5 h-5 mr-4" />
            </x-settings-item>

            {{-- roll back --}}
            <x-settings-item title="Roll Back Update" wireClick="showEditModal" >
                <x-heroicon-o-sort-descending class="w-5 h-5 mr-4" />
            </x-settings-item>

            {{-- terminal --}}
            <x-settings-item title="Terminal" wireClick="showCreateModal" >
                <x-heroicon-o-terminal class="w-5 h-5 mr-4" />
            </x-settings-item>

        </div>


        {{--  rollback upgrade  --}}
        <div x-data="{ open: @entangle('showEdit') }">
            <x-modal confirmText="Run" action="rollBackUpgrade">
                <p class="text-xl font-semibold">Rollback Version</p>
                <p class="my-5 text-sm font-semibold text-red-500">This is only to rollback the versison code, so you can re-run the upgrade script again</p>
                <x-select title="Version Code" :options='$verisonCodes' name="verison_code" :defer="true" />
            </x-modal>
        </div>

        {{--  normal upgrade  --}}
        <div x-data="{ open: @entangle('showCreate') }">
            <x-modal confirmText="Run" action="runTerminalCommand">
                <p class="text-xl font-semibold">Terminal</p>
                <p class="my-5 text-sm font-semibold text-red-500">Be very careful when using terminal. Only run verified commands here</p>
                <textarea class="w-full h-56 p-2 text-white bg-gray-800 border-gray-200" placeholder="Use with care" wire:model.defer="terminalCommand"></textarea>
                <div class="py-2 text-sm text-red-500 border-t">
                    {{ $terminalError }}
                </div>
            </x-modal>
        </div>


    </x-baseview>


</div>
