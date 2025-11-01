#!/bin/bash
set -e

# Check if UID or USER is unset, fallback to UID 1000
if [ -z "${FIREBASE_EMULATOR_UID}" ] || [ -z "${FIREBASE_EMULATOR_USER}" ]; then
  echo "⚠️ FIREBASE_EMULATOR_UID or FIREBASE_EMULATOR_USER not set. Defaulting to UID 1000 and user 'firebase'."
  FIREBASE_EMULATOR_UID=1000
  FIREBASE_EMULATOR_USER=firebase
fi

# Create user if it doesn't exist
if ! id -u "${FIREBASE_EMULATOR_USER}" > /dev/null 2>&1; then
  echo "🔧 Creating user ${FIREBASE_EMULATOR_USER} with UID ${FIREBASE_EMULATOR_UID}..."
  useradd -m -d /app/ -u "${FIREBASE_EMULATOR_UID}" -s /bin/bash "${FIREBASE_EMULATOR_USER}"
fi

if [ -d /app ]; then
  echo "🔧 Fixing ownership of /app..."
  chown -R "$FIREBASE_EMULATOR_USER" /app
fi
echo "🚀 Starting Firebase Emulators as user ${FIREBASE_EMULATOR_USER}..."
echo

exec gosu "$FIREBASE_EMULATOR_USER" firebase "$@"