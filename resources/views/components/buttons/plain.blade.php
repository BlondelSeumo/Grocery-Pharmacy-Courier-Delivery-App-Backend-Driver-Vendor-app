<button
    class="flex items-center p-2 text-sm font-medium leading-5 text-center text-white transition-colors duration-150 {{ $bgColor ?? 'bg-gray-600' }} border border-transparent rounded-lg active:bg-gray-600 hover:{{ $bgColor ?? 'bg-gray-600' }} focus:outline-none focus:shadow-outline-gray"
    wire:click="{{ $wireClick }}"
    title="{{ $title ?? '' }}">
    {{ $slot ?? '' }}
</button>
