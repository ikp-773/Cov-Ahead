![BFH Banner](https://trello-attachments.s3.amazonaws.com/542e9c6316504d5797afbfb9/542e9c6316504d5797afbfc1/39dee8d993841943b5723510ce663233/Frame_19.png)
# Cov Ahead
Cov Ahead is a mobile application where shopkeepers have an app that shows QR code and users can scan this QR code which will automatically add that user to the visitor list. This should replace manual entry of contact details in the shop due to COVID. 
## Team members
1. [Deepak Mathews Koshy](https://github.com/deepakmkoshy)
2. [Sarath Radhakrishnan
](https://github.com/sarathradhakrishnan)
## Team Id
 BFH/rec2Gg87JODhKATrd/2021
## Link to product walkthrough

[Project Walkthrough and Code Explanation](https://drive.google.com/file/d/1OithQH27MtdlVbcdTT7XVf-w-Pw7sG4E/view?usp=sharing)

## How it Works ?

1. This application is for both Customers and Shop Owners.
2. Once you choose your role you are requested to Sign In. 
3. For customer it directly takes you to QR scanner. You could also update your information and check the shops you have visited.
4. For Shop Owners once they Sign Up they are taken to their dashboard to show all the people that visited the shop. You can also update the shop details anytime and view your own QR code.

## Libraries used
- cloud_firestore -  2.1.0
- firebase_auth - 1.1.4
- firebase_core - 1.1.1
- get - 4.1.4
- google_sign_in - 5.0.3
- pretty_qr_code - 2.0.1
- provider - 5.0.0
- qr_code_scanner - 0.4.0
- shared_preferences - 2.0.5

## How to configure

#### 1. [Flutter Environment Setup](https://flutter.dev/docs/get-started/install)

#### 2. Clone the repo

```sh
$ git clone https://github.com/ikp-773/Cov-Ahead.git
$ cd Cov-Ahead/
```

#### 3. Setup the firebase app

1. You'll need to create a Firebase instance. Follow the instructions at https://console.firebase.google.com.
2. Once your Firebase instance is created, you'll need to enable Google authentication.

* Go to the Firebase Console for your new instance.
* Click "Authentication" in the left-hand menu
* Click the "sign-in method" tab
* Click "Google" and enable it
* Click "Email/Password" and enable it

3. Enable the Firebase Database
* Go to the Firebase Console
* Click "Firestore Database" in the left-hand menu
* Click the "Create Database" button
* It will prompt you to set up, rules, for the sake of simplicity, let us choose test mode, for now.
* On the next screen select any of the locations you prefer.

4. In the Firebase console, in the settings of your Android app, add your SHA-1 key by clicking "Add Fingerprint".

5. Download google-services.json and place `google-services.json` into `/android/app/`.

## How to Run

1. `flutter pub get`
2. `flutter run`
