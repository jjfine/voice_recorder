require_relative './frame_counter'

class VoiceActivityDetector
  def initialize 
    @baseline_frames_seen = 0
    @frame_counter = FrameCounter.new
    @min_baseline_energy = Float::INFINITY
  end

  def voice_ended? frame
    frame_energy = energy(frame)

    if finished_building_threshold?
      update_frame_counts frame_energy
    else
      build_energy_threshold frame_energy
    end

    enough_frames_of_silence?
  end

  private

  def update_frame_counts frame_energy
    if contains_speech?(frame_energy)
      @frame_counter.increment_voice
    else
      @frame_counter.increment_silence
    end
  end

  def energy frame
    frame.inject(0) { |acc, amplitude| acc + amplitude**2 }
  end

  def build_energy_threshold frame_energy
    @min_baseline_energy = [@min_baseline_energy, frame_energy].min
    @energy_threshold = @min_baseline_energy * ENERGY_THETA
    @baseline_frames_seen += 1
  end

  def contains_speech? frame_energy
    frame_energy > @energy_threshold
  end

  def finished_building_threshold?
    @baseline_frames_seen > BASELINE_FRAMES_NEEDED
  end

  def enough_frames_of_silence?
    @frame_counter.silence > SILENCE_THRESHOLD
  end
end

SILENCE_THRESHOLD = 10
BASELINE_FRAMES_NEEDED = 3
ENERGY_THETA = 1.2

