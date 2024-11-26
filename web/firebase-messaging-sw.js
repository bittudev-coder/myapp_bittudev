importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
            apiKey: 'AIzaSyBHAWx0wzXJSRILnrJdNTv4Xaf3oweCJu8',
            appId: '1:105601428954:web:daea666182fa3d2a34a4e3',
            messagingSenderId: '105601428954',
            projectId: 'bittu-dev',
            authDomain: 'bittu-dev.firebaseapp.com',
            storageBucket: 'bittu-dev.firebasestorage.app',
            measurementId: 'G-T4YEMTYFWR',
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});
