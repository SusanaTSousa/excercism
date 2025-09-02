module PythagoreanTriplet

  def self.triplets_with_sum(n)
    
    results = []
    for a in 1..(n-2)/3 do
      k = n - a
      c = (a**2 + k**2) / (2 * k)
      b = n - a - c
      if a < b && b < c && a ** 2 + b ** 2 == c ** 2
        debug "a #{a}; b #{b}; c #{c}."
        results.push ( [a, b, c] )
      end
    end
    results
  end
  
end
