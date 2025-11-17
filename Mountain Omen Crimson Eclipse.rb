#############################################################
#   UNIQUE VERSION V3 — “Mountain Omen // Crimson Eclipse”
#   Cinematic × Evangelion × Japanese × Tearful Shakuhachi
#############################################################

use_bpm 96

#############################################################
#   CUSTOM HIRAJOSHI NOTES (E HIRAJOSHI, MANUAL)
#############################################################
hira = [
  :e4, :fs4, :g4, :b4, :c5,
  :e5, :fs5, :g5, :b5, :c6,
  :e6, :fs6
]

#############################################################
# 1) OMEN PULSE — fractured temple heartbeat
#############################################################
live_loop :omen_pulse do
  sample :drum_tom_lo_hard, amp: 1.25, rate: 0.85
  sleep 0.5
  sample :drum_tom_mid_soft, amp: 0.9, rate: 1
  sleep 0.25
  sample :drum_tom_lo_hard, amp: 1.1, rate: 0.8
  sleep 0.75
  sample :bd_haus, amp: 0.8, rate: 0.65
  sleep 1.0   # total = 2.5 beats
end

#############################################################
# 2) LOW STRING DRONES — heavy horizon
#############################################################
live_loop :low_drones do
  sync :omen_pulse
  use_synth :dark_ambience

  root = [:e2, :b1, :c2, :d2, :e2].ring.tick
  play root,
    attack: 2.5,
    sustain: 4,
    release: 4,
    amp: 1.0
  sleep 4
end

#############################################################
# 3) SAGISU-STYLE STRING SWELLS — tragic harmony
#############################################################
live_loop :sagisu_strings do
  sync :omen_pulse
  use_synth :prophet

  chords = [
    chord(:e4, :sus2),
    chord(:c4, :madd9),
    chord(:d4, :sus4),
    chord(:b3, :m7),
    chord(:e4, :madd9)
  ]

  with_fx :reverb, mix: 0.9, room: 0.95 do
    play chords.ring.tick,
      attack: 0.25,
      sustain: 1.6,
      release: 1.8,
      cutoff: 85,
      amp: 1.1
  end

  sleep 5
end

#############################################################
# 4) SHAKUHACHI LEAD — “tears on the ridge”
#############################################################
live_loop :shaku_cry do
  sync :omen_pulse
  use_synth :hollow

  phrase = [
    :e5, :g5, :b5, nil,
    :c6, :b5, :fs5, :e5,
    nil, :g5, :e5, :c5,
    :b4, nil, :fs5, :e5
  ]

  with_fx :reverb, mix: 0.97, room: 1 do
    with_fx :echo, mix: 0.25, phase: 0.37, decay: 5 do
      phrase.each do |n|
        if n
          play n,
            attack: 0.09,
            release: 1.8,
            vibrato_rate: 6.8,
            vibrato_depth: 0.24,
            amp: 1.4,
            pan: rrand(-0.3, 0.3)
        end
        sleep 0.75
      end
    end
  end
end

#############################################################
# 5) TAIKO BASS — steps of a giant
#############################################################
live_loop :taiko_heart do
  sync :omen_pulse

  2.times do
    sample :bd_haus, amp: 0.9, rate: 0.6
    sleep 1.25
  end

  sample :bd_haus, amp: 1.1, rate: 0.55
  sleep 0.5
end

#############################################################
# 6) METAL OMENS — distant warning
#############################################################
live_loop :metal_omens do
  sync :omen_pulse

  with_fx :reverb, mix: 0.8, room: 0.9 do
    sample :elec_cymbal,
      amp: 0.22,
      rate: 0.45,
      pan: rrand(-0.35, 0.35)
  end

  sleep [2.5, 3.75, 5.0].choose
end

#############################################################
# 7) TEMPLE BELLS — spirits of the pass
#############################################################
live_loop :temple_bells do
  sync :omen_pulse
  use_synth :pretty_bell

  with_fx :reverb, mix: 0.9, room: 0.9 do
    2.times do
      play hira.choose,
        attack: 0.12,
        sustain: 0.8,
        release: 3.2,
        amp: 0.35,
        pan: rrand(-0.45, 0.45)
      sleep rrand(1.5, 2.5)
    end
  end

  sleep rrand(2, 4)
end

#############################################################
# 8) CHOIR PAD — eclipse over the valley
#############################################################
live_loop :fate_choir do
  sync :omen_pulse
  use_synth :dtri

  with_fx :reverb, mix: 0.88, room: 0.98 do
    play chord(:e3, :madd9),
      attack: 3.5,
      sustain: 4,
      release: 4,
      cutoff: 70,
      amp: 0.6
  end

  sleep 8
end

#############################################################
# 9) GHOST NOTES — broken memories
#############################################################
live_loop :ghost_plucks do
  sync :omen_pulse
  use_synth :pluck

  with_fx :echo, mix: 0.3, phase: 0.25, decay: 4 do
    3.times do
      n = hira.choose
      play n - [12, 0].choose,
        attack: 0.01,
        sustain: 0.2,
        release: 0.8,
        amp: 0.25,
        pan: rrand(-0.3, 0.3)
      sleep [0.5, 0.75, 1.0].choose
    end
  end

  sleep 2
end
