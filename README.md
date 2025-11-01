# Firebase Emulator Docker Setup

This repository contains a Docker setup for running Firebase Emulators locally.

# Reference
https://firebase.google.com/docs/emulator-suite

## Quick Start

1. Initial Setup
```bash
mkdir app
touch firebase.json .firebaserc storage.rules
```
1. firebaserc

```json
{
  "projects": {
    "default": "your-project-id"
  }
}
```

firebase.json
```json
{
  "storage": {
    "rules": "storage.rules"
  },
  "emulators": {
    "auth": {
      "port": 9099
    },
    "firestore": {
      "port": 9199
    },
    "storage": {
      "port": 9299
    },
    "ui": {
      "enabled": true
    },
    "singleProjectMode": true
  }
}

```

storage.rules
```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
        allow read, write: if request.auth != null;
        allow read;
    }
  }
}
```

2. Run the container:
```bash
docker run -v $(pwd)/app:/app --network=host -e FIREBASE_EMULATOR_USER=$(id -nu) -e FIREBASE_EMULATOR_UID=(id -u) ste80pa/firebase
```

## Initial Setup

To initialize Firebase in your project:

1. Clone this repository
2. Run the container with volume mapping:
```bash
docker run -v $(pwd):/app ste80pa/firebase firebase init
```

This will create the necessary Firebase configuration files in your project directory.
