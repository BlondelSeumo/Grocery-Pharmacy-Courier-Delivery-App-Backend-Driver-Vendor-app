$(function() {
    //Stripe
    livewire.on("initStripe", data => {
        var stripe = Stripe(data[0]);
        stripe.redirectToCheckout({ sessionId: "" + data[1] + "" });
    });

    //Paystack
    livewire.on("initPaystack", data => {
        let handler = PaystackPop.setup({
            key: data[0], // Replace with your public key
            email: data[1],
            amount: data[2],
            currency: data[3],
            ref: "" + data[4] + "", // generates a pseudo-unique reference. Please replace with a reference you generated. Or remove the line entirely so our API will generate one for you
            // label: "Optional string that replaces customer email"
            onClose: function() {
                window.location.href = "" + data[5] + "";
            },
            callback: function(response) {
                window.location.href = "" + data[5] + "";
            }
        });
        handler.openIframe();
    });

    //Razorpay
    livewire.on("initRazorpay", data => {
        var options = {
            key: "" + data[0] + "", // Enter the Key ID generated from the Dashboard
            amount: "" + data[1] + "", // Amount is in currency subunits. Default currency is INR. Hence, 50000 refers to 50000 paise
            currency: "" + data[2] + "",
            name: "" + data[3] + "",
            description: "",
            image: "" + data[4] + "",
            order_id: "" + data[5] + "", //This is a sample Order ID. Pass the `id` obtained in the response of Step 1
            handler: function(response) {
                window.location.href = "" + data[6] + "";
            },
            theme: {
                // color: "" + data[7] + ""
            }
        };
        console.log(options);
        var rzp1 = new Razorpay(options);
        rzp1.on("payment.failed", function(response) {
            alert(data[6]);
            window.location.href = "" + data[6] + "";
        });
        rzp1.open();
    });

    //Flutterwave
    livewire.on("initFlwPayment", data => {
        FlutterwaveCheckout({
            public_key: "" + data[0] + "",
            tx_ref: "" + data[1] + "",
            amount: "" + data[2] + "",
            currency: "" + data[3] + "",
            country: "" + data[4] + "",
            payment_options: "card,mobilemoney,ussd,banktransfer",
            // specified redirect URL
            redirect_url: "" + data[5] + "",
            meta: {
                // consumer_id: 23,
                // consumer_mac: "92a3-912ba-1192a"
            },
            customer: {
                email: "" + data[6][0] + "",
                phone_number: "" + data[6][1] + "",
                name: "" + data[6][2] + ""
            },
            callback: function(data) {
                console.log(data);
            },
            onclose: function() {
                // close modal
            },
            customizations: {
                title: "" + data[7][0] + "",
                description: "",
                logo: "" + data[7][1] + ""
            }
        });
    });

    //paypal
    livewire.on("initPaypalPayment", mainData => {
        //
        paypal
            .Buttons({
                createOrder: function(data, actions) {
                    // This function sets up the details of the transaction, including the amount and line item details.
                    return actions.order.create({
                        purchase_units: [
                            {
                                amount: {
                                    value: mainData[0],
                                    currency: mainData[1],
                                }
                            }
                        ]
                    });
                },
                onApprove: function(data, actions) {
                    // This function captures the funds from the transaction.
                    return actions.order.capture().then(function(details) {
                        window.location.href = "" + mainData[2] + "&transaction_id="+details["id"]+"";
                    });
                }
            })
            .render("#paypal-button-container");


    });
});
