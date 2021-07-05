<button class="flex items-center justify-center w-full px-4 py-2 {{ ($noMargin ?? false) ? 'mt-0':'mt-4' }} text-sm font-medium leading-5 text-center text-white transition-colors duration-150 border border-transparent rounded-lg bg-primary-600 active:bg-primary-600 hover:bg-primary-700 focus:outline-none focus:shadow-outline-primary" wire:click="{{ $wireClick ?? '' }}">
    {{ $slot ?? '' }}
    {{ $title ?? '' }}
</button>
