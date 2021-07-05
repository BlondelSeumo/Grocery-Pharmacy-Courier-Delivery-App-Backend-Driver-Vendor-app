@section('title', 'Options')
<div>

    <x-baseview title="Options">
        <livewire:tables.option-table />
    </x-baseview>

    {{--  new form  --}}
    <div x-data="{ open: @entangle('showCreate') }">
        <x-modal confirmText="Save" action="save">
            <p class="text-xl font-semibold">Create Option</p>

            <x-input title="Name" name="name" />
            <x-media-upload
                        title="Image"
                        name="photo"
                        :photo="$photo"
                        :photoInfo="$photoInfo"
                        types="PNG or JPEG"
                        rules="image/*" />


            <x-input title="Description" name="description" />
            <x-input title="Price" name="price" />

            <x-select
                title="Product"
                :options="$products"
                name="product_id"
                />

            <x-select
                title="Option Group"
                :options="$optionGroups"
                name="option_group_id"
                />

            <x-checkbox
                    title="Active"
                    name="isActive" :defer="false" />

        </x-modal>
    </div>

    {{--  update form  --}}
    <div x-data="{ open: @entangle('showEdit') }">
        <x-modal confirmText="Update" action="update">
            <p class="text-xl font-semibold">Update Option</p>

            <x-input title="Name" name="name" />
            <x-media-upload
                        title="Image"
                        name="photo"
                        preview="{{ $selectedModel->photo ?? '' }}"
                        :photo="$photo"
                        :photoInfo="$photoInfo"
                        types="PNG or JPEG"
                        rules="image/*" />


            <x-input title="Description" name="description" />
            <x-input title="Price" name="price" />

            <x-select
                title="Product"
                :options="$products"
                name="product_id"
                />

            <x-select
                title="Option Group"
                :options="$optionGroups"
                name="option_group_id"
                />

            <x-checkbox
                    title="Active"
                    name="isActive" :defer="false" />



        </x-modal>
    </div>


</div>

