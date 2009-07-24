require 'java'

import javax.sound.midi.MidiSystem
import javax.sound.midi.Sequence
import javax.sound.midi.MidiEvent
import javax.sound.midi.ShortMessage

while (line = gets) !~ /exit/
  seq = Sequence.new Sequence::PPQ, 2
  track = seq.create_track
  for i in 0...line.length do
    msg = ShortMessage.new
    msg.set_message(ShortMessage::NOTE_ON, line[i], 64)
    track.add MidiEvent.new(msg, i)
  end
  msg = ShortMessage.new
  msg.message = ShortMessage::STOP
  track.add MidiEvent.new msg, i + 1

  seqer = MidiSystem.sequencer
  seqer.open
  seqer.sequence = seq
  seqer.start
end
java.lang.System.exit(0)
