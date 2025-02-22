require 'json'

ROOT = Dir.pwd
RSpec.describe 'mediastat' do
  it 'should read an AVI video from S3 over HTTPS' do
    response = %x(bundle exec mediastat https://mediastat.s3.us-east-1.amazonaws.com/video/big_buck_bunny_480p_surround-fix.avi)
    response_json = JSON.parse(response)

    expect($?).to eq(0)
    expect(response_json.fetch("duration")).to eq(596)
    expect(response_json.fetch("type")).to eq('video')
    expect(response_json.fetch("fps")).to eq(24)
  end

  it 'should read an AVI video from an nginx HTTP server' do
    response = %x(bundle exec mediastat https://mediastat.s3.us-east-1.amazonaws.com/video/big_buck_bunny_480p_surround-fix.avi)
    response_json = JSON.parse(response)

    expect($?).to eq(0)
    expect(response_json.fetch("duration")).to eq(596)
    expect(response_json.fetch("type")).to eq('video')
    expect(response_json.fetch("fps")).to eq(24)
  end

  it 'should read an MP3 audio from HTTP server' do
    response = %x(bundle exec mediastat https://mediastat.s3.us-east-1.amazonaws.com/audio/back-to-the-electric-church.mp3)
    response_json = JSON.parse(response)

    expect($?).to eq(0)
    expect(response_json.fetch("duration")).to eq(273)
    expect(response_json.fetch("type")).to eq('audio')
  end

  it 'should read an MP3 audio from local file URI' do
    response = %x(bundle exec mediastat file://#{ROOT}/examples/back-to-the-electric-church.mp3)
    response_json = JSON.parse(response)

    expect($?).to eq(0)
    expect(response_json.fetch("duration")).to eq(273)
    expect(response_json.fetch("type")).to eq('audio')
  end

  it 'should read an MP3 audio from an absolute local path' do
    response = %x(bundle exec mediastat #{ROOT}/examples/back-to-the-electric-church.mp3)
    response_json = JSON.parse(response)

    expect(response_json.fetch("duration")).to eq(273)
    expect(response_json.fetch("type")).to eq('audio')
  end

  it 'should read an MP3 audio from relative local path' do
    response = %x(bundle exec mediastat ./examples/back-to-the-electric-church.mp3)
    response_json = JSON.parse(response)

    expect($?).to eq(0)
    expect(response_json.fetch("duration")).to eq(273)
    expect(response_json.fetch("type")).to eq('audio')
  end

  it 'should fail with non-zero exit code on a URL' do
    response = %x(bundle exec mediastat host-containers-internal-9000-back-to-the-electric-church-mp3)
    expect($?.exitstatus).to be > 0
  end

  it 'should fail with non-zero exit code on a URL that returns a 404' do
    response = %x(bundle exec mediastat https://mediastat.s3.us-east-1.amazonaws.com/audio/not_here.mp3)
    expect($?.exitstatus).to be > 0
  end

  it 'should fail with non-zero exit code on a URL that returns a 403' do
    response = %x(bundle exec mediastat http://host.containers.internal:8000/not-permitted.mp3)
    expect($?.exitstatus).to be > 0
  end

  it 'should fail with non-zero exit code on a files that are not audio/video' do
    response = %x(bundle exec mediastat #{ROOT}/examples/Radeon-RX-5700-XT-GAMING-X.pdf)
    expect($?.exitstatus).to be > 0
  end
end
