#############################################################
# QUIET HOUSE – CINEMATIC GAME THEME (8 INSTRUMENTS)
# Тихий дом, исследование, мягкая тревога, точные паузы и развитие
#############################################################

use_bpm 58  # медленный, "дышащий" темп

#############################################################
# ГЛОБАЛЬНЫЙ МИКСЕР ГРОМКОСТИ
#############################################################

set :vol_pad,      1.0   # основной атмосферный пад
set :vol_piano,    0.9   # игровая мелодия (пианино)
set :vol_box,      0.7   # музыкальная шкатулка / колокольчики
set :vol_bass,     0.6   # низкий дрон
set :vol_creaks,   0.4   # скрипы пола
set :vol_clock,    0.35  # часы / тиканье
set :vol_air,      0.45  # воздух/наружный ветер
set :vol_perc,     0.4   # лёгкая перкуссия/тапы

#############################################################
# МАСШТАБ И ФОРМА
#############################################################

house_scale = scale(:d3, :minor, num_octaves: 2)

# Счётчик формы – в "барах" (каждый бар = 4 удара)
set :form_step, 0

live_loop :form do
  # каждую итерацию – новый бар
  set :form_step, get(:form_step) + 1
  sleep 4
end

# Удобная функция – получить текущую фазу
define :phase do
  get(:form_step)
end

#############################################################
# 1) ОСНОВНОЙ ПАД – "ВОЗДУХ ДОМА"
#############################################################

live_loop :pad_main do
  sync :form
  v = get(:vol_pad)

  # Фазы: 1–4 интро, 5–12 развитие, 13+ чуть ярче
  ph = phase

  use_synth :hollow

  root =
    if ph < 5
      :d3
    elsif ph < 13
      [:d3, :g3].ring.tick
    else
      [:d3, :g3, :bb2].ring.tick
    end

  chord_type = (ph < 9 ? :m7 : :sus2)

  with_fx :reverb, mix: 0.8, room: 0.95 do
    play chord(root, chord_type),
      amp: 0.6 * v,
      attack: 3,
      sustain: 5,
      release: 4,
      cutoff: (ph < 9 ? 70 : 80)
  end

  sleep 8
end

#############################################################
# 2) ПИАНИНО – ОСНОВНАЯ ИГРОВАЯ МЕЛОДИЯ
#############################################################

live_loop :piano_theme do
  sync :form
  v = get(:vol_piano)
  ph = phase
  use_synth :piano

  # В интро (первые 4 бара) – тишина
  if ph < 5
    sleep 4
    next
  end

  with_fx :reverb, mix: 0.9, room: 0.9 do
    # простая мотивная фраза на 2 бара
    phrase = [
      :d4, :f4, :a4, :g4,
      :f4, :d4, :a3, nil
    ]

    phrase.each do |n|
      if n
        play n,
          amp: 0.7 * v,
          attack: 0.05,
          release: 1.2,
          pan: rrand(-0.2, 0.2)
      end
      sleep 0.75
    end
  end
end

#############################################################
# 3) МУЗЫКАЛЬНАЯ ШКАТУЛКА / КОЛОКОЛЬЧИКИ – ВТОРОЙ ПЛАН
#############################################################

live_loop :music_box do
  sync :form
  v = get(:vol_box)
  ph = phase
  use_synth :pretty_bell

  # Подключается позже – после 8 бара
  if ph < 9
    sleep 4
    next
  end

  notes = house_scale.select { |n| n >= :d4 }  # верхний регистр

  4.times do
    n = notes.choose
    with_fx :reverb, mix: 0.95, room: 1 do
      play n,
        amp: 0.4 * v,
        attack: 0.05,
        release: 1.8,
        pan: rrand(-0.3, 0.3)
    end
    sleep [1, 1.5].choose
  end
end

#############################################################
# 4) НИЗКИЙ ДРОН / БАС – "ФУНДАМЕНТ ДОМА"
#############################################################

live_loop :bass_floor do
  sync :form
  v = get(:vol_bass)
  ph = phase
  use_synth :dark_ambience

  root =
    if ph < 9
      :d2
    else
      [:d2, :c2].ring.tick
    end

  play root,
    amp: 0.45 * v,
    attack: 3,
    sustain: 4,
    release: 4

  sleep 10
end

#############################################################
# 5) СКРИПЫ ПОЛА – РЕДКИЕ, НО ТОЧНЫЕ
#############################################################

live_loop :floor_creaks do
  v = get(:vol_creaks)
  ph = phase

  # В середине трека появляются чуть чаще
  interval =
    if ph < 5
      rrand(7, 12)
    elsif ph < 13
      rrand(5, 9)
    else
      rrand(6, 10)
    end

  sleep interval

  # очень мягкий "квази-скрип"
  sample :elec_soft_kick,
    amp: 0.2 * v,
    rate: 0.5,
    pan: rrand(-0.4, 0.4)
end

#############################################################
# 6) ЧАСЫ / ТИКАНИЕ – РИТУАЛ В ТИШИНЕ
#############################################################

live_loop :clock_ticking do
  v = get(:vol_clock)
  ph = phase

  # В интро тиканье есть, но очень тихое и редкое
  base_amp = (ph < 9 ? 0.22 : 0.3) * v
  interval = 1.0

  sample :elec_tick,
    amp: base_amp,
    rate: 1.0,
    pan: rrand(-0.15, 0.15)
  sleep interval
end

#############################################################
# 7) ВОЗДУХ / НАРУЖНЫЙ ВЕТЕР – МЯГКИЙ ШУМ
#############################################################

live_loop :house_air do
  sync :form
  v = get(:vol_air)
  use_synth :noise

  with_fx :hpf, cutoff: 90 do
    with_fx :reverb, mix: 0.6, room: 0.9 do
      play :d3,
        amp: 0.18 * v,
        attack: 2,
        sustain: 3,
        release: 3
    end
  end

  sleep 8
end

#############################################################
# 8) ЛЁГКАЯ ПЕРКУССИЯ / ТАПЫ – ИГРОВОЕ ДВИЖЕНИЕ
#############################################################

live_loop :soft_perc do
  v = get(:vol_perc)
  ph = phase

  # В интро нет перкуссии
  if ph < 7
    sleep 4
    next
  end

  # Лёгкие "тапы" по столу/предметам
  4.times do
    sample :drum_cymbal_soft,
      amp: 0.18 * v,
      rate: 1.2,
      pan: rrand(-0.25, 0.25)
    sleep 0.75
  end

  sleep 2
end
