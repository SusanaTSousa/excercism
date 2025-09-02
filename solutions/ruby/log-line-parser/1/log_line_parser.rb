class LogLineParser
  def initialize(line)
    @line = line
  end

  def trim!(str)
    str.strip! || str
  end

  def message
    trim! @line.partition(': ').last
  end

  def log_level
    level = trim! @line.partition(': ').first.downcase
    level[1, level.length - 2] 
  end

  def reformat
    "#{message} (#{log_level})"
  end
end
