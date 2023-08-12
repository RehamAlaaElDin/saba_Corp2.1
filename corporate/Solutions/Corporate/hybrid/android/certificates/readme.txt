Android requires that all apps be digitally signed with a certificate before they can be installed.
Android uses this certificate to identify the author of an app, and the certificate does not need to be signed by a certificate authority.

Android apps often use self-signed certificates. The app developer holds the certificate's private key.
For more information on how to use certificates, review the App-Signing Guide and similar topics on the developer.android.com website.

In case Firebase push notifications are used, then your google-services.json file needs to be configured in the 
Android Profile specific dialogue in the Deployer IDE. You must download the real file from the Firebase Console 
using your Google Developer account as the file provided in the template folder is just a sample with dummy values. 

For more information on how to use Firebase push notifications, review the Firebase Cloud Messaging documentation at  
https://firebase.google.com/docs/cloud-messaging and the https://console.firebase.google.com/ websites.
