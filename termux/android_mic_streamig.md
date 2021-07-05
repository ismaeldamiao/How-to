# Android mic streamig

In this text I show how to use your android phone as microphone for your pc desktop using `sox` over `ssh`.

## 1 - Configure the desktop

You need have a `pulseaudio` server running in your pc desktop.
Make a simple virtual microphone device using the following:
```bash
pactl load-module module-pipe-source source_name=virtmic file=/tmp/virtmic format=s32 rate=48000 channels=1
```

All OK.

### 1.1 - For Load virtual mic always

If you prefer, you can load the virtual mic in start of `pulseaudio` editing the file `/etc/pulse/default.pa`
(you need as root acess).
```bash
sudo su
echo "load-module module-pipe-source source_name=virtmic file=/tmp/virtmic format=s32 rate=48000 channels=1" >> /etc/pulse/default.pa
exit
```

Now restart `pulseaudio`.
```bash
pulseaudio --kill
pulseaudio --start
```

## 2 - Configure the android

In android you need have [Termux](https://f-droid.org/repository/browse/?fdid=com.termux) installed.
Now you need `sox` (audio software) for stream your microphone, `pulseaudio` for authorize `sox` to use the microphone
and `ssh` to share the stream to the desktop, install it in termux typing:
```bash
apt update
apt install -y sox pulseaudio openssh
```

If you don't know use `ssh`, read about it in internet.

To allow that `sox` use microphone, type:
```bash
echo "load-module module-sles-source" >> $PREFIX/etc/pulse/default.pa
```

Restart `pulseaudio`.
```bash
pulseaudio --kill
pulseaudio --start
```

Now, start the microphone stream with `sox -c 1 -r48000 -d -t s32 -` and can pipe to `cat`, for write
in the file `/tmp/virtmic`, in the desktop using `ssh`:
```bash
sox -c 1 -r48000 -d -t s32 - | ssh -p PC_SSH_PORT PC_USER@PC_IP 'cat > /tmp/virtmic'
```

All OK.

### 2.1 - Adding effects to the microphone

The streamer can be rewritten as:
```bash
sox \
   --channels 1 \
   --rate 48000 \
   --default-device \
   --type s32 \
   -
```

Where:
* `--channels`: 1 for mono, 2 for stereo.
* `--rate` is the sound frequency in Hz.
  * Note that the rate is the same in `module-pipe-source` argument in the virtual microphone.
* `--default-device` is the input device.
* `--type` is the audio type (`s32` = signed 32-bit integer).
  * Note that the type is the same in `module-pipe-source` argument in the virtual microphone.
* `-` is the output device, the `stdin`.

Before output device you can add effects from `sox`.
You can also add effects from `pulseaudio` editing `$PREFIX/etc/pulse/default.pa`.

For noise you can record 10 seconds for make a profile:
```bash
sox -c 1 -r 48000 -d -t s32 $PREFIX/tmp/noise.wav trim 0 10
sox -c 1 -r 48000 -t s32 $PREFIX/tmp/noise.wav -n noiseprof noise.prof
```

And use `noisered noise.prof 0.1` effect before `-` in `sox`.

### 2.2 - Making a script with notification settings

If you prefer, you can write a script for start and stop sound streamer.

Frist edit `~/.ssh/config` for make a alias for your pc desktop.
In my case the alias is `pc`.

For make a notification you need installed [termux-api application](https://f-droid.org/packages/com.termux.api/)
and termux-api package:
```bash
apt install -y termux-api
```

I put the code bellow in `$PREFIX/bin/mic_streamer`.
```bash
#!/bin/bash

# Make a notification for android microphone streaming
termux-notification \
   --icon settings_voice \
   --id 225 \
   --ongoing \
   --type default \
   --priority high \
   --title 'Microphone streamer' \
   --content 'The microphone is sharing to desktop' \
   --button1 'Stop' \
   --button1-action "kill $$; termux-notification --icon settings_voice --id 225 --title 'Microphone streamer' --content 'The microphone streamer has stopped.'"

# Stream the microphone and pipe it for ssh and cat the pipe in the file of the virtual microphone module
sox \
   --channels 1 \
   --rate 48000 \
   --default-device \
   --type s32 \
   - | ssh pc 'cat > /tmp/virtmic'

exit 0
```


## 3 - Read more

You can see all formats suported in [documentation](https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/SupportedAudioFormats/).
