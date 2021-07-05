@section('title', 'Forgot Password')
<div wire:init="initiateFireabse">
    <div class="flex items-center min-h-screen p-6 bg-gray-50 ">
        <div class="flex-1 h-full max-w-xl mx-auto overflow-hidden bg-white rounded-lg shadow-xl ">
          
           
            {{-- form --}}
            <div class="flex items-center justify-center p-6 sm:p-12 ">
                <div class="w-full">
                    {{--  --}}
                    <a class="text-lg font-bold text-black dark:text-white"
                        href="{{ route('login') }}">
                        <img src="{{ setting('websiteLogo',  asset('images/logo.png')) }}" class="w-12 h-12 mx-auto rounded"/>
                        <p class="text-center">{{ setting('websiteName') }}</p>
                    </a>
                    <h1 class="mt-5 mb-4 text-xl font-semibold text-gray-700">Forgot Password</h1>

                    @if( !$setPassword )
                        <div
                            x-data="otpForm()"
                            x-init="init()">
                            {{-- phone entry form --}}
                            <form wire:submit.prevent="resetPassword" x-show="!isVerifyOpen()">
                                @csrf
                                <x-input title="Phone" placeholder="+233--" name="phone" />
                                <div x-show="!loading">
                                    <x-buttons.primary title="Reset Password" id="reset-btn" />
                                </div>
                                <!-- Add a container for reCaptcha -->
                                <div id="recaptcha-container"></div>
                            </form>

                            {{-- phone entry form --}}
                            <form wire:submit.prevent="verifyOTP" x-show="isVerifyOpen()">
                                @csrf
                                <x-input title="Verification Code" type="number" name="otp" />
                                <div x-show="!loading">
                                    <x-buttons.primary title="Verify" />
                                </div>
                            </form>

                            {{-- loading indicator --}}
                            <div x-show="loading">
                                <img src="{{ asset('images/loading.svg') }}" class="mx-auto my-4" />
                            </div>

                            {{-- error --}}
                            <p class="my-4 text-xs text-center text-red-500" x-text="errorMessage"></p>


                        </div>
                    @else
                        <form wire:submit.prevent="saveNewPassword">
                            @csrf
                            <x-input title="New Password" type="password" placeholder="***************" name="password" />
                            <x-input title="Confirm New Password" type="password" placeholder="***************" name="password_confirmation" />
                            <div wire:loading.remove>
                                <x-buttons.primary title="Set New Password" />
                            </div>
                            {{-- loading indicator --}}
                            <div class="flex items-center justify-items-center">
                                <img src="{{ asset('images/loading.svg') }}" class="mx-auto my-4" wire:loading wire:target="saveNewPassword"  />
                            </div>
                        </form>
                    @endif


                    {{--  actions  --}}
                    <div class="">

                        <p class="flex items-center justify-center mt-4 space-x-2">
                            <span class="font-base">Already have an account?</span>
                            <a
                                class="text-sm font-medium text-primary-600 hover:underline"
                                href="{{ route('login') }}">
                                Login
                            </a>
                        </p>

                    </div>
                </div>
            </div>
          
        </div>
      </div>

    @push('scripts')
        <script src="https://www.gstatic.com/firebasejs/6.3.3/firebase-app.js"></script>
        <script src="https://www.gstatic.com/firebasejs/6.3.3/firebase-auth.js"></script>
        <script src="{{ asset('js/forgot-password.js') }}"></script>
    @endpush
</div>