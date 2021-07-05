<div class="flex items-center space-x-2">


    <x-buttons.edit :model="$model" />
    @if( setting('currencyCode', 'USD') == $model->code )
        <span class="p-2 text-gray-600 border rounded-md">Activated</span>
    @else
        <x-buttons.activate :model="$model" />
    @endif



</div>
