#########################################################
# LYRICAL SHAKUHACHI — Hirajoshi Flute Module
#########################################################

use_bpm 130

###########################################
# HIRAJOSHI — японская минорная пентатоника
###########################################

hirajoshi = scale(:d4, :hirajoshi, num_octaves: 2)

###########################################
# ЛИРИЧЕСКАЯ ФЛЕЙТА (SHAKUHACHI STYLE)
###########################################

live_loop :lyric_flute do
  use_synth :hollow

  note = hirajoshi.choose + [0, 12].choose

  with_fx :reverb, mix: 0.85, room: 0.98 do
    with_fx :echo, phase: 0.75, decay: 3, mix: 0.25 do
      play note,
           amp: 0.9,
           attack: rrand(0.4, 1.2),   # мягкое "дыхание"
           sustain: rrand(0.3, 0.7), # лирическое держание
           release: rrand(1.0, 2.5),
           pan: rrand(-0.2, 0.2),
           cutoff: rrand(70, 100)
    end
  end

  sleep [2, 3, 4].choose
end
