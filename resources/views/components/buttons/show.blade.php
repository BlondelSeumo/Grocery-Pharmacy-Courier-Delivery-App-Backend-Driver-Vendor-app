<button
    class="flex items-center p-2 text-sm font-medium leading-5 text-center text-white transition-colors duration-150 bg-yellow-600 border border-transparent rounded-lg active:bg-yellow-600 hover:bg-yellow-700 focus:outline-none focus:shadow-outline-yellow"
    wire:click="$emit('showDetailsModal', {{ $model->id }} ) ">
    <x-heroicon-o-eye class="w-5 h-5"/>
</button>
