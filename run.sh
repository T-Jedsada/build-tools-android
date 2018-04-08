#!/bin/sh

build () {
    docker run -it --privileged --volume=$(pwd):/opt/workspace pondthaitay/build-tools-android fastlane build
}

deploy () {
    docker run -it --privileged --volume=$(pwd):/opt/workspace pondthaitay/build-tools-android fastlane deploy
}

"$@"