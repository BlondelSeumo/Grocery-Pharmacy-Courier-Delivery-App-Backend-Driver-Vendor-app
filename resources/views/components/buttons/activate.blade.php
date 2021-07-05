<button class="flex items-center p-2 text-sm font-medium leading-5 text-center text-white transition-colors duration-150 bg-green-600 border border-transparent rounded-lg active:bg-green-600 hover:bg-green-700 focus:outline-none focus:shadow-outline-green"
 wire:click="initiateActivate({{ $model->id ?? $id ?? '' }})"
    title="Activate">
    <x-heroicon-o-check class="w-5 h-5"/>
</button>
