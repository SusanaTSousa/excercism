module PythagoreanTriplet

  def self.triplets_with_sum(n)
    
    results = []
    for a in 1..(n-2)/3 do
      d1 = (n - a) ** 2 - a ** 2
      d2 = 2 * (n - a)
      if d1 % d2 != 0
        next
      end
      b = d1 / d2
      c = n - a - b
      if a < b && b < c 
        results << [a, b, c] 
      end
    end
    results
  end
  
end
