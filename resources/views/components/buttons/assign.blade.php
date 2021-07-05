<button
    class="flex items-center p-2 text-sm font-medium leading-5 text-center text-white transition-colors duration-150 bg-blue-600 border border-transparent rounded-lg active:bg-blue-600 hover:bg-blue-700 focus:outline-none focus:shadow-outline-blue"
    wire:click="$emitUp('initiateAssign', {{ $model->id }} ) "
    title="Assign">
    <x-heroicon-o-user-add class="w-5 h-5"/>
</button>
