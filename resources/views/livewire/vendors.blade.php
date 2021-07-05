@section('title', 'Vendors')
<div>

    <x-baseview title="Vendors">
        <livewire:tables.vendor-table />
    </x-baseview>

    {{-- new form --}}
    <div x-data="{ open: @entangle('showCreate') }">
        <x-modal-lg confirmText="Save" action="save" :clickAway="false">
            <p class="text-xl font-semibold">Create Vendor</p>
            <x-input title="Name" name="name" />
            <x-input title="Description" name="description" />


            <div class="grid grid-cols-2 space-x-4">
                <x-input title="Phone" name="phone" />
                <x-input title="Email" name="email" />
            </div>

            <x-input title="Address" name="address" />

            <div class="grid grid-cols-2 space-x-4">
                <x-input title="Latitude" name="latitude" />
                <x-input title="Longitude" name="longitude" />
            </div>
            {{-- categories --}}
            <x-select2 title="Categories" :options="$categories" name="categoriesIDs" id="categoriesSelect2"
                :multiple="true" width="100" :ignore="true" />

            {{-- sub-categories --}}
            <div class="grid items-center grid-cols-1 space-x-4">
                <x-checkbox title="Has Sub-Categories" name="has_sub_categories"
                    description="This will allow products to be attached to sub-categories" :defer="false" />
            </div>

            <hr class="mt-5" />
            <div class="grid grid-cols-2 space-x-4">
                <x-checkbox title="Package Delivery Vendor" name="is_package_vendor"
                    description="Check this if the vendor is for package delivery" :defer="false" />
                <x-checkbox title="Order Auto Assignment" name="auto_assignment"
                    description="System will automatic assign order to delivery boy" :defer="false" />
            </div>

            <div
                class="{{ !$is_package_vendor ? 'block' : 'hidden' }}">
                <div class="grid grid-cols-2 space-x-4">
                    <x-input title="Base Delivery Fee" name="base_delivery_fee" />
                    <x-input title="Delivery Fee" name="delivery_fee" />
                </div>
                <div class="grid grid-cols-2 space-x-4">
                    <x-input title="Delivery Range(KM)" name="delivery_range" />
                    <x-checkbox title="Charge per KM" name="charge_per_km" description="Delivery fee will be per KM"
                        :defer="false" />
                </div>
                <div class="grid items-center grid-cols-2 space-x-4">
                    <x-checkbox title="Pickup" name="pickup" description="Allows pickup orders" :defer="false" />
                    <x-checkbox title="Delivery" name="delivery" description="Allows delivery orders" :defer="false" />
                </div>

                <hr class="mt-5" />
            </div>
            <div class="grid items-center grid-cols-2 space-x-4">
                <x-checkbox title="Schedule Order" name="allow_schedule_order"
                    description="Allows customer to schedule orders" :defer="false" />
            </div>
            <div class="grid grid-cols-2 space-x-4">
                <x-input title="System Commission(%)" name="commission" />
                <x-input title="Tax" name="tax" />
            </div>


            <x-media-upload title="Logo" name="photo" :photo="$photo" :photoInfo="$photoInfo" types="PNG or JPEG"
                rules="image/*" />

            <x-media-upload title="Featured Image" name="secondPhoto" :photo="$secondPhoto"
                :photoInfo="$secondPhotoInfo" types="PNG or JPEG" rules="image/*" />


            <x-checkbox title="Active" name="isActive" :defer="false" />

        </x-modal-lg>
    </div>

    {{-- update form --}}
    <div x-data="{ open: @entangle('showEdit') }">
        <x-modal-lg confirmText="Update" action="update" :clickAway="false">

            <p class="text-xl font-semibold">Update Vendor</p>
            <x-input title="Name" name="name" />
            <x-input title="Description" name="description" />

            <div class="grid grid-cols-2 space-x-4">
                <x-input title="Phone" name="phone" />
                <x-input title="Email" name="email" />
            </div>

            <div class="grid grid-cols-2 space-x-4">
                <x-input title="Latitude" name="latitude" />
                <x-input title="Longitude" name="longitude" />
            </div>
            <x-input title="Address" name="address" />

            {{-- categories --}}
            <x-select2 title="Categories" :options="$categories" name="categoriesIDs" id="editCategoriesSelect2"
                :multiple="true" width="100" :ignore="true" />
            {{-- sub-categories --}}
            <div class="grid items-center grid-cols-1 space-x-4">
                <x-checkbox title="Has Sub-Categories" name="has_sub_categories"
                    description="This will allow products to be attached to sub-categories" :defer="false" />
            </div>
            <hr class="mt-5" />
            <div class="grid grid-cols-2 space-x-4">
                <x-checkbox title="Package Delivery Vendor" name="is_package_vendor"
                    description="Check this if the vendor is for package delivery" :defer="false" />
                <x-checkbox title="Order Auto Assignment" name="auto_assignment"
                    description="System will automatic assign order to delivery boy" :defer="false" />
            </div>
            <div
                class="{{ !$is_package_vendor ? 'block' : 'hidden' }}">
                <div class="grid grid-cols-2 space-x-4">
                    <x-input title="Base Delivery Fee" name="base_delivery_fee" />
                    <x-input title="Delivery Fee" name="delivery_fee" />
                </div>
                <div class="grid grid-cols-2 space-x-4">
                    <x-input title="Delivery Range(KM)" name="delivery_range" />
                    <x-checkbox title="Charge per KM" name="charge_per_km" description="Delivery fee will be per KM"
                        :defer="false" />
                </div>
                <div class="grid items-center grid-cols-2 space-x-4">
                    <x-checkbox title="Pickup" name="pickup" description="Allows pickup orders" :defer="false" />
                    <x-checkbox title="Delivery" name="delivery" description="Allows delivery orders" :defer="false" />
                </div>

                <hr class="mt-5" />
            </div>
            <div class="grid items-center grid-cols-2 space-x-4">
                <x-checkbox title="Schedule Order" name="allow_schedule_order"
                    description="Allows customer to schedule orders" :defer="false" />
            </div>
            @role('admin')
                <div class="grid grid-cols-2 space-x-4">
                    <x-input title="System Commission(%)" name="commission" />
                    <x-input title="Tax" name="tax" />
                </div>
            @endrole
            <x-media-upload title="Logo" name="photo"
                preview="{{ $selectedModel->logo ?? '' }}" :photo="$photo"
                :photoInfo="$photoInfo" types="PNG or JPEG" rules="image/*" />

            <x-media-upload title="Featured Image" name="secondPhoto"
                preview="{{ $selectedModel->feature_image ?? '' }}" :photo="$secondPhoto"
                :photoInfo="$secondPhotoInfo" types="PNG or JPEG" rules="image/*" />


            <x-checkbox title="Active" name="isActive" :defer="false" />

        </x-modal-lg>
    </div>

    {{-- assign form --}}
    <div x-data="{ open: @entangle('showAssign') }">
        <x-modal confirmText="Assign" action="assignManagers" :clickAway="false">

            <p class="text-xl font-semibold">Assign Managers To Vendor</p>
            <x-select2 title="Managers" :options="$managers" name="managersIDs" id="managersSelect2" :multiple="true"
                width="100" :ignore="true" />

        </x-modal>
    </div>

    {{-- timing form --}}
    <div x-data="{ open: @entangle('showDayAssignment') }">
        <x-modal-lg confirmText="Save" action="saveDays" :clickAway="false">

            <p class="text-xl font-semibold">Set vendor open/close time</p>
            <div class="flex items-center py-3 mt-10 border-t border-b">
                <div class="w-4/12">Day</div>
                <div class="w-4/12">
                    Openning Time
                </div>
                <div class="w-4/12 pl-2">
                    Closing Time
                </div>
            </div>
            @if(!empty($days))

                @foreach($days as $day)
                    <div class="flex items-center pb-3 border-b">
                        <div class="w-4/12">{{ $day->name }}</div>
                        <div class="w-4/12">
                            <x-input title="" type="time" name="dayOpen.{{ $day->id }}" />
                        </div>
                        <div class="w-4/12 pl-2">
                            <x-input title="" type="time" name="dayClose.{{ $day->id }}" />
                        </div>
                    </div>
                @endforeach

            @endif

        </x-modal-lg>
    </div>

    {{-- details modal --}}
    <div x-data="{ open: @entangle('showDetails') }">
        <x-modal-lg>

            <p class="text-xl font-semibold">
                {{ $selectedModel != null ? $selectedModel->name."'s" : '' }}
                Details</p>
            <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
                <x-details.item title="Name" text="{{ $selectedModel->name ?? '' }}" />
                <x-details.item title="Description"
                    text="{{ $selectedModel->description ?? '' }}" />

                <x-details.item title="Phone" text="{{ $selectedModel->phone ?? '' }}" />
                <x-details.item title="Email" text="{{ $selectedModel->email ?? '' }}" />

                <x-details.item title="Address"
                    text="{{ $selectedModel->address ?? '' }}" />
                <x-details.item title="Latitude"
                    text="{{ $selectedModel->latitude ?? '' }}" />
                <x-details.item title="Longitude"
                    text="{{ $selectedModel->longitude ?? '' }}" />
                <x-details.item title="Categories" text="">
                    {{ $selectedModel != null
    ? implode(
        ', ',
        $selectedModel->categories()->pluck('name')->toArray(),
    )
    : '' }}
                </x-details.item>
            </div>
            <div class="grid grid-cols-1 gap-4 mt-4 border-t md:grid-cols-2 ">
                <x-details.item title="Tax" text="{{ $selectedModel->tax ?? '0' }}%" />
                <x-details.item title="Commission"
                    text="{{ $selectedModel->commission ?? '0' }}%" />

            </div>

            @if($selectedModel ? !$selectedModel->is_package_vendor : true)
                <div class="grid grid-cols-1 gap-4 mt-4 border-t md:grid-cols-2 ">
                    <x-details.item title="Delivery Fee"
                        text="{{ $selectedModel->delivery_fee ?? '' }}" />
                    <x-details.item title="Delivery Range"
                        text="{{ $selectedModel->delivery_range ?? '0' }} KM" />
                </div>
                <div class="grid grid-cols-1 gap-4 pt-4 mt-4 border-t md:grid-cols-2 lg:grid-cols-3">

                    <div>
                        <x-label title="Status" />
                        <x-table.active :model="$selectedModel" />
                    </div>

                    <div>
                        <x-label title="Available for Pickup" />
                        <x-table.bool isTrue="{{ $selectedModel->pickup ?? false }}" />
                    </div>

                    <div>
                        <x-label title="Available for Delivery" />
                        <x-table.bool isTrue="{{ $selectedModel->delivery ?? false }}" />
                    </div>

                    <div>
                        <x-label title="Open" />
                        <x-table.bool isTrue="{{ $selectedModel->is_open ?? false }}" />
                    </div>

                </div>
            @endif

            <div class="grid grid-cols-1 gap-4 pt-4 mt-4 border-t md:grid-cols-2 lg:grid-cols-3">





            </div>

        </x-modal-lg>
    </div>
</div>
