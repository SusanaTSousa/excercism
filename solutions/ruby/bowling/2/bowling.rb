class Game
  FRAMES = 10.freeze
  NUM_PINS = 10.freeze

  class BowlingError  < StandardError
  end
  
  def initialize()
    @frame = 0
    @play = 0
    @scores = []
    @bonus = {}
  end

  def roll(pins)
    if @frame + 1 > FRAMES 
      raise BowlingError.new("Can not roll on an already finished game")
    end
    if pins < 0
      raise BowlingError.new("Rolls cannot score negative points")
    end
    if pins > NUM_PINS
      raise BowlingError.new("Rolls cannot score more than the number of pins")
    end

    init_frame_structure
    frame_total_before_play = @scores[@frame][:score].sum
    @scores[@frame][:score][@play] = pins
    
    @play += 1
    last_frame = @frame+1 == FRAMES
    frame_total = @scores[@frame][:score].sum
    
    if !last_frame && frame_total > NUM_PINS
      raise BowlingError.new("Rolls in a frame cannot score more than the number of pins (except for the last one)")
    end
    if last_frame && frame_total_before_play < 2 * NUM_PINS && frame_total > 2 * NUM_PINS
      raise BowlingError.new("Bonus rolls in the last frame after 1 strike cannot score more than the number of pins")
    end
    
    @scores[@frame][:total] = frame_total
    handle_active_bonuses pins
    apply_roll_bonus frame_total, last_frame
    next_frame? frame_total, last_frame
  end

  def score()
    if @frame + 1 <= FRAMES 
      raise BowlingError.new("An incomplete game cannot be scored")
    end    
    @scores.sum { |frame| frame[:total] }
  end

  def init_frame_structure
  if @scores[@frame] == nil
      @scores[@frame] = { total: 0, score: [0] }
    end
    if @scores[@frame][:score][@play] == nil
      @scores[@frame][:score][@play] = 0
    end
  end

  def next_frame? (frame_total, last_frame)
    if (frame_total >= NUM_PINS && (!last_frame || @play > 2)) || (frame_total < NUM_PINS && @play > 1) 
      @frame += 1
      @play = 0
    end
  end

  def handle_active_bonuses (pins)
    @bonus.each{|key, value|
      @scores[key][:total] += pins
      value == 1 ? @bonus.delete(key) : @bonus[key] -= 1
    }
  end

  def apply_roll_bonus (frame_total, last_frame)
    #bonus: points of 1 extra play for spare, 2 for strike
    if frame_total == NUM_PINS && !last_frame
      @bonus [@frame] = 3 - @play
    end
  end
  
end