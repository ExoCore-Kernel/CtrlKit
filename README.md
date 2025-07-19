# CtrlKit
iOS jailbreak Framework for Tweaks and Tools

## Features

- `CKIPCObserver` - simple interface for monitoring mach notifications to help
  debug inter-process communication on jailbroken devices.

## Building

This project uses [Theos](https://theos.dev) for its build system. A copy of
Theos is included in this repository. If you don't already have the `THEOS`
environment variable set, `make` will default to the bundled copy. Simply run:

```sh
make -C CtrlKit
```

If you encounter an error about missing SDKs, follow the instructions in the
Theos documentation to obtain the necessary iOS SDK.

## Updating

Use the `update.sh` script to sync your checkout with the configured remote repository. The script defaults to the `origin` remote.

```sh
./update.sh [remote]
```

