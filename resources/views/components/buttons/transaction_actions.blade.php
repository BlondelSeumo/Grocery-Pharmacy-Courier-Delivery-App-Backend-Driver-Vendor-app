<div class="flex items-center space-x-2">

    @if (in_array($model->status, ['review']))
        <x-buttons.deactivate :model="$model" />
        <x-buttons.activate :model="$model" />
    @endif


</div>
