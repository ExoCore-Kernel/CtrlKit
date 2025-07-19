# CtrlKit
iOS jailbreak Framework for Tweaks and Tools

## Features

- `CKIPCObserver` - simple interface for monitoring mach notifications to help
  debug inter-process communication on jailbroken devices.

## Building

This project uses [Theos](https://theos.dev) for its build system. A copy of
Theos is included in this repository. Before building you must ensure the
necessary SDKs and toolchains are available. Run the provided setup script once
to download these dependencies:

```sh
./setup_theos.sh
```

If you don't already have the `THEOS` environment variable set, `make` will
default to the bundled copy. After running the setup script you can build the
framework with:

```sh
make -C CtrlKit
```

## Updating

Use the `update.sh` script to sync your checkout with the configured remote repository. The script defaults to the `origin` remote.

```sh
./update.sh [remote]
```

