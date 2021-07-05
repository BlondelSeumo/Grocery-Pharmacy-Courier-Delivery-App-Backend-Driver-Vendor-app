@section('title', 'Products')
    <div>

        <x-baseview title="Products">
            <livewire:tables.product-table />
        </x-baseview>

        {{-- new form --}}
        <div x-data="{ open: @entangle('showCreate') }">
            <x-modal-lg confirmText="Save" action="save">
                <p class="text-xl font-semibold">Create Product</p>

                <x-input title="Name" name="name" />
                <x-media-upload title="Image" name="photo" :photo="$photo" :photoInfo="$photoInfo" types="PNG or JPEG"
                    rules="image/*" />


                <x-input title="Description" name="description" />
                <div class="grid grid-cols-2 space-x-4">
                    <x-input title="Price" name="price" />
                    <x-input title="Discount Price" name="discount_price" />
                </div>


                <div class="grid grid-cols-2 space-x-4">
                    <x-input title="Capacity" name="capacity" placeholder="e.g 15" />
                    <x-input title="Unit" name="unit"
                        placeholder="Enter the unit of product. Default is kilogram(kg). e.g Kg, g, m, L" />
                </div>

                <div class="grid grid-cols-2 space-x-4">
                    <x-input title="Package Count" name="package_count"
                        placeholder="Number of item per package (ex: 6, 10)" />
                    <x-input title="Available Qty" name="available_qty" placeholder="Number of item available qty" />
                </div>

                {{--  --}}
                {{-- <div class="grid grid-cols-2 space-x-4"> --}}
                @role('manager')
                @php
                    $vendors = [auth()->user()->vendor];
                @endphp
                @endrole
                <x-select title="Vendor" :options="$vendors" name="vendorID" />


                {{-- categories --}}
                <x-select2 title="Categories" :options="$categories" name="categoriesIDs" id="categoriesSelect2"
                    :multiple="true" width="100" :ignore="true" />

                {{-- </div> --}}

                <div class="grid items-center grid-cols-2 space-x-4">
                    @role('admin')
                    <x-checkbox title="Featured" name="featured" description="Featured on app home screen" :defer="false" />
                    @endrole
                    <x-checkbox title="Can be Delivered" name="deliverable"
                        description="If product can be delivered to customers" :defer="false" />
                </div>


                <x-checkbox title="Active" name="isActive" :defer="false" />

            </x-modal-lg>
        </div>

        {{-- update form --}}
        <div x-data="{ open: @entangle('showEdit') }">
            <x-modal-lg confirmText="Update" action="update">
                <p class="text-xl font-semibold">Update Product</p>

                <x-input title="Name" name="name" />
                <x-media-upload title="Image" name="photo" preview="{{ $selectedModel->photo ?? '' }}" :photo="$photo"
                    :photoInfo="$photoInfo" types="PNG or JPEG" rules="image/*" />


                <x-input title="Description" name="description" />
                <div class="grid grid-cols-2 space-x-4">
                    <x-input title="Price" name="price" />
                    <x-input title="Discount Price" name="discount_price" />
                </div>


                <div class="grid grid-cols-2 space-x-4">
                    <x-input title="Capacity" name="capacity" placeholder="e.g 15" />
                    <x-input title="Unit" name="unit"
                        placeholder="Enter the unit of product. Default is kilogram(kg). e.g Kg, g, m, L" />
                </div>

                <div class="grid grid-cols-2 space-x-4">
                    <x-input title="Package Count" name="package_count"
                        placeholder="Number of item per package (ex: 6, 10)" />
                    <x-input title="Available Qty" name="available_qty" placeholder="Number of item available qty" />
                </div>

                {{--  --}}
                {{-- <div class="grid grid-cols-2 space-x-4"> --}}
                @role('manager')
                @php
                    $vendors = [auth()->user()->vendor];
                @endphp
                @endrole
                <x-select title="Vendor" :options="$vendors" name="vendorID" />

                {{-- categories --}}
                <x-select2 title="Categories" :options="$categories" name="categoriesIDs" id="editCategoriesSelect2"
                    :multiple="true" width="100" :ignore="true" />
                {{-- </div> --}}

                <div class="grid items-center grid-cols-2 space-x-4">
                    @role('admin')
                    <x-checkbox title="Featured" name="featured" description="Featured on app home screen" :defer="false" />
                    @endrole
                    <x-checkbox title="Can be Delivered" name="deliverable"
                        description="If product can be delivered to customers" :defer="false" />
                </div>


                <x-checkbox title="Active" name="isActive" :defer="false" />

            </x-modal-lg>
        </div>

        {{-- Assign Subcategories --}}
        <div x-data="{ open: @entangle('showAssignSubcategories') }">
            <x-modal confirmText="Add" action="assignSubcategories">
                <p class="text-xl font-semibold">Assign To Sub-categories</p>
                <p class="text-sm text-gray-500">Note: Only sub-categories of the assigned product categories will be listed here</>
                <div class="grid grid-cols-1 lg:grid-cols-2">
                    @foreach ($subCategories as $subCategory)
                        <x-checkbox title="{{ $subCategory->name }}({{ $subCategory->category->name }})" name="subCategoriesIDs" value="{{ $subCategory->id }}"
                            :defer="false" />
                    @endforeach
                </div>

            </x-modal>
        </div>

        {{-- Assign menus --}}
        <div x-data="{ open: @entangle('showAssign') }">
            <x-modal confirmText="Add" action="assignMenus">
                <p class="text-xl font-semibold">Add to Menus</p>
                <p class="text-sm text-gray-500">Note: Menus of selected vendor for product will be listed here</>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3">
                    @foreach ($menus as $menu)
                        <x-checkbox title="{{ $menu->name }}" name="menusIDs" value="{{ $menu->id }}"
                            :defer="false" />
                    @endforeach
                </div>

            </x-modal>
        </div>

        {{-- details modal --}}
        <div x-data="{ open: @entangle('showDetails') }">
            <x-modal-lg>

                <p class="text-xl font-semibold">{{ $selectedModel->name ?? '' }}'s Details</p>
                <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
                    <x-details.item title="Name" text="{{ $selectedModel->name ?? '' }}" />
                    <x-details.item title="Description" text="{{ $selectedModel->description ?? '' }}" />

                    <x-details.item title="Price"
                        text="{{ setting('currency', '$') }}{{ $selectedModel->price ?? '' }}" />
                    <x-details.item title="Discount Price"
                        text="{{ setting('currency', '$') }}{{ $selectedModel->discount_price ?? '' }}" />


                    {{-- <x-details.item title="" text="" /> --}}
                    <x-details.item title="Capacity" text="{{ $selectedModel->capacity ?? '' }}" />
                    <x-details.item title="Unit" text="{{ $selectedModel->unit ?? '' }}" />


                    <x-details.item title="Package Count" text="{{ $selectedModel->package_count ?? '0' }}" />
                    <x-details.item title="Available Qty" text="{{ $selectedModel->available_qty ?? '' }}" />


                    <x-details.item title="Vendor" text="{{ $selectedModel->vendor->name ?? '' }}" />
                    <x-details.item title="Menus" text="">
                        {{ $selectedModel != null
    ? implode(
        ', ',
        $selectedModel->menus()->pluck('name')->toArray(),
    )
    : '' }}
                    </x-details.item>



                </div>
                <div class="grid grid-cols-1 gap-4 pt-4 mt-4 border-t md:grid-cols-2 lg:grid-cols-3">

                    <div>
                        <x-label title="Status" />
                        <x-table.active :model="$selectedModel" />
                    </div>

                    <div>
                        <x-label title="Featured" />
                        <x-table.bool isTrue="{{ $selectedModel->featured ?? false }}" />
                    </div>

                    <div>
                        <x-label title="Available for Delivery" />
                        <x-table.bool isTrue="{{ $selectedModel->deliverable ?? false }}" />
                    </div>

                </div>

                <div class="grid grid-cols-1 gap-4 pt-4 mt-4 border-t md:grid-cols-2 lg:grid-cols-3">





                </div>

            </x-modal-lg>
        </div>
    </div>
