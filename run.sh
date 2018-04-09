#!/bin/sh

build () {
    docker run -it -v "$HOME/.gradle":/root/.gradle -v $(pwd):/opt/workspace pondthaitay/build-tools-android fastlane build
}

deploy () {
    docker run -it -v="$HOME/.gradle":/root/.gradle -v $(pwd):/opt/workspace pondthaitay/build-tools-android fastlane deploy
}

"$@"