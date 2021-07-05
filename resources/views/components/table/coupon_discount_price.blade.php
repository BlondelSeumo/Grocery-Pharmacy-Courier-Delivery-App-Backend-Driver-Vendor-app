@php
    if( !empty($data) ){
        $model = $data["model"];
    }
@endphp

@if ( $model->percentage )
    {{ $model->discount_price ?? $model->discount ?? '' }}%
@else
    {{ setting('currency', '$') }}{{ $model->discount_price ?? $model->discount ?? '' }}
@endif

