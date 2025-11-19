use_bpm 78

###############################################################
## ГЛОБАЛЬНЫЙ ЭФФЕКТ — дорогой ревер и side-расширение
###############################################################
with_fx :reverb, room: 0.96, mix: 0.55 do
  with_fx :ixi_techno, mix: 0.15, phase: 4, cutoff_min: 60 do
    
    ###############################################################
    ## LAYER 1 — WIND (низкочастотная атмосфера, центр)
    ###############################################################
    in_thread do
      loop do
        with_fx :lpf, cutoff: 65 do
          sample "C:/Users/Admin/Downloads/muscoos/Indian_One_Shots/SO_IR_wind_shenhai_riff_hemlock_Eb.wav",
            amp: 0.23,
            rate: 0.45,
            pan: 0,     # центр, чтобы не было грязи в стерео
            attack: 1, release: 5
        end
        sleep 10
      end
    end
    
    ###############################################################
    ## LAYER 2 — BIG BELLS (ударный ритм, mid, слегка wide)
    ###############################################################
    battle_bells = [
      "C:/Users/Admin/Downloads/muscoos/Indian_One_Shots/Bells/SO_IR_bell_chan_chan_hit_long_pomelo.wav",
      "C:/Users/Admin/Downloads/muscoos/Indian_One_Shots/Bells/SO_IR_bell_andesite_A.wav"
    ]
    
    in_thread do
      loop do
        with_fx :compressor, threshold: 0.4, slope_below: 0.7, slope_above: 0.25 do
          with_fx :hpf, cutoff: 85 do   # убираем лишний гул
            sample battle_bells.choose,
              amp: 0.42,
              rate: 0.7,
              pan: (ring -0.25, 0.25).tick,  # умеренно
              attack: 0.05,
              release: 2.5
          end
        end
        sleep 4
      end
    end
    
    ###############################################################
    ## LAYER 3 — ANCIENT DRUMS (низ, точный центр)
    ###############################################################
    tribal_hits = [
      "C:/Users/Admin/Downloads/muscoos/Indian_One_Shots/Bells/SO_IR_bell_bowl_hit_plum_E.wav",
      "C:/Users/Admin/Downloads/muscoos/Indian_One_Shots/Bells/SO_IR_bell_bowl_hit_plantain_A.wav"
    ]
    
    in_thread do
      loop do
        with_fx :lpf, cutoff: 55 do           # глубокий темный бас
          with_fx :distortion, mix: 0.15 do   # чуть-чуть для атаки
            sample tribal_hits.choose,
              amp: 0.55,
              rate: 0.38,
              pan: 0,          # центр для мощи
              attack: 0.05,
              release: 3
          end
        end
        sleep (ring 2, 3, 1.5, 4).tick
      end
    end
    
    ###############################################################
    ## LAYER 4 — SMALL BELLS (высокие частоты шире)
    ###############################################################
    small_bell = "C:/Users/Admin/Downloads/muscoos/Indian_One_Shots/Bells/SO_IR_bell_elathalam_impact_pumpkin_B.wav"
    
    in_thread do
      loop do
        with_fx :hpf, cutoff: 100 do       # убираем низ, оставляем «звон»
          with_fx :echo, phase: 0.35, mix: 0.25 do
            sample small_bell,
              amp: 0.22,
              rate: 1.15,
              pan: (ring -0.7, 0.7).choose, # широкая панорама
              release: 1.1
          end
        end
        sleep 0.7 + rand(1.5)
      end
    end
    
    ###############################################################
    ## LAYER 5 — SPIRIT FLUTE (широкий mist-layer в SIDE)
    ###############################################################
    in_thread do
      loop do
        with_fx :slicer, phase: 8, mix: 0.2 do
          with_fx :pitch_shift, pitch: -5, mix: 0.6 do
            sample "C:/Users/Admin/Downloads/muscoos/Indian_One_Shots/Flutes_Phrases/SO_IR_flute_fill_satin_E.wav",
              amp: 0.32,
              rate: 0.6,
              pan: (ring -0.5, 0.5).tick,
              attack: 1,
              release: 4
          end
        end
        sleep 8 + rand(3)
      end
    end
    
  end # FX block
end # FX block
