/*
Give the service worker access to Firebase Messaging.
Note that you can only use Firebase Messaging here, other Firebase libraries are not available in the service worker.
*/
importScripts("https://www.gstatic.com/firebasejs/8.3.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.3.1/firebase-analytics.js");
importScripts("https://www.gstatic.com/firebasejs/8.3.1/firebase-messaging.js");

/*
Initialize the Firebase app in the service worker by passing in the messagingSenderId.
* New configuration for app@pulseservice.com
*/
firebase.initializeApp({
apiKey: 'AIzaSyC646iCzzoPJj5yopKP61FVCgAeTkdVOaw',
projectId: 'fuodz-e9ebc',
messagingSenderId: '977502122572',
appId: '1:977502122572:web:a15f61fc6a1559d8c3bae9',
});
/*
Retrieve an instance of Firebase Messaging so that it can handle background messages.
*/
const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function(payload) {
    const notificationTitle = payload.notification.title;
    const notificationOptions = {
        body: payload.notification.body,
        icon: payload.notification.icon,
    };

    return self.registration.showNotification(
        notificationTitle,
        notificationOptions
    );
});