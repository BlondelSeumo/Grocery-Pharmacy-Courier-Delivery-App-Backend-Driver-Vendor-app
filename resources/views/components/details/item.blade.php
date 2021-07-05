<div>
    <x-label title="{{ $title ?? '' }}" />
    <x-details.p text="{{ $text ?? '' }}" />
    {{ $slot ?? '' }}
</div>
