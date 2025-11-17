#############################################################
#   UNIQUE VERSION V2 — “Mountain Omen”
#   Cinematic × Evangelion × Japanese × Tearful Shakuhachi
#############################################################

use_bpm 96

#############################################################
#   CUSTOM HIRAJOSHI NOTES (MANUAL, COMPATIBLE)
#############################################################
hira = [
  :d4, :e4, :f4, :a4, :bb4,
  :d5, :e5, :f5, :a5, :bb5,
  :d6, :e6
]

#############################################################
# 1) MAIN RITUAL PULSE — the heartbeat of fate
#############################################################
live_loop :ritual do
  sample :drum_tom_lo_hard, amp: 1.3, rate: 0.8
  sleep 0.75
  sample :drum_tom_mid_hard, amp: 1.1, rate: 0.9
  sleep 0.5
  sample :drum_tom_lo_hard, amp: 1.3, rate: 0.8
  sleep 0.75
end

#############################################################
# 2) LOW STRING DRONES — dark cinematic weight
#############################################################
live_loop :low_strings do
  sync :ritual
  use_synth :dark_ambience

  root = [:d2, :bb1, :c2, :d2].ring.tick
  play root, attack: 2, sustain: 3, release: 3, amp: 0.9
  sleep 4
end

#############################################################
# 3) STRING STABS — signature Sagisu-style accents
#############################################################
live_loop :string_hits do
  sync :ritual
  use_synth :prophet

  chords = [
    chord(:d4, :sus2),
    chord(:bb3, :m7),
    chord(:c4, :sus4),
    chord(:d4, :madd9)
  ]

  with_fx :reverb, mix: 0.9, room: 0.95 do
    play chords.ring.tick,
      attack: 0.15,
      sustain: 1.2,
      release: 1.4,
      cutoff: 90,
      amp: 1.0
  end

  sleep 4
end

#############################################################
# 4) SHAKUHACHI LEAD — lyrical, wounded, emotional
#############################################################
live_loop :shaku do
  sync :ritual
  use_synth :hollow

  phrase = [
    :d5, :f5, :a5, nil,
    :bb5, :a5, :f5, :d6,
    nil, :e5, :d5, :a4
  ]

  with_fx :reverb, mix: 0.97, room: 1 do
    with_fx :echo, mix: 0.2, phase: 0.33, decay: 4 do
      phrase.each do |n|
        if n
          play n,
            attack: 0.08,
            release: 1.6,
            vibrato_rate: 6.5,
            vibrato_depth: 0.22,
            amp: 1.35,
            pan: rrand(-0.25, 0.25)
        end
        sleep 0.75
      end
    end
  end
end

#############################################################
# 5) TAIKO BASS — deep ancient heartbeat
#############################################################
live_loop :taiko do
  sync :ritual
  sample :bd_haus, amp: 0.7, rate: 0.6
  sleep 1.5
end

#############################################################
# 6) METAL STRIKES — omen signals
#############################################################
live_loop :metal do
  sync :ritual
  sample :elec_cymbal, amp: 0.25, rate: 0.4
  sleep [2.5, 3.75].choose
end

#############################################################
# 7) BELLS — spiritual calling
#############################################################
live_loop :bells do
  sync :ritual
  use_synth :pretty_bell

  with_fx :reverb, mix: 0.9 do
    play hira.choose,
      attack: 0.1,
      release: 3,
      amp: 0.35,
      pan: rrand(-0.4, 0.4)
  end

  sleep rrand(3, 5)
end

#############################################################
# 8) CHOIR PAD — rising fate
#############################################################
live_loop :choir do
  sync :ritual
  use_synth :dtri

  with_fx :reverb, mix: 0.85, room: 0.95 do
    play chord(:d3, :madd9),
      attack: 3,
      sustain: 3,
      release: 3,
      cutoff: 75,
      amp: 0.55
  end

  sleep 6
end
