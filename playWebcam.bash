gst-launch-1.0 v4l2src device=/dev/video0 ! image/jpeg,framerate=30/1,width=1280,height=720 ! rtpjpegpay quality=100 ! udpsink host=192.168.1.189 port=8080

