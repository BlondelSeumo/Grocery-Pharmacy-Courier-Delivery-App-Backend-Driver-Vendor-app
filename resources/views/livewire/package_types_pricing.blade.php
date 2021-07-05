@section('title', 'Pricing')
    <div>

        <x-baseview title="Pricing">
            <livewire:tables.package-type-price-table />
        </x-baseview>

        <div x-data="{ open: @entangle('showCreate') }">
            <x-modal confirmText="Save" action="save">
                <p class="text-xl font-semibold">Create Package Type Pricing</p>
                <x-select title="Package Type" :options='$packageTypes' name="package_type_id" :defer="true" />
                <x-input title="Max Booking Days (7)" name="max_booking_days"
                    placeholder="Max number of days user can book ahead" />
                    <x-input title="Base Delivery Price" name="base_price" placeholder="" />
                <div class="grid grid-cols-1 gap-6 md:grid-cols-2">
                    <div>
                        <x-input title="Price for Package" name="size_price" placeholder="" />
                        <x-checkbox title="Charge Per KG" name="price_per_kg" :defer="true" />
                    </div>
                    <div>
                        <x-input title="Distance Price" name="distance_price" placeholder="" />
                        <x-checkbox title="Charge Per KM" name="price_per_km" :defer="true" />
                    </div>
                    
                    <x-checkbox title="Auto move to ready" name="auto_assignment" :defer="true" />
                    <x-checkbox title="Active" name="is_active" :defer="true" />
                </div>


            </x-modal>
        </div>

        <div x-data="{ open: @entangle('showEdit') }">
            <x-modal confirmText="Update" action="update">

                <p class="text-xl font-semibold">Edit Package Type</p>
                <x-select title="Package Type" :options='$packageTypes' name="package_type_id" />
                <x-input title="Max Booking Days (7)" name="max_booking_days"
                    placeholder="Max number of days user can book ahead" />
                    <x-input title="Base Delivery Price" name="base_price" placeholder="" />
                <div class="grid grid-cols-1 gap-6 md:grid-cols-2">
                    <div>
                        <x-input title="Price for Package" name="size_price" placeholder="" />
                        <x-checkbox title="Charge Per KG" name="price_per_kg" :defer="true" />
                    </div>
                    <div>
                        <x-input title="Distance Price" name="distance_price" placeholder="" />
                        <x-checkbox title="Charge Per KM" name="price_per_km" :defer="true" />
                    </div>
                    <x-checkbox title="Auto move to ready" name="auto_assignment" :defer="true" />
                    <x-checkbox title="Extra fields required (e.g kg, width)" name="field_required" :defer="true" />
                    <x-checkbox title="Active" name="is_active" :defer="true" />
                </div>


            </x-modal>
        </div>
    </div>
