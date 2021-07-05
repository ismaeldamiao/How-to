# Speeding up/slowing down video

In this text I show how to increase or decrease the speed of a video.

## Steps

Supose that:
* `input` is the original video file (with extension).
* `output` is the fast/slow video (with extension).
* `value` is the inverse of the velocity (`value=0.25` for 4x more fast, `value=2` for 2x more slow).

You need have installed `ffmpeg`.

The command are:
```bash
ffmpeg -i input -vf "setpts=value*PTS" output
```
