require_relative './audio_device'
require_relative './voice_activity_detector'

class VoiceRecorder
  def record
    device = AudioDevice.new
    voice_detector = VoiceActivityDetector.new
    device.start_capture

    loop do
      frame = device.next_frame
      save_to_file(frame)

      break if voice_detector.voice_ended?(frame)
    end

    device.end_capture
  end

  def save_to_file frame
    # buffer audio data and write data every few calls
  end

  def flush_file
    # flush any remaining buffered audio
  end
end

