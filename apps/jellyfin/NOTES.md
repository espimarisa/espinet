# Notes

1. Navigate to Admin > Dashboard > Playback.
2. Select "Video Acceleration API (VAAPI) as the Hardware Acceleration option.
3. Set the VAAPI device path to `/dev/dri/renderD129` (my path to my RX 6600).
4. Enable hardware decoding for the following supported formats:
   - H264
   - HEVC
   - MPEG2
   - VC1
   - VP8
   - HEVC 10bit
   - VP9 10bit
5. Enable 10-Bit hardware decoding for HEVC and VP9.

## Enable Tone Mapping

1. Navigate to Admin > Dashboard > Playback.
2. Enable tone mapping.
3. Make sure VPP tone mapping is disabled.
