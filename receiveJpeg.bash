#!/usr/bin/env bash

# This script displays all MJPEG video streams from ports 8080, 8082, 8084, and 8086

# Handle SIGINT
cleanup() {
	echo "Closing all gst-streamer instances.."
	stty echo
	pkill -P $$
	exit 0
}

trap cleanup SIGINT

stty -echo

# Get local IP
ip=$(hostname -I | cut -d " " -f 1)

for i in {0..6..2}
do
	port="808${i}"
	echo "Starting up receiver on port $port..."
	gst-launch-1.0 udpsrc address=$ip port=$port ! application/x-rtp, payload=96 ! rtpjpegdepay ! jpegdec ! autovideosink sync=false > /dev/null &
done

# Idle until SIGINT is raised
sleep infinity

