<label class="block mt-4 text-sm">
    <div class='flex items-start'>

        <input class="mt-1 mr-5"
        placeholder="{{ $placeholder ?? '' }}"
        type="checkbox"
        value="{{ $value ?? '1' }}"
        {{-- {{ ($checked ?? false) ? 'checked':'checked' }} --}}
        @if ( $defer ?? true )
            wire:model.defer='{{ $name ?? '' }}'
        @else
            wire:model='{{ $name ?? '' }}'
        @endif

        />

        <div>
            <p class="font-semibold text-gray-700">{{ $title ?? '' }}</p>
            <p class="text-sm text-gray-600">{{ $description ?? '' }}</p>
        </div>
    </div>
    @error($name ?? '')
        <span class="mt-1 text-xs text-red-700">{{ $message }}</span>
    @enderror
  </label>
