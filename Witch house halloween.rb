# ═══════════════════════════════════════════════════════════════
# 🎃 HALLOWEEN WITCH HOUSE 🧙‍♀️
# Dark, atmospheric electronic music with spooky vibes
# ═══════════════════════════════════════════════════════════════
# By Sonic Pi Expert | Halloween 2024
# Genre: Witch House / Dark Electronic
# ═══════════════════════════════════════════════════════════════

use_bpm 65  # Slow, haunting tempo typical of witch house

# ═══════════════════════════════════════════════════════════════
# GLOBAL EFFECTS & CONFIGURATION
# ═══════════════════════════════════════════════════════════════

define :dark_reverb do |mix=0.7, room=0.9|
  with_fx :reverb, mix: mix, room: room do
    yield
  end
end

define :witch_fx do
  with_fx :echo, phase: 0.75, decay: 8, mix: 0.4 do
    with_fx :reverb, room: 0.9, mix: 0.7 do
      with_fx :distortion, distort: 0.3 do
        yield
      end
    end
  end
end

# ═══════════════════════════════════════════════════════════════
# 🎵 MAIN BASS - Dark & Heavy
# ═══════════════════════════════════════════════════════════════

live_loop :witch_bass do
  use_synth :prophet
  use_synth_defaults release: 4, cutoff: 50, attack: 0.1
  
  with_fx :reverb, room: 0.8, mix: 0.6 do
    with_fx :lpf, cutoff: 70 do
      with_fx :bitcrusher, bits: 6, sample_rate: 8000, mix: 0.3 do
        
        notes = [:c2, :c2, :g1, :g1, :a1, :a1, :f1, :f1]
        
        4.times do |i|
          play notes[i % notes.length], amp: 3, pan: rrand(-0.2, 0.2)
          sleep 2
        end
      end
    end
  end
end

# ═══════════════════════════════════════════════════════════════
# 👻 SPOOKY ATMOSPHERE - Ghost Whispers
# ═══════════════════════════════════════════════════════════════

live_loop :atmosphere do
  sync :witch_bass
  
  use_synth :dark_ambience
  use_synth_defaults attack: 4, release: 8, cutoff: 60
  
  with_fx :reverb, room: 1, mix: 0.9 do
    with_fx :echo, phase: 1.5, decay: 12, mix: 0.5 do
      
      play chord(:c3, :minor7), amp: 0.4, pan_slide: 8
      control play(choose(chord(:c3, :minor7))), pan: rrand(-0.7, 0.7)
      
      sleep 8
    end
  end
end

# ═══════════════════════════════════════════════════════════════
# 🥁 TRAP-STYLE DRUMS - Heavy & Distorted
# ═══════════════════════════════════════════════════════════════

live_loop :witch_drums do
  sync :witch_bass
  
  with_fx :distortion, distort: 0.4, mix: 0.6 do
    
    # Kick drum
    sample :bd_fat, amp: 4, cutoff: 100
    sleep 1
    
    # Snare with reverb
    with_fx :reverb, room: 0.8, mix: 0.7 do
      sample :sn_dolf, amp: 2, rate: 0.8, pan: rrand(-0.3, 0.3)
    end
    sleep 1
    
    # Second kick
    sample :bd_fat, amp: 3.5
    sleep 0.5
    
    # Hi-hat
    sample :drum_cymbal_closed, amp: 0.3, rate: 1.2
    sleep 0.5
    
    # Spooky percussion
    if one_in(4)
      sample :perc_bell, rate: 0.5, amp: 0.5, pan: rrand(-0.5, 0.5)
    end
  end
end

# ═══════════════════════════════════════════════════════════════
# 🎹 WITCH MELODY - Eerie & Haunting
# ═══════════════════════════════════════════════════════════════

live_loop :witch_melody do
  sync :witch_bass
  
  use_synth :hollow
  use_synth_defaults attack: 0.5, release: 2, cutoff: 70
  
  witch_fx do
    
    melody = [:c4, :ds4, :f4, :g4, :gs4, :g4, :f4, :ds4]
    
    8.times do |i|
      if spread(5, 8).tick
        play melody.choose, amp: 0.6, pan: rrand(-0.6, 0.6)
        sleep 0.5
      else
        sleep 0.5
      end
    end
  end
end

# ═══════════════════════════════════════════════════════════════
# 🔮 WITCH VOCAL CHOPS - Pitched & Reversed
# ═══════════════════════════════════════════════════════════════

live_loop :vocal_chops do
  sync :witch_bass
  sleep 8  # Start after intro
  
  with_fx :reverb, room: 0.9, mix: 0.8 do
    with_fx :echo, phase: 0.5, decay: 6, mix: 0.5 do
      with_fx :pitch_shift, pitch: -12, mix: 0.7 do
        
        if one_in(2)
          sample :ambi_haunted_hum, rate: choose([0.5, 0.75, 1]), 
                 amp: 1.5, 
                 pan: rrand(-0.8, 0.8),
                 cutoff: rrand(60, 90)
        else
          sample :ambi_choir, rate: choose([-0.5, -0.75, 0.5]), 
                 amp: 1, 
                 beat_stretch: 4,
                 pan: rrand(-0.5, 0.5)
        end
        
        sleep choose([4, 8, 16])
      end
    end
  end
end

# ═══════════════════════════════════════════════════════════════
# 💀 GLITCH EFFECTS - Random Breaks & Stutters
# ═══════════════════════════════════════════════════════════════

live_loop :glitch_layer do
  sync :witch_bass
  
  with_fx :bitcrusher, bits: 4, sample_rate: 4000, mix: 0.8 do
    
    if one_in(8)
      sample :elec_blip, rate: choose([0.25, 0.5, 2, 4]), 
             amp: 1.5, 
             pan: rrand(-1, 1),
             cutoff: rrand(60, 100)
      
      sleep choose([0.125, 0.25, 0.5])
    else
      sleep 1
    end
  end
end

# ═══════════════════════════════════════════════════════════════
# 🦇 SUB BASS - Deep Rumble
# ═══════════════════════════════════════════════════════════════

live_loop :sub_bass do
  sync :witch_bass
  
  use_synth :sine
  use_synth_defaults attack: 0.1, release: 2, amp: 2
  
  with_fx :lpf, cutoff: 50 do
    
    sub_notes = [:c1, :c1, :g0, :g0, :a0, :a0, :f0, :f0]
    
    4.times do |i|
      play sub_notes[i % sub_notes.length], amp: 2.5
      sleep 2
    end
  end
end

# ═══════════════════════════════════════════════════════════════
# 🕷️ HALLOWEEN SAMPLES - Spooky Sounds
# ═══════════════════════════════════════════════════════════════

live_loop :halloween_fx do
  sync :witch_bass
  
  with_fx :reverb, room: 0.95, mix: 0.9 do
    
    if one_in(16)
      # Wind howling
      sample :ambi_glass_hum, rate: 0.25, amp: 0.8, pan: rrand(-0.8, 0.8)
      sleep 8
    end
    
    if one_in(12)
      # Creaking door
      sample :vinyl_backspin, rate: 0.1, amp: 0.6
      sleep 4
    end
    
    if one_in(10)
      # Thunder
      sample :drum_roll, rate: 0.3, amp: 1.2, cutoff: 70
      sleep 6
    end
    
    sleep 2
  end
end

# ═══════════════════════════════════════════════════════════════
# 🎃 PUMPKIN PERCUSSION - Quirky Hits
# ═══════════════════════════════════════════════════════════════

live_loop :pumpkin_perc do
  sync :witch_bass
  
  with_fx :echo, phase: 0.25, mix: 0.4 do
    
    if spread(3, 8).tick
      sample :perc_snap, amp: 0.8, rate: choose([0.8, 1, 1.2]), 
             pan: rrand(-0.5, 0.5)
    end
    
    sleep 0.5
  end
end

# ═══════════════════════════════════════════════════════════════
# 🌙 LEAD SYNTH - Dark Melody (Comes in later)
# ═══════════════════════════════════════════════════════════════

live_loop :dark_lead do
  sync :witch_bass
  sleep 32  # Wait for buildup
  
  use_synth :blade
  use_synth_defaults attack: 0.1, release: 1, cutoff: 80, amp: 0.7
  
  with_fx :reverb, room: 0.8, mix: 0.6 do
    with_fx :echo, phase: 0.75, decay: 4, mix: 0.4 do
      with_fx :slicer, phase: 0.25, mix: 0.5 do
        
        lead_notes = (scale :c3, :minor_pentatonic, num_octaves: 2)
        
        16.times do
          play lead_notes.choose, 
               amp: rrand(0.5, 0.9), 
               pan: rrand(-0.6, 0.6),
               cutoff: rrand(70, 100)
          
          sleep choose([0.25, 0.5, 0.75, 1])
        end
      end
    end
  end
end

# ═══════════════════════════════════════════════════════════════
# 🕸️ TEXTURAL NOISE - Background Grain
# ═══════════════════════════════════════════════════════════════

live_loop :texture do
  sync :witch_bass
  
  with_fx :hpf, cutoff: 90 do
    with_fx :lpf, cutoff: 110 do
      sample :vinyl_hiss, rate: 0.5, amp: 0.2
      sleep 16
    end
  end
end

# ═══════════════════════════════════════════════════════════════
# 🎭 TRANSITION EFFECTS - Build Tension
# ═══════════════════════════════════════════════════════════════

live_loop :transitions do
  sync :witch_bass
  sleep 28  # Build before drop
  
  with_fx :reverb, room: 0.95, mix: 0.9 do
    
    # Riser
    use_synth :prophet
    64.times do
      play :c2, amp: 0.1, cutoff: line(40, 130, steps: 64).tick
      sleep 0.125
    end
    
    # Snare roll
    16.times do
      sample :sn_dolf, amp: line(0.5, 2, steps: 16).look, rate: 0.9
      sleep 0.125
    end
  end
end

# ═══════════════════════════════════════════════════════════════
# 🔥 PERFORMANCE TIPS:
# ═══════════════════════════════════════════════════════════════
# 1. Press 'Run' to start the full production
# 2. Stop individual loops to create breakdowns
# 3. Adjust use_bpm for tempo changes (try 55-75 for witch house)
# 4. Modify cutoff values for filter sweeps
# 5. Change amp values for dynamics
# 6. Experiment with different sample rates in bitcrusher
# 7. Try commenting out loops for minimal sections
# 
# LIVE CODING IDEAS:
# - Start with just :witch_bass and :atmosphere
# - Gradually add drums and percussion
# - Build to full arrangement with all loops
# - Drop out elements for tension and release
# 
# Enjoy your Halloween Witch House! 🎃👻🧙‍♀️
# ═══════════════════════════════════════════════════════════════
