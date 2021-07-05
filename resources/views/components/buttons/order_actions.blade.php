<div class="flex items-center space-x-2">
    <x-buttons.show :model="$model" />
    @if (!in_array($model->status, ['failed', 'delivered', 'cancelled']))
        <x-buttons.edit :model="$model" />
    @endif

    @if (in_array($model->payment_status, ['review']))
        <x-buttons.review :model="$model" />
    @endif
</div>
