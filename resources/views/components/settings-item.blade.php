<div class="flex items-center p-4 text-lg bg-white border rounded cursor-pointer hover:shadow-md" wire:click='{{ $wireClick ?? '' }}' >
    {{ $slot ?? '' }}
    {{ $title }}
</div>
