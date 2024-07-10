# Android

In this text I show how to set up the
[*Development Environment*](README.md)
to code for android and how to compile and package android projects.

## Prerequisites

To code for Android you need to set up at least Java,
since it's the language that the Android SDK interfaces.
If you plan to use the Android NDK than you also need to
set up C and/or C++.

* [C](01-00_C.md)
* [Java](01-02_Java)

You also can use the "Command line tools" to download and manage
both, the SDK and the NKD.

1. Download it at <https://developer.android.com/studio>.
2. Rename it to `commandlinetools.zip`.
3. Navigate with the terminal at the directory where is placed `commandlinetools.zip`.
4. Use the following commands to install it on the *Development Environment*:

   ```sh
   mkdir "${DEV_HOME}/.packages/android"
   unzip commandlinetools.zip -d "$DEV_HOME/.packages/android"
   ln -sf "${DEV_HOME}/.packages/android/cmdline-tools/bin/sdkmanager" "${DEV_HOME}/bin/sdkmanager"
   ```

5. Add the environment variable `ANDROID_HOME` in `${DEV_HOME}/env.sh`
   using `nano` or other text editor, put on it the following content:

   ```sh
   # Android
   export ANDROID_HOME="${DEV_HOME}/.packages/android"
   ```

   * At this point you can reestart your terminal or can type manually
     `export ANDROID_HOME="${DEV_HOME}/.packages/android"`.

6. Finally, read the licences, to start using the command line tools, with the command:

   ```sh
   yes | sdkmanager --sdk_root="${ANDROID_HOME}" --licenses
   ```

## Set up the Software development kit (SDK)

To develop Android applications you need the SDK. Get it with the steps of this section.

1. Chosen the version of "build tools", to see the available versions type:

   ```sh
   sdkmanager --list --sdk_root="${ANDROID_HOME}"
   ```

   You can choose the latest.

2. Download the "build tools" using the `sdkmanager`.
   For example, to download the version `35.0.0` use:

   ```sh
   sdkmanager --sdk_root="${ANDROID_HOME}" "build-tools;35.0.0"
   ```

3. Chosen the version of "platform" and install it.
   You can see the list of available versions with the command of step 1,
   but pay attention that only newer devices run the latest versions.
   For example, to install the version `android 24` use:

   ```sh
   sdkmanager --sdk_root="${ANDROID_HOME}" "platforms;android-24"
   ```

## Set up the Native development kit (NDK)

1. Chosen the version of "ndk" and install it.
   You can see the list of available versions with the command of step 1 of the SDK section,
   but pay attention that only newer devices run the latest versions.
   For example, to install the version `24.0.8215888` use:

   ```sh
   sdkmanager --sdk_root="${ANDROID_HOME}" "ndk;24.0.8215888"
   ```

## Coding
