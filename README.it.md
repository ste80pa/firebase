![Docker Pulls](https://img.shields.io/docker/pulls/ste80pa/firebase)

**Lingue:**
- [English](README.md)
- [Italiano](README.it.md)

# Setup Docker per Firebase Emulator

Questo repository contiene una configurazione Docker per eseguire Firebase Emulator localmente utilizzando gli stessi permessi dell'utente corrente.

## Riferimenti Rapidi
- Documentazione [Pagina ufficiale Firebase emulator suite](https://firebase.google.com/docs/emulator-suite)
- Repository GitHub Firebase Tools [https://github.com/firebase/firebase-tools/releases](https://github.com/firebase/firebase-tools/releases)
- Repository GitHub [https://github.com/ste80pa/firebase](https://github.com/ste80pa/firebase)
- Docker Hub [https://hub.docker.com/r/ste80pa/firebase](https://hub.docker.com/r/ste80pa/firebase)

## Piattaforme Supportate

- `linux/amd64`
- `linux/arm64`
- `linux/arm/v7`
- `linux/arm/v6`

## Configurazione Iniziale

Per inizializzare Firebase nel tuo progetto:

### Login

```bash
docker run -it -v $(pwd)/app:/app -p 9005:9005 -e FIREBASE_EMULATOR_USER=$(id -nu) -e FIREBASE_EMULATOR_UID=$(id -u) ste80pa/firebase login
```

### Init

```bash
docker run -it -v $(pwd)/app:/app  -e FIREBASE_EMULATOR_USER=$(id -nu) -e FIREBASE_EMULATOR_UID=$(id -u) ste80pa/firebase init
```


### Run emulators

```bash
docker run -v $(pwd)/app:/app -p 4000:4000 -p 9099:9099 -e FIREBASE_EMULATOR_USER=$(id -nu) -e FIREBASE_EMULATOR_UID=(id -u) ste80pa/firebase
```

## Configurazione manuale

### Creazione manuale dei file di configurazione

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

### Esegui il container
```bash
docker run -v $(pwd)/app:/app -p 4000:4000 -p 9199:9199 -p 4000:4000 -p 9299:9299 -e FIREBASE_EMULATOR_USER=$(id -nu) -e FIREBASE_EMULATOR_UID=(id -u) ste80pa/firebase
```