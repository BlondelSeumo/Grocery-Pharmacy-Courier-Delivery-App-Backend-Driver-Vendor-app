@section('title', 'Login')
    <div>
        <div class="flex items-center min-h-screen p-6 bg-gray-50 ">
            <div class="flex-1 h-full max-w-4xl mx-auto overflow-hidden bg-white rounded-lg shadow-xl ">
                <div class="flex flex-col overflow-y-auto md:flex-row">
                    <div class="h-32 md:h-auto md:w-1/2">
                        <img aria-hidden="true" class="object-cover w-full h-full"
                            src="{{ setting('loginImage', asset('images/login-office.jpeg')) }}" alt="Office" />
                    </div>
                    {{-- form --}}
                    <div class="flex items-center justify-center p-6 sm:p-12 md:w-1/2">
                        <div class="w-full">
                            <form wire:submit.prevent="login">
                                @csrf
                                <h1 class="mb-4 text-xl font-semibold text-gray-700">Login</h1>
                                <x-input title="Email" type="email" placeholder="info@mail.com" name="email" />
                                <x-input title="Password" type="password" placeholder="***************" name="password" />
                                <div class="hidden">
                                    <x-input title="" type="" placeholder="" name="fcmToken" />
                                </div>
                                <x-checkbox description="Remember me" name="remember" />
                                <p class="flex items-center justify-end mt-2">
                                    <a class="text-sm font-medium text-primary-600 hover:underline"
                                        href="{{ route('password.forgot') }}">
                                        Forgot your password?
                                    </a>
                                </p>
                                <x-buttons.primary title="Login" />
                            </form>

                            @if (!App::environment('production'))
                                <hr class="my-5" />
                                <div class="p-2 mb-5 bg-red-100 border rounded shadow cursor-pointer hover:shadow-lg"
                                    wire:click="loadAccount(0)">
                                    <p class="font-medium ">Admin Account</p>
                                    <p class="text-sm ">Email: admin@demo.com | Password: password</p>
                                </div>

                                <div class="p-2 mb-5 bg-purple-100 border rounded shadow cursor-pointer hover:shadow-lg"
                                    wire:click="loadAccount(1)">
                                    <p class="font-medium ">Manager Account</p>
                                    <p class="text-sm ">Email: manager@demo.com | Password: password</p>
                                </div>
                                <div class="p-2 mb-5 bg-purple-100 border rounded shadow cursor-pointer hover:shadow-lg"
                                    wire:click="loadAccount(2)">
                                    <p class="font-medium ">Manager Account(Parcel Vendor)</p>
                                    <p class="text-sm ">Email: manager1@demo.com | Password: password</p>
                                </div>

                                <div class="p-2 mb-5 bg-green-100 border rounded shadow cursor-pointer hover:shadow-lg"
                                    {{-- wire:click="loadAccount(3)" --}}
                                    >
                                    <p class="font-medium ">Client Account (You can't login to backend)</p>
                                    <p class="text-sm ">Email: client@demo.com | Password: password</p>
                                </div>



                            @endif
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
