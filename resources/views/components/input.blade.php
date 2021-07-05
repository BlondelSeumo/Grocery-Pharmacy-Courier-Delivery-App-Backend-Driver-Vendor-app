<label class="block mt-4 text-sm">
    <span class="text-gray-700">{{ $title ?? '' }}</span>
    <input {{ $attributes->merge(['class' => 'block w-full p-2 mt-1 text-sm border border-gray-300 rounded focus:border-primary-400 focus:outline-none focus:shadow-outline-primary']) }}

      placeholder="{{ $placeholder ?? '' }}"
      type="{{ $type ?? 'text' }}"
      id='{{ $name ?? '' }}'
      @if ( $defer ?? true )
        wire:model.defer='{{ $name ?? '' }}'
      @else
        wire:model='{{ $name ?? '' }}'
      @endif

    />
    @error($name ?? '')
        <span class="mt-1 text-xs text-red-700">{{ $message }}</span>
    @enderror
  </label>
