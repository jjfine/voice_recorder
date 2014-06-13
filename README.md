# voice_recorder

The bulk of the work is in the VoiceActivityDetector class. It's job is to decide whether or not speech has ended during a frame of audio.

The AudioDevice and VoiceRecorder classes were just used to establish a frame for how the VoiceActivityDetector could be used.

The FrameCounter class encapsulates the logic around maintaining counts of runs of silence/voice and discarding smaller runs.

I use the term 'frame' to denote an array of numerical values representing a chunk of audio.

NOTE: This code doesn't really do anything since its not interfacing with any actual device.

## Algoirthm

For each frame of audio, calculate its energy.

For the first few frames:

1. Compute the minimum energy see.
2. Compute a threshold by multiplying the energy with some THETA

For the rest of the frames:

1. Compare this frame's energy with the computed threshold.
2. Increment the number of silent frames or frames with voice.
3. Reset the number of silent frames if > 5 frames with voice or vice versa.

Return true if there have been > 10 frames of silence.


If I did a good job, this should all be clear from the code!


