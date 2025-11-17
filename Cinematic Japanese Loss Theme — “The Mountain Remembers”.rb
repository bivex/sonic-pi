#############################################################
# CINEMATIC JAPANESE LOSS THEME
# "The Mountain Remembers"
# — tragic beauty, wide strings, minor hirajoshi color —
#############################################################

use_bpm 66  # slow, cinematic pace

#############################################################
# GLOBAL MIXER
#############################################################

set :vol_flute,   1.0
set :vol_koto,    0.6
set :vol_strings, 1.2
set :vol_bass,    0.8
set :vol_pad,     1.0
set :vol_ambi,    0.5
set :vol_drums,   0.25

#############################################################
# JAPANESE MINOR SCALE PALETTE
#############################################################

hira = scale(:d3, :hirajoshi, num_octaves: 2)

#############################################################
# AMBIENT WIND — CINEMATIC SPACE
#############################################################

live_loop :wind do
  v = get(:vol_ambi)

  with_fx :hpf, cutoff: 80 do
    with_fx :reverb, mix: 0.7, room: 1 do
      use_synth :noise
      play :d2,
        amp: 0.10 * v,
        attack: 4,
        sustain: 5,
        release: 4
    end
  end

  sleep 10
end

#############################################################
# HIGH STRINGS — SILENT TEARS
#############################################################

live_loop :high_strings do
  v = get(:vol_strings)
  use_synth :hollow

  with_fx :reverb, mix: 0.9, room: 1 do
    play chord(:d5, :m), amp: 0.5 * v,
      attack: 3, sustain: 6, release: 4, cutoff: 90
  end

  sleep 12
end

#############################################################
# MID STRINGS — THE PAIN IN THE CHEST
#############################################################

live_loop :mid_strings do
  v = get(:vol_strings)
  use_synth :prophet

  with_fx :reverb, mix: 0.85, room: 1 do
    play chord(:a3, :m7),
      amp: 0.6 * v,
      attack: 3.5,
      sustain: 6,
      release: 3,
      cutoff: 80
  end

  sleep 12
end

#############################################################
# LOW STRINGS / BASS — WEIGHT OF MEMORY
#############################################################

live_loop :low_strings do
  v = get(:vol_bass)
  use_synth :fm

  play :d2,
    amp: 0.55 * v,
    attack: 2.5,
    sustain: 4,
    release: 4,
    depth: 2,
    divisor: 1.5

  sleep 12
end

#############################################################
# MAIN FLUTE — LONELY, TRAGIC MELODY
#############################################################

live_loop :flute do
  v = get(:vol_flute)
  use_synth :hollow

  n = hira.choose + [0, 12].choose

  with_fx :reverb, mix: 0.92, room: 1 do
    with_fx :echo, mix: 0.28, phase: 0.75, decay: 5 do
      play n,
        amp: 0.8 * v,
        attack: 0.7,
        sustain: 0.4,
        release: 3.0,
        cutoff: 75,
        pan: rrand(-0.25, 0.25)
    end
  end

  sleep [4, 5, 6].choose
end

#############################################################
# KOTO — FRAGMENTS OF THE PAST
#############################################################

live_loop :koto_memories do
  v = get(:vol_koto)
  use_synth :pluck

  sleep 3  # staggered entrance

  2.times do
    play hira.choose,
      amp: 0.4 * v,
      attack: 0.01,
      release: 0.35,
      coef: 0.2,
      pan: rrand(-0.5, 0.5)
    sleep [1, 1.5, 2].choose
  end
end

#############################################################
# CINEMATIC DRUMS — HEARTBEAT OF LOSS
#############################################################

live_loop :drums do
  v = get(:vol_drums)

  sleep 4
  sample :bd_haus, amp: 0.2 * v, rate: 0.9
  sleep 6

  if one_in(6)
    sample :drum_tom_mid_soft, amp: 0.2 * v
  end
end
