=begin
Write your code for the 'Bowling' exercise in this file. Make the tests in
`bowling_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/bowling` directory.
=end


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
    
    if @scores[@frame] == nil
      @scores[@frame] = { total: 0, score: [0] }
    end
    if @scores[@frame][:score][@play] == nil
      @scores[@frame][:score][@play] = 0
    end
    total_frame_before_play = @scores[@frame][:score].sum
    @scores[@frame][:score][@play] = pins
    
    @play += 1
    last_frame = @frame+1 == FRAMES
    total_frame = @scores[@frame][:score].sum
    
    if !last_frame && total_frame > NUM_PINS
      raise BowlingError.new("Rolls in a frame cannot score more than the number of pins (except on the last one)")
    end
    if last_frame && total_frame_before_play < 2 * NUM_PINS && total_frame > 2 * NUM_PINS
      raise BowlingError.new("Bonus rolls in the last frame after a strike cannot score more than the number of pins")
    end
    
    @scores[@frame][:total] = total_frame

    #see if there is active bonuses
    @bonus.each{|key, value|
      @scores[key][:total] += pins
      value == 1 ? @bonus.delete(key) : @bonus[key] -= 1
    }

    #bonus: points of 1 extra play for spare, 2 for strike
    if total_frame == NUM_PINS && !last_frame
      @bonus [@frame] = 3 - @play
    end

    strike = pins == NUM_PINS
    spare = !strike && @scores[@frame][:total] >= NUM_PINS

    if (total_frame >= NUM_PINS && (!last_frame || @play > 2)) || (total_frame < NUM_PINS && @play > 1) 
      @frame += 1
      @play = 0
    end
  end

  def score()
    if @frame + 1 <= FRAMES 
      raise BowlingError.new("An incomplete game cannot be scored")
    end
    
    total = 0
    @scores.each{|frame|
      total += frame[:total]
    }
    total
  end
  
end