<div class="px-4">
    <p class="text-2xl font-semibold">{{ $title ?? 'List' }}</p>
    {{-- list --}}
    {{ $slot }}


</div>
{{-- loading --}}
<div wire:loading class="fixed top-0 bottom-0 left-0 z-50 w-full h-full ">
    <div class="fixed top-0 bottom-0 left-0 w-full h-full bg-black opacity-75"></div>
    <div class="fixed top-0 bottom-0 left-0 flex items-center justify-center w-full h-full">
        <img src="{{ asset('images/loading.svg') }}" class="" />
    </div>
</div>
