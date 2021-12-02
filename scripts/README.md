# Notes

## Setup Xcode

```shell
xcode-select --install
# Install Xcode from the App store
sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -license accept
# Check path and version
xcode-select -p
xcodebuild -version
```

## Configuring GPG sign key

Run the following to add a config line to file `~/.gnupg/gpg-agent.conf`:

```shell
echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent
```

## Install from the App Store

- Xcode
- 1password
- NordVPN

## Optional software that can be installed via brew cask

- `gimp` - Photo editing
- `insomnia` - API testing
- `beekeeper-studio` - SQL viewer
- `mongodb-compass` - NoSQL viewer
