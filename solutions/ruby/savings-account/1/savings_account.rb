module SavingsAccount
  def self.interest_rate(balance)
     case balance
       when 0 ... 1000 then 0.5
       when 1000 ... 5000 then 1.621
       when 5000 .. Float::INFINITY then 2.475
       else 3.213
     end
  end

  def self.annual_balance_update(balance)
    balance * (1 + interest_rate(balance)/100)
  end

  def self.years_before_desired_balance(current_balance, desired_balance)
    counter = 0
    yearly_balance = current_balance
    until yearly_balance >= desired_balance
      yearly_balance = annual_balance_update yearly_balance
      counter += 1
    end
    counter
  end
end
