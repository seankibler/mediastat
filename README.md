# Mediastat

A Ruby thing that ingests a URL-ish input argument and spits out facts
about audio or video.

Can take a HTTP(s) URL, a file:// URI, or a relative or absolute local
file path.

Outputs JSON to stdout with keys "duration", "type", and for video "fps".

## Requirements
- ffmpeg
- Ruby / Bundler

## Installation

Debian/Ubuntu

    sudo apt-get update && sudo apt-get install ffmpeg
    bundle install

## Examples

HTTP(S) link

    ./mediastat https://mediastat.s3.us-east-1.amazonaws.com/audio/back-to-the-electric-church.mp3

File URI

    ./mediastat file:///home/bigbuckbunny/video.mp4

File relative

    ./mediastat ./examples/back-to-the-electric-church.mp3

File absolute

    ./mediastat /home/bigbuckbunny/video.mp4

## Run Tests

    docker build -t mediastat:latest .
    docker run --rm -v $(pwd)/examples:/usr/share/nginx/html:ro -p 8000:80 nginx

Natively

    bundle exec rspec spec/

Docker

    docker run -v $(pwd):/app mediastat:latest rspec spec/
