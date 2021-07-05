<div class="flex items-center space-x-2">
    <x-buttons.show :model="$model" />

    @if ($model->vendor->has_sub_categories ?? false)
        <x-buttons.plain wireClick="$emit('initiateSubcategoriesAssign', {{ $model->id }} )" title="">
            <x-heroicon-o-document-duplicate class="w-5 h-5 mr-2" />
            <span class="">Subcategories</span>
        </x-buttons.plain>

    @else
        <x-buttons.plain wireClick="$emit('initiateAssign', {{ $model->id }} )" title="">
            <x-heroicon-o-book-open class="w-5 h-5 mr-2" />
            <span class="">Menu</span>
        </x-buttons.plain>
    @endif
    <x-buttons.edit :model="$model" />
    @if ($model->is_active)
        <x-buttons.deactivate :model="$model" />
    @else
        <x-buttons.activate :model="$model" />
    @endif
    <x-buttons.delete :model="$model" />
</div>
