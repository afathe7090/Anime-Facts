#!/bin/sh

install_homebrew() {
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_fastlane() {
    echo "Installing Fastlane..."
    brew install fastlane
}

run_fastlane() {
    echo "Run Fastlane block action"
    fastlane custom_lane
}

# Check if Fastlane is installed
if command -v fastlane &> /dev/null
then
    echo "Fastlane is installed."
    run_fastlane
else
    echo "Fastlane is not installed. Proceeding with installation..."
    install_fastlane
    if [ $? -eq 0 ]; then
        run_fastlane
    else
        echo "Failed to install Fastlane. Please try again."
    fi
fi
