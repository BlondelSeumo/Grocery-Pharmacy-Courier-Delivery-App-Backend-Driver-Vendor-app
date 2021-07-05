@section('title', 'SubCategories')
<div>

    <x-baseview title="SubCategories">
        <livewire:tables.sub-category-table />
    </x-baseview>

    <div x-data="{ open: @entangle('showCreate') }">
        <x-modal confirmText="Save" action="save">
            <p class="text-xl font-semibold">Create SubCategory</p>
            <x-input title="Name" name="name" placeholder="Vegetables" />
            <x-select title="Category" :options="$categories" name="category_id" />
            <x-media-upload
                        title="Photo"
                        name="photo"
                        {{--  preview="{{ $selectedModel->photo ?? '' }}"  --}}
                        :photo="$photo"
                        :photoInfo="$photoInfo"
                        types="PNG or JPEG"
                        rules="image/*" />
            <x-checkbox
                    title="Active"
                    name="isActive" :defer="false" />

        </x-modal>
    </div>

    <div x-data="{ open: @entangle('showEdit') }">
        <x-modal confirmText="Update" action="update">

            <p class="text-xl font-semibold">Edit SubCategory</p>
            <x-input title="Name" name="name" placeholder="Vegetables" />
            <x-select title="Category" :options="$categories" name="category_id" />
            <x-media-upload
                        title="Photo"
                        name="photo"
                        preview="{{ $selectedModel->photo ?? '' }}"
                        :photo="$photo"
                        :photoInfo="$photoInfo"
                        types="PNG or JPEG"
                        rules="image/*" />
            <x-checkbox
                    title="Active"
                    name="isActive" :defer="false" />


        </x-modal>
    </div>
</div>


