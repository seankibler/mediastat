# frozen_string_literal: true

source "https://rubygems.org"

# Fork of original that includes a modification to bypass
# HEAD request check on AWS S3 Presigned URLs.
gem 'streamio-ffmpeg',
  git: 'https://github.com/seankibler/streamio-ffmpeg.git',
  tag: 'v3.0.3'

gem 'httparty', '~> 0.22.0'

group :development, :test do
  gem 'rspec', '~> 3.13.0'
end
