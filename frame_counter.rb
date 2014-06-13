class FrameCounter
  def initialize threshold=5
    @silence = 0
    @voice = 0
    @threshold = threshold
  end

  def voice
    @voice
  end

  def silence
    @silence
  end
  
  def increment_voice
    @voice += 1
    @silence = 0 if @voice >= @threshold
  end

  def increment_silence
    @silence += 1
    @voice = 0 if @silence >= @threshold
  end
end
