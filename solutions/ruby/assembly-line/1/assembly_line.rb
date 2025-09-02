class AssemblyLine
  MINSPEED_PRODUCTION = 221.freeze
  MINUTES_IN_HOUR = 60.freeze
  
  def initialize(speed)
    @speed = speed
  end

  def working_cars_rate
    case @speed
      when 0..4 then 1
      when 5..8 then 0.9
      when 9 then 0.8
      when 10 then 0.77
    end
  end

  def production_rate_per_hour
    MINSPEED_PRODUCTION * @speed * working_cars_rate
  end

  def working_items_per_minute  
    (production_rate_per_hour / MINUTES_IN_HOUR).floor
  end
  
end
