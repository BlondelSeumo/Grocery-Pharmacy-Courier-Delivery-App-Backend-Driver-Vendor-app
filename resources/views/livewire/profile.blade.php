@section('title', 'Profile')
<div>

    <x-baseview title="Update Profile">

        <div class="block md:space-x-10 md:flex">
            <div class="w-full lg:w-8/12">
                <x-form action="updateProfile">
                    <p class="font-semibold">Update Profile information</p>
                    <x-media-upload
                        title="Profile"
                        name="photo"
                        preview="{{ Auth::user()->photo }}"
                        :photo="$photo"
                        :photoInfo="$photoInfo"
                        types="PNG or JPEG"
                        rules="image/*" />

                        <x-input title="Name" type="text" name="name" />
                        <x-input title="Email" type="email" name="email" />
                        <x-input title="Phone" type="tel" name="phone" />
                        <x-buttons.primary title="Update" />

                </x-form>
            </div>

            {{-- Password Change --}}
            <div class="w-full lg:w-8/12">
                <x-form action="changePassword">
                    <p class="font-semibold">Change Password</p>
                    <x-input title="Current Password" type="password" name="current_password" />
                    <x-input title="New Password" type="password" name="new_password" />
                    <x-input title="Confirm New Password" type="password" name="new_password_confirmation" />
                    <x-buttons.primary title="Update" />

                </x-form>
            </div>

        <div>
    </x-baseview>


</div>
