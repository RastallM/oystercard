# can hold credit to allow users to pay for public transport use

class Oystercard
 
  attr_reader :balance
  MAX_VALUE = 90
  
  def initialize
    @balance = 0
  end

  def top_up(amount) 
    raise "Cannot top-up by #{amount}: Balance cannot be over £90" if max_credit?(amount)
    @balance += amount
  end

  private
  
  def max_credit?(amount)
    @balance + amount > 90
  end
end
