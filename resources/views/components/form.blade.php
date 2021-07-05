@if (!empty($backPressed) ?? false)
    <div class="w-24 ml-auto">
        <x-buttons.primary title="Back" :wireClick="$backPressed">
            <x-heroicon-o-arrow-left class="w-5 h-5 mr-2" />
        </x-buttons.primary>
    </div>
@endif
<form wire:submit.prevent="{{ $action ?? '' }}"
    class="{{ $noClass ?? false ? '' : 'p-4 my-5 bg-white rounded shadow' }}">
    {{ $slot }}
</form>
