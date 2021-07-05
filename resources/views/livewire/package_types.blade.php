@section('title', 'Package Types')
    <div>

        <x-baseview title="Package Types">
            <livewire:tables.package-type-table />
        </x-baseview>

        <div x-data="{ open: @entangle('showCreate') }">
            <x-modal confirmText="Save" action="save">
                <p class="text-xl font-semibold">Create Package Type</p>
                <x-input title="Name" name="name" placeholder="" />
                <x-input title="Description" name="description" placeholder="" />
                <x-media-upload title="Photo" name="photo" {{-- preview="{{ $selectedModel->photo ?? '' }}" --}} :photo="$photo" :photoInfo="$photoInfo"
                    types="PNG or JPEG" rules="image/*" />
                <x-checkbox title="Active" name="is_active" :defer="true" />

            </x-modal>
        </div>

        <div x-data="{ open: @entangle('showEdit') }">
            <x-modal confirmText="Update" action="update">

                <p class="text-xl font-semibold">Edit Package Type</p>
                <x-input title="Name" name="name" placeholder="" />
                <x-input title="Description" name="description" placeholder="" />
                <x-media-upload title="Photo" name="photo" preview="{{ $selectedModel->photo ?? '' }}" :photo="$photo" :photoInfo="$photoInfo"
                    types="PNG or JPEG" rules="image/*" />
                <x-checkbox title="Active" name="is_active" :defer="true" />


            </x-modal>
        </div>
    </div>
