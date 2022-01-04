# android hello_world

In this text I shown how to make
a simples hello_world program for android
**without IDE** and without any resources (java only).

## Installations

Firt you need the Software Developer Kit (SDK),
the Java Developer Kit (JDK) and a key file.

1. To use SDK without IDE download the `Command line tools` [here](https://developer.android.com/studio#command-tools).
2. Uncompress the `Command line tools` (e.g. `unzip commandlinetools-linux.zip`).
3. Move the directory `cmdline-tools` for a convenient location and rename it to `SDK` (e.g. `mv cmdline-tools ~/.android/SDK`).
4. Go to `SDK/bin` and run (see note 1)
```bash
./sdkmanager --sdk_root=../ --list
./sdkmanager --sdk_root=../ "platforms;android-31"
./sdkmanager --sdk_root=../ platform-tools
./sdkmanager --sdk_root=../ "build-tools;31.0.0"
```
5. Download the JDK version 11 [here](https://jdk.java.net/java-se-ri/11) (>11 do not work for android java virtual machine).
6. Uncompress the JDK in a convenient directory and rename it to JDK (e.g. `unzip openjdk-11.zip ; mv jdk-11 ~/.android/JDK`).
7. Go to `JDK/bin` and make a key with `./keytool -genkey -keystore ~/.keystore -keyalg RSA`.
8. Make an script to compile your applications. For example (see note 2)
```bash
#!/bin/bash

# Script to compile a android application source.
# The argument of the scrit is the directory of the source code (e.g. `ac hello_world/`),
# this directory may be have the file `AndroidManifest.xml`, the `res` directory
# and subdirectories containing the java source files.

cd "$1"

# ###
# seting up the ambient variables
# ###
export JAVA_HOME="$HOME/.android/JDK"
export ANDROID_HOME="$HOME/.android/SDK"

export ANDROID_PLATFORM="$ANDROID_HOME/platforms/android-31"
export ANDROID_BUILD_TOOLS="$ANDROID_HOME/build-tools/31.0.0"
export ANDROID_TOOLS="$ANDROID_HOME/tools"

export PATH=$JAVA_HOME/bin:$ANDROID_BUILD_TOOLS:$ANDROID_TOOLS:$PATH

# ###
# Compile the code
# ###

# Compile the source code to Java bytecode (.java to .class)
javac -cp $ANDROID_PLATFORM/android.jar $(find . -name "*.java")

# Translate the bytecode from Java to Android (.class to .dex)
d8 --lib $ANDROID_PLATFORM/android.jar $(find . -name "*.class")

# Package up the resource files, including the manifest
aapt package -f \
-F app.apkPart \
-I $ANDROID_PLATFORM/android.jar \
-M AndroidManifest.xml \
-S res/

# Make the full APK using the `ApkBuilder` tool
CLASSPATH=$ANDROID_TOOLS/lib/* java \
com.android.sdklib.build.ApkBuilderMain app.apkUnalign \
-u -f classes.dex -z app.apkPart

# Optimize the data alignment of the APK
zipalign -f 4 app.apkUnalign app_aligned.apk

# Signer the APK
apksigner sign --ks ~/.keystore --out app.apk app_aligned.apk

# ###
# Remove generated files
# ###
rm app.apkUnalign
rm app_aligned.apk
rm app.apkPart
rm classes.dex
find . -name "*.class" -exec rm {} +

exit 0
```
9. Put the script in a bin directory (e.g. `~/bin/ac` of `/bin/ac` were `ac` is the script name) and make it executable (e.g. `chmod 755 ~/ac`).

Notes:  
1. `platforms;android-31` and `build-tools;31.0.0` say "Download tools to API 31 of android" but you can download another version, see disponible versions with `./sdkmanager --sdk_root=../ --list | grep "platforms;android"` and `./sdkmanager --sdk_root=../ --list | grep "build-tools;"`.
2. This script supose that you put the SDK and the JDK in `~/.android/SDK` and `~/.android/JDK` and supose that you downloaded the tools for android API 31.

Read more:
* https://developer.android.com/studio/command-line/

## Coding

You need basicaly two files, the `AndroidManifest.xml` and the `MainActivity.java`.
Eventually you need resources, for more advanced programs, in a directory called `res`, for this example the res directory are empty.

The content of `AndroidManifest.xml` is like the following.
```xml
<?xml version='1.0'?>

<manifest xmlns:android='http://schemas.android.com/apk/res/android'
   package='com.your_company.app'
   android:versionCode='0'>

   <application
      android:label='App name'>

      <activity
         android:name='com.your_company.app.MainActivity'>
         <intent-filter>
            <category android:name='android.intent.category.LAUNCHER'/>
            <action android:name='android.intent.action.MAIN'/>
         </intent-filter>
      </activity>

   </application>

</manifest>
```

The content of `MainActivity.java` is like the following.
```java
package com.your_company.app;

import android.app.Activity;
import android.widget.TextView;
import android.os.Bundle;

public final class MainActivity extends Activity {
   @Override
   protected void onCreate(final Bundle activityState){
      super.onCreate(activityState);
      final TextView textV = new TextView(MainActivity.this);
      textV.setText("Hello World");
      setContentView( textV );
   }
}
```

Is common to put the file `MainActivity.java` in a directory called `src/com/your_company/app/`. The file tree looks like the following.
```
hello_world/
 |
 |--- AndroidManifest.xml
 |--- res/
 |--- src/
       |--- com/
             |--- your_company/
                   |--- app/
                         |--- MainActivity.java
```

Suposing that you have a command that you inform the source directory and the command invokes a compiler for your source (see the section [installations](#installations) item 8) and the command name are `ac`, open the directory `hello_world` in a terminal and type
```bash
ac ./
```
Now copy the file `app.apk` to your phone and install it.
