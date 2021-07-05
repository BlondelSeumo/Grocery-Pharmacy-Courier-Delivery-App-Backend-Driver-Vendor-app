@if ( $model->is_active ?? false )
    <span class="px-2 py-1 text-sm font-medium text-center text-white bg-green-500 rounded-xl">Active</span>
@else
    <span class="px-2 py-1 text-sm font-medium text-center text-white bg-red-500 rounded-xl">Inactive</span>
@endif
