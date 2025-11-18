# ============================================================
#    ORC WAR HONOR — PRIMAL MARCH MUSIC (Sonic Pi)
#    by ChatGPT — tribal, heavy, marching war ambience
# ============================================================

use_bpm 96

aeolian = scale(:d2, :aeolian)

# ------------------------------------------------------------
# 1) EARTH DRONE — земля дрожит под армией орков
# ------------------------------------------------------------
live_loop :orc_drone do
  use_synth :dark_ambience
  
  with_fx :reverb, room: 0.85, mix: 0.6 do
    with_fx :lpf, cutoff: 75 do
      play :d1, attack: 2, sustain: 6, release: 3, amp: 1.3
    end
  end
  
  sleep 12
end

# ------------------------------------------------------------
# 2) WAR DRUMS — племенной марш
# ------------------------------------------------------------
live_loop :war_drums do
  use_synth :fm
  
  with_fx :distortion, mix: 0.25 do
    # Основной марш: BOM – bom – bom – BOM
    play :d2, amp: 2.2, release: 0.25
    sleep 1
    
    play :f2, amp: 1.6, release: 0.2
    sleep 0.5
    
    play :g2, amp: 1.6, release: 0.2
    sleep 0.5
    
    play :d2, amp: 2.5, release: 0.3
    sleep 1
  end
end

# ------------------------------------------------------------
# 3) METAL SHIELD CLANG — удары по щитам
# ------------------------------------------------------------
live_loop :shield_hits do
  sync :war_drums
  use_synth :pretty_bell
  
  if one_in(4)
    with_fx :reverb, room: 0.7, mix: 0.5 do
      with_fx :hpf, cutoff: 90 do
        play choose([:d4, :f4, :g4]), amp: 0.5, release: 0.25
      end
    end
  end
  
  sleep [1, 2].choose
end

# ------------------------------------------------------------
# 4) ORC CHANT — племенной мужской хор
# ------------------------------------------------------------
live_loop :orc_chant do
  sync :war_drums
  use_synth :blade
  
  if one_in(3)
    with_fx :reverb, room: 0.9, mix: 0.7 do
      note = [:d3, :c3, :bb2].choose
      play note, sustain: 0.6, release: 0.8, amp: 0.9
      sleep 0.5
      
      # Ответ хора (call & response)
      play note - 12, sustain: 0.5, release: 0.6, amp: 1.1
    end
  end
  
  sleep 4
end

# ------------------------------------------------------------
# 5) STOMPING STEPS — шаги орков
# ------------------------------------------------------------
live_loop :orc_steps do
  sync :war_drums
  use_synth :noise
  
  if one_in(2)
    with_fx :lpf, cutoff: 70 do
      play 0.1, amp: 0.3, release: 0.1
    end
  end
  
  sleep 0.75
end

# ------------------------------------------------------------
# 6) WAR HORN — рог войны (магическая труба орков)
# ------------------------------------------------------------
live_loop :war_horn do
  sync :orc_drone
  
  use_synth :hollow
  
  if one_in(6)
    with_fx :echo, mix: 0.2, phase: 0.75 do
      play :d3,
        attack: 1.5,
        sustain: 2,
        release: 2,
        amp: 1.2
    end
  end
  
  sleep 8
end
