@section('title', 'Banners')
<div>

    <x-baseview title="Banners">
        <livewire:tables.banner-table />
    </x-baseview>

    <div x-data="{ open: @entangle('showCreate') }">
        <x-modal confirmText="Save" action="save">
            <p class="text-xl font-semibold">Create Banner</p>
            <x-media-upload
                        title="Photo"
                        name="photo"
                        :photo="$photo"
                        :photoInfo="$photoInfo"
                        types="PNG or JPEG"
                        rules="image/*" />

            <x-select title="Category" :options='$categories' name="category_id" :defer="true" />
            <x-checkbox
                    title="Active"
                    name="isActive" :defer="false" />

        </x-modal>
    </div>

    <div x-data="{ open: @entangle('showEdit') }">
        <x-modal confirmText="Update" action="update">

            <p class="text-xl font-semibold">Edit Banner</p>
            <x-media-upload
                        title="Photo"
                        name="photo"
                        preview="{{ $selectedModel->photo ?? '' }}"
                        :photo="$photo"
                        :photoInfo="$photoInfo"
                        types="PNG or JPEG"
                        rules="image/*" />
            <x-select title="Category" :options='$categories' name="category_id" selected="{{ !empty($selectedModel) ? $selectedModel->category_id : '' }}"  :defer="true" />
            <x-checkbox
                    title="Active"
                    name="isActive" :defer="false" />


        </x-modal>
    </div>
</div>


