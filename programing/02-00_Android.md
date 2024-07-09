# Android

**Step 0:** Download

Go to <https://developer.android.com/studio> and
download the "Command line tools" for linux.
For simplicity rename it to `commandlinetools.zip`
and go to the directory of downloaded file.

**Step 1:** Install the command line tools

Unzip the `commandlinetools.zip` installing the package in the
`Development Environment`:

```sh
mkdir "$DEV_HOME/.packages/android"
unzip commandlinetools.zip -d "$DEV_HOME/.packages/android"
```

**Step 2:** Environment variables

```sh
cat >> "${DEV_HOME}/env.sh" <<EOF
# Android
export ANDROID_HOME="\${DEV_HOME}/.packages/android"
export PATH="\${ANDROID_HOME}/cmdline-tools/bin:\${PATH}"

EOF
```

**Step 3:** Install the SDK

```sh
. "${DEV_HOME}/env.sh"
yes | sdkmanager --sdk_root="${ANDROID_HOME}" --licenses
```

See the list

```sh
sdkmanager --list --sdk_root="${ANDROID_HOME}"
```

Choosen ``build-tools`, `ndk` and `platforms` (also `cmake`, if you already don't have) and install, e.g.,

```sh
sdkmanager --sdk_root="${ANDROID_HOME}" "build-tools;35.0.0"
sdkmanager --sdk_root="${ANDROID_HOME}" "platform-tools"
sdkmanager --sdk_root="${ANDROID_HOME}" "platforms;android-24"
sdkmanager --sdk_root="${ANDROID_HOME}" "ndk;24.0.8215888"
```
