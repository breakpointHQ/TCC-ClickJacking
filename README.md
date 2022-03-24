# TCC ClickJacking
A proof of concept for a ClickJacking attack on macOS.

## Why?
TCC (Transparency, Consent, and Control) restricts and control application access to certain features.
This can include things such as camera, microphone, location services, contacts, photos, Downloads/Desktop/Documents folders, and a bunch more.

The ability to bypass TCC can sometimes be the difference-maker in red team engagements.
ClickJacking is a fairly simple attack that can trick most users into giving away full control over their TCC database.


## Usage

1. This was only tested on macOS Monterey, the window location would likely need adjustments on different operating systems.
2. Clone this repository and navigate to the cloned directory.
3. Open the `Terminal` app, and execute:
```sh
$: swift ./tcc-clickjacking.swift
```

You should now see an immovable transparent window with an "OK" button. Behind it will be the TCC consent dialog, perfectly positioned so that clicking on the visible "OK" button would give the application access to your TCC database.

## Legal Disclaimer
Usage of this code for attacking targets without prior mutual consent is illegal. It's the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program. Only use for educational purposes.
