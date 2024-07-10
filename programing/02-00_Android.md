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

4. Make the symlinks to the utilities with:

   ```sh
   ln -sf "${ANDROID_HOME}/build-tools/35.0.0/d8" "${DEV_HOME}/bin/d8"
   ln -sf "${ANDROID_HOME}/build-tools/35.0.0/aapt" "${DEV_HOME}/bin/aapt"
   ln -sf "${ANDROID_HOME}/build-tools/35.0.0/zipalign" "${DEV_HOME}/bin/zipalign"
   ln -sf "${ANDROID_HOME}/build-tools/35.0.0/apksigner" "${DEV_HOME}/bin/apksigner"
   ```

## Set up the Native development kit (NDK)

1. Chosen the version of "ndk" and install it.
   You can see the list of available versions with the command of step 1 of the SDK section,
   but pay attention that only newer devices run the latest versions.
   For example, to install the version `24.0.8215888` use:

   ```sh
   sdkmanager --sdk_root="${ANDROID_HOME}" "ndk;24.0.8215888"
   ```

## Coding Java apps

1. Your file structure must look like:

   ```
   .
   ├── AndroidManifest.xml
   ├── com
   │   └── your_company
   │       └── app
   │           └── <java files>
   └── res
       └── <resource files>
   ```

2. Compile the java files with:

   ```sh
   javac -cp "${ANDROID_HOME}/platforms/android-24/android.jar" $(find . -name "*.java")
   d8 --lib "${ANDROID_HOME}/platforms/android-24/android.jar" $(find . -name "*.class")
   ```

   But pay attention, in the above command you need to use the "platforms" version that you have.

3. Package up the apk with:

   ```sh
   aapt package -f \
      -F app.apkPart \
      -I $ANDROID_PLATFORM/android.jar \
      -M AndroidManifest.xml \
      -S res/
   zipalign -f 4 app.apkUnalign app_aligned.apk
   apksigner sign --ks "${ANDROID_HOME}/.keystore" --out app.apk app_aligned.apk
   ```

## Coding Java apps with JNI calls

## Coding native apps

1. Your file structure must look like:

   ```
   .
   ├── AndroidManifest.xml
   ├── C
   │   └── <C files>
   ├── lib
   │   └── armeabi-v7a
   └── res
       └── <resource files>
   ```

2. Compile the C files with:

   ```sh
   cc \
      --target=armv7a-linux-androideabi24 \
      -nostdinc -nostdlib \
      -I "${ANDROID_HOME}/ndk/24.0.8215888/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include" \
      -I "${ANDROID_HOME}/ndk/24.0.8215888/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/linux" \
      -I "${ANDROID_HOME}/ndk/24.0.8215888/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/arm-linux-androideabi" \
      -I "${ANDROID_HOME}/ndk/24.0.8215888/sources/android/native_app_glue" \
      -L "${ANDROID_HOME}/ndk/24.0.8215888/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/arm-linux-androideabi" \
      --shared -o lib/armeabi-v7a/main.so \
      "${ANDROID_HOME}/ndk/24.0.8215888/sources/android/native_app_glue/android_native_app_glue.c" \
      $(find . -name "*.c")
   ```

   But pay attention, in the above command you need to use the "platforms" version that you have.

3. Package up the apk with:

   ```sh
   aapt package -f \
      -F app.apkPart \
      -I $ANDROID_PLATFORM/android.jar \
      -M AndroidManifest.xml \
      -S res/
   zipalign -f 4 app.apkUnalign app_aligned.apk
   apksigner sign --ks "${ANDROID_HOME}/.keystore" --out app.apk app_aligned.apk
   ```










