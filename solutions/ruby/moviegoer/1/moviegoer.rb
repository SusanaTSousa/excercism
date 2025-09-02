# This is a custom exception that you can use in your code
class NotMovieClubMemberError < RuntimeError
end

class Moviegoer

  AGE_MARKS = { :SCARY_MOVIE_ALLOWED => 18, :TICKET_DISCOUNT => 60 }.freeze
  
  def initialize(age, member: false)
    @age = age
    @member = member
  end

  def ticket_price
    @age >= AGE_MARKS[:TICKET_DISCOUNT] ? 10 : 15
  end

  def watch_scary_movie?
    @age >= AGE_MARKS[:SCARY_MOVIE_ALLOWED] 
  end

  # Popcorn is 🍿
  def claim_free_popcorn!
    @member ? "🍿" : (raise NotMovieClubMemberError.new "Exception was raised! (NotMovieClubMemberError)")
  end
end
