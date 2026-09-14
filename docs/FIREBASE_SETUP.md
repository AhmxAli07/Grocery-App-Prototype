# Firebase Setup Guide

This project uses:

- Firebase Authentication
- Cloud Firestore
- Firebase Storage

It does **not** use Realtime Database, Google Sign-In, Analytics, Cloud Functions, or a payment backend.

> This repository does not include a ready-to-use Firebase backend.  
> To run the Firebase features, connect the project to a Firebase project that you own.

---

## 1. Create or Select a Firebase Project

Open the [Firebase Console](https://console.firebase.google.com/) and either:

- create a new Firebase project, or
- select an existing project that you own.

Do not reuse Firebase configuration from an unrelated project.

---

## 2. Install Firebase Tools

Install the Firebase CLI:

```bash
npm install -g firebase-tools
```

Log in:

```bash
firebase login
```

Install FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
```

---

## 3. Configure FlutterFire

From the project root, run:

```bash
flutterfire configure
```

Select your Firebase project and the platforms you want to configure.

This command generates:

```text
lib/firebase_options.dart
```

The repository may ignore this file, so each developer should generate their own Firebase configuration.

Official guide:

https://firebase.google.com/docs/flutter/setup

---

## 4. Enable Firebase Authentication

In Firebase Console:

**Build → Authentication → Sign-in method**

Enable:

- Email/Password

Optional:

- Phone authentication

If you want to test Phone OTP authentication, configure the required platform settings and use Firebase test phone numbers during development.

---

## 5. Create Cloud Firestore

In Firebase Console:

**Build → Firestore Database → Create database**

The application expects the following collections.

| Purpose | Collection / Path | Required Fields |
|---|---|---|
| Home products | `design` | `name`, `image`, `price`, `unit` |
| Fruit products | `fruits` | `name`, `image`, `price`, `unit` |
| Dessert products | `deseart` | `name`, `image`, `price`, `unit` |
| Meat products | `Meats` | `name`, `image`, `price`, `unit` |
| Search | `Search` | product fields + `name_array` |
| User profile | `user/{uid}` | `username`, `email`, `uid` |
| Cart | `user/{uid}/cart/{id}` | product display fields |
| Favorites | `user/{uid}/fav/{id}` | product display fields |
| Uploaded photo metadata | `user/{uid}/photos/{id}` | `url`, `createdAt` |

Additional product-detail collections used by the prototype include:

Collection names are case-sensitive.

---

## 6. Configure Product Search

Search uses Firestore:

```dart
where('name_array', arrayContains: query.trim())
```

Therefore, searchable documents must include a `name_array` field.

Example:

```json
{
  "name": "Green Apple",
  "price": "250",
  "unit": "1 kg",
  "image": "https://example.com/apple.jpg",
  "name_array": ["green", "apple"]
}
```

Search is exact-token based. It is not fuzzy or full-text search.

---

## 7. Enable Firebase Storage

In Firebase Console:

**Build → Storage → Get started**

Uploaded images are stored under:

```text
users/{uid}/images/{id}
```

Photo metadata is stored under:

```text
user/{uid}/photos/{id}
```

---

## 8. Configure Security Rules

Do not use unrestricted Firebase rules for a public or production project.

Example rule files are included in:

```text
docs/firestore.rules.example
docs/storage.rules.example
```

Review and test them before deployment.

User-specific paths are only private when Firebase Security Rules enforce ownership.

---

## 9. Install Flutter Dependencies

Run:

```bash
flutter pub get
```

Then verify the project:

```bash
flutter analyze
flutter test
```

---

## 10. Run the App

For Android:

```bash
flutter run
```

For Web:

```bash
flutter run -d chrome
```

iOS builds require macOS and Xcode.

---

## Official Firebase Documentation

Flutter setup:

https://firebase.google.com/docs/flutter/setup

Firebase API keys and client configuration:

https://firebase.google.com/docs/projects/api-keys
