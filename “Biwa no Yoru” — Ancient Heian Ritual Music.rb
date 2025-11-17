#############################################################
#   “Biwa no Yoru” — Ancient Heian Ritual Music
#   Biwa, Sho, Gakuso, Ritual Drums
#############################################################

use_bpm 48   # ещё медленнее, почти ритуально

#############################################################
#   HEIAN COURT SCALE (Similar to ryo and ritsu modes)
#############################################################
heian_mode = [
  :d3, :f3, :g3, :a3, :c4,
  :d4, :f4, :g4, :a4, :c5
]

#############################################################
# 1) BIWA (LUTE) — plucked, ancient, slightly harsh
#############################################################
live_loop :biwa do
  use_synth :pluck

  with_fx :distortion, distort: 0.3 do
    with_fx :reverb, mix: 0.85, room: 0.95 do

      # резкие удары со спадающим тоном — имитация удара по струне бивы
      2.times do
        note = heian_mode.choose - 12
        play note,
          attack: 0,
          release: rrand(1.8, 3),
          amp: 0.45,
          pan: rrand(-0.3, 0.3)
        sleep rrand(2, 4)
      end

    end
  end

  sleep rrand(3, 6)
end

#############################################################
# 2) GAKUSO (Ancient koto) — soft long plucks
#############################################################
live_loop :gakuso do
  sync :biwa
  use_synth :pluck

  with_fx :reverb, mix: 0.9, room: 1 do
    play heian_mode.choose,
      attack: 0,
      release: rrand(2.5, 4),
      amp: 0.25,
      pan: rrand(-0.4, 0.4)
  end

  sleep rrand(3, 7)
end

#############################################################
# 3) SHO (MOUTH-ORGAN) — sustained celestial chords
#############################################################
live_loop :sho do
  sync :biwa
  use_synth :hollow

  # открытые гармонии, похожие на аккорды сё
  chord_sho = chord(:d4, :sus2)

  with_fx :reverb, mix: 0.95, room: 1 do
    play chord_sho,
      attack: 4,
      sustain: 6,
      release: 4,
      amp: 0.35
  end

  sleep 12
end

#############################################################
# 4) RYUTEKI / SHAKUHACHI — breathy ancient flute
#############################################################
live_loop :ancient_flute do
  sync :biwa
  use_synth :pretty_bell

  fl_notes = [:d4, :f4, :g4, :a4, :d5, :c5]

  with_fx :reverb, mix: 0.95, room: 1 do
    with_fx :echo, phase: 0.75, decay: 6, mix: 0.2 do
      note = fl_notes.choose
      play note,
        attack: 0.3,
        release: 3.5,
        vibrato_depth: 0.08,
        vibrato_rate: 3.5,
        amp: 0.35,
        pan: rrand(-0.15, 0.15)
    end
  end

  sleep rrand(4, 8)
end

#############################################################
# 5) RITUAL DRUM — deep slow heartbeat
#############################################################
live_loop :ritual_drum do
  sync :biwa

  if one_in(3)
    sample :bd_haus, amp: 0.2, rate: 0.4
  end

  sleep rrand(4, 9)
end

#############################################################
# 6) TEMPLE WIND — slow moving air (ancient ambience)
#############################################################
live_loop :temple_wind do
  use_synth :hollow

  with_fx :reverb, mix: 0.95, room: 1 do
    play :d2,
      attack: 5,
      sustain: 8,
      release: 6,
      amp: 0.1
  end

  sleep 14
end
