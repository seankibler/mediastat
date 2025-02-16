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

Run a local nginx serving up static files in examples. This allows for
testing against a really basic Nginx server.

    docker run --rm -v $(pwd)/examples:/usr/share/nginx/html:ro -p 8000:80 nginx


The stderr redirection to /dev/null just keeps the test output clean. It
can be removed to see the stderr output when invalid arguments are
passed ex: invalid URL, 404 etc.

Natively

    bundle exec rspec spec/ 2>/dev/null

Docker

    docker build -t mediastat:latest .
    docker run -v $(pwd):/app --entrypoint rspec mediastat:latest spec 2>/dev/null
