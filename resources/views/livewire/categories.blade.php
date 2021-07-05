@section('title', 'Categories')
<div>

    <x-baseview title="Categories">
        <livewire:tables.category-table />
    </x-baseview>

    <div x-data="{ open: @entangle('showCreate') }">
        <x-modal confirmText="Save" action="save">
            <p class="text-xl font-semibold">Create Category</p>
            <x-input title="Name" name="name" placeholder="Vegetables" />
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

            <p class="text-xl font-semibold">Edit Category</p>
            <x-input title="Name" name="name" placeholder="Vegetables" />
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


