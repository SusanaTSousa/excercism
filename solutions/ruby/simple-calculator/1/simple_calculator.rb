class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze
  EMPTY_STRING = "".freeze

  class UnsupportedOperation < StandardError; end

  def self.checkOperation(op)
    if not op or op == EMPTY_STRING or not ALLOWED_OPERATIONS.include? op
      raise UnsupportedOperation
    end 
  end
  
  def self.checkNumber(n)
    unless n.is_a?(Integer)
      raise ArgumentError
    end
  end

  def self.getResult(first_operand, second_operand, operation)
    case operation
      when '+'
        first_operand + second_operand
      when '/'
        first_operand / second_operand
      when '*'
        first_operand * second_operand
      end
  end
  
  def self.prettyPrint(first_operand, second_operand, operation, result)
    "#{first_operand} #{operation} #{second_operand} = #{result}"
  end

  def self.calculate(first_operand, second_operand, operation)
    
    checkOperation operation
    
    if operation == "/" and second_operand == 0
      return "Division by zero is not allowed."
    end

    checkNumber first_operand
    checkNumber second_operand
    prettyPrint first_operand, second_operand, operation, ( getResult first_operand, second_operand, operation )
    
  end
end
