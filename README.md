# Grocery App Prototype 

An earlier Flutter grocery shopping project revisited and cleaned up for my portfolio.

Built with Flutter and Firebase, featuring authentication, product browsing, search, cart, favorites, and image upload functionality.

> This is a prototype project. Checkout, payments, orders, and shipping are not implemented.

## Setup

See [source inventory](docs/SOURCE_INVENTORY.md) to review the project structure and active source files.
See [Firebase setup guide](docs/FIREBASE_SETUP.md) to configure your own Firebase project.

## Firebase Phone Authentication

This project also includes a Firebase Phone Authentication flow that I originally worked on during my Flutter learning journey in **2023**.

The implementation supports:

* International phone number input using [`intl_phone_field`](https://pub.dev/packages/intl_phone_field)
* Firebase SMS verification
* 6-digit OTP input using [`pinput`](https://pub.dev/packages/pinput)
* Android/iOS phone authentication
* Firebase credential sign-in

### Code Example

The Firebase Phone Authentication implementation is available as a GitHub Gist:

**[View Firebase Phone Authentication Gist](https://gist.github.com/AhmxAli07/8588acee5cea3133b772135e8beb483b)**
