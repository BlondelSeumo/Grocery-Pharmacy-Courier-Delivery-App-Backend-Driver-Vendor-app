@if ($model->amount > 0)
    <button
        class="flex items-center p-2 text-sm font-medium leading-5 text-center text-white transition-colors duration-150 bg-green-600 border border-transparent rounded-lg active:bg-green-600 hover:bg-green-700 focus:outline-none focus:shadow-outline-green"
        wire:click="$emit('initiatePayout', {{ $model->id }} )" title="Payout">
        <x-heroicon-o-cash class="w-5 h-5 mr-2" /> Payout
    </button>
@else
    <p class="text-sm italic text-gray-400">Nothinng to Payout</p>
@endif
