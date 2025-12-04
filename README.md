![Docker Pulls](https://img.shields.io/docker/pulls/ste80pa/firebase)

# Firebase Emulator Docker Setup

This repository contains a Docker setup for running Firebase Emulators locally. 

## Quick Reference
- Documentation [Firebase emulator suite official page](https://firebase.google.com/docs/emulator-suite)
- Firebase Tools GitHub repository [https://github.com/firebase/firebase-tools/releases](https://github.com/firebase/firebase-tools/releases)
- GitHub repository [https://github.com/ste80pa/firebase](https://github.com/ste80pa/firebase)
- Docker Hub [https://hub.docker.com/r/ste80pa/firebase](https://hub.docker.com/r/ste80pa/firebase)

## Initial Setup

To initialize Firebase in your project:

### Login

```bash
docker run -it -v $(pwd)/app:/app -p 9005:9005 -e FIREBASE_EMULATOR_USER=$(id -nu) -e FIREBASE_EMULATOR_UID=(id -u) ste80pa/firebase login
```

### Init

```bash
docker run -it -v $(pwd)/app:/app  -e FIREBASE_EMULATOR_USER=$(id -nu) -e FIREBASE_EMULATOR_UID=$(id -u) ste80pa/firebase init
```

### Run emulators

```bash
docker run -v $(pwd)/app:/app -p 4000:4000 -p 9099:9099 -e FIREBASE_EMULATOR_USER=$(id -nu) -e FIREBASE_EMULATOR_UID=(id -u) ste80pa/firebase
```

## Manual setup

### Manually create configration files

```bash
mkdir app
cd app
touch firebase.json .firebaserc storage.rules
```

firebaserc

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
      "host": "0.0.0.0",
      "port": 9099
    },
    "firestore": {
      "host": "0.0.0.0",
      "port": 9199
    },
    "storage": {
      "host": "0.0.0.0",
      "port": 9299
    },
    "ui": {
      "host": "0.0.0.0",
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

### Run the container
```bash
docker run -v $(pwd)/app:/app -p 4000:4000 -p 9199:9199 -p 4000:4000 -p 9299:9299 -e FIREBASE_EMULATOR_USER=$(id -nu) -e FIREBASE_EMULATOR_UID=(id -u) ste80pa/firebase
```