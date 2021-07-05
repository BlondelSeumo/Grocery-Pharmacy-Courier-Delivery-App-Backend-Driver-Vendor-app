<div class="flex items-center p-5 {{ $bg ?? 'bg-red-100' }} border rounded shadow-lg">
    <div class="w-full">
        <p class="text-sm font-medium">{{ $title }}</p>
        <p class="text-2xl font-semibold">{{ $value }}</p>
    </div>
    {{ $slot }}
</div>
