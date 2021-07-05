function otpForm() {
    return {
        show: false,
        loading: false,
        errorMessage:"",
        openVerify() { this.show = true },
        closeVerify() { this.show = false },
        isVerifyOpen() { return this.show === true },
        clearError(){
            this.errorMessage = "";
        },
        init(){
            //
            window.addEventListener('show-verify', event => {
                this.clearError();
                this.openVerify();
            });

            //
            window.addEventListener('close-verify', event => {
                this.clearError();
                this.closeVerify();
            });

            //
            window.addEventListener('error-', event => {
                this.errorMessage = event.detail;
            });

            //
            window.addEventListener('show-loading', event => {
                this.loading = true;
            });

            //
            window.addEventListener('hide-loading', event => {
                this.loading = false;
            });
        }
    }
}

$(function() {

    //
    function showLoading(){
        window.dispatchEvent( new CustomEvent('show-loading'));
    }

    function hideLoading(){
        window.dispatchEvent( new CustomEvent('hide-loading'));
    }


    //
    livewire.on('initiateFirebaseAuth', data => {

        var config = {
            apiKey: data,
          };
        firebase.initializeApp(config);

        // Create a Recaptcha verifier instance globally
        window.recaptchaVerifier = new firebase.auth.RecaptchaVerifier(
            "recaptcha-container",{
                size: "normal",
                callback: function(response) {
                    submitPhoneNumberAuth();
                }
            }
        );

    });

    //
    livewire.on('sendOTP', phoneNumber => {

        showLoading();
        var appVerifier = window.recaptchaVerifier;
        firebase
          .auth()
          .signInWithPhoneNumber(phoneNumber, appVerifier)
          .then(function(confirmationResult) {
            window.confirmationResult = confirmationResult;
            hideLoading();
            window.dispatchEvent( new CustomEvent('show-verify'));
          })
          .catch(function(error) {
            console.log("Error ==> "+error+"");
            hideLoading();
            window.dispatchEvent( new CustomEvent('error-', {detail: error}));
          });

    });

    //
    livewire.on('verifyFirebaseAuth', otp => {

        showLoading();
        confirmationResult
          .confirm(otp)
          .then(function(result) {
            var user = result.user;
            console.log(user);
            hideLoading();
            livewire.emit('allowReset', user.refreshToken );
          })
          .catch(function(error) {
            console.log("Error ==> "+error+"");
            hideLoading();
            window.dispatchEvent( new CustomEvent('error-', {detail: "Verification Code is incorrect/invalid"}));
          });

    });




});