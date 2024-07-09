# Android

In this text I show how to set up the *Development Environment*
to code for android and how to compile and package android projects.

## Set up

To code for android you NEED to get the android SDK,
you also must have the android NDK. The most easy and less memory way
to manage these tools is using the "Command line tools".

*  **Step 0:** Command line tools

   Go to <https://developer.android.com/studio> and
   download the "Command line tools" for linux.
   For simplicity rename it to `commandlinetools.zip`
   and, in the teeminal shell, go to the directory of downloaded file.

   Now unzip the `commandlinetools.zip` installing the package in the
   `Development Environment`:

   ```sh
   mkdir "${DEV_HOME}/.packages/android"
   unzip commandlinetools.zip -d "$DEV_HOME/.packages/android"
   ln -sf "{$DEV_HOME}/.packages/android/cmdline-tools/bin/sdkmanager" "${DEV_HOME}/bin/sdkmanager"
   ```

   Finally, set up the environment variable `ANDROID_HOME` in the `${DEV_HOME}/env.sh`.
   You may use `nano` or other text editor to put in `${DEV_HOME}/env.sh` the following lines:

   ```sh
   # Android
   export ANDROID_HOME="${DEV_HOME}/.packages/android"
   ```

   And reestart the shell or type:

   ```sh
   export ANDROID_HOME="${DEV_HOME}/.packages/android"
   ```

*  **Step 1:** Software development kit (SDK)

   You need to read the licences:

   ```sh
   yes | sdkmanager --sdk_root="${ANDROID_HOME}" --licenses
   ```
   Now, see the list of availables tools with:

   ```sh
   sdkmanager --list --sdk_root="${ANDROID_HOME}"
   ```

   And choosen `build-tools` and `platforms` (also `cmake`, if you already don't have) and install, e.g.,

   ```sh
   sdkmanager --sdk_root="${ANDROID_HOME}" "platform-tools"
   sdkmanager --sdk_root="${ANDROID_HOME}" "build-tools;35.0.0"
   sdkmanager --sdk_root="${ANDROID_HOME}" "platforms;android-24"
   ```

*  **Step 2:** Native development kit (NDK)

   In a similar way, to install the NDK chossen the `ndk` and use, for example:

   ```sh
   sdkmanager --sdk_root="${ANDROID_HOME}" "ndk;24.0.8215888"
   ```

## Coding
