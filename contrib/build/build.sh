#!/bin/bash

export APP_ANDROID_ARCH=${APP_ANDROID_ARCH:-armeabi-v7a}
export RELEASE=${RELEASE:-debug}

source contrib/build/version_env.sh

# patch buildozer to support APK_VERSION_CODE env
VERCODE_PATCH_PATH=/home/buildozer/build/contrib/build/
VERCODE_PATCH="$VERCODE_PATCH_PATH/read_apk_version_code.patch"

echo "APK_VERSION=${APK_VERSION}"
echo "VERSION_CODE=${VERSION_CODE}"
echo "APP_ANDROID_ARCH=${APP_ANDROID_ARCH}"

DOCKER_CMD="pushd /opt/buildozer"
DOCKER_CMD="$DOCKER_CMD && patch -p0 < $VERCODE_PATCH && popd"
DOCKER_CMD="$DOCKER_CMD && buildozer android ${RELEASE}"

sudo chown -R 1000 .
docker run -it --rm \
    --env APP_ANDROID_ARCH=$APP_ANDROID_ARCH \
    --env APK_VERSION_CODE=$VERSION_CODE \
    -v $(pwd):/home/buildozer/build \
    -t zebralucky/electrum-dash-winebuild:Kivy40x bash -c \
    "$DOCKER_CMD"
