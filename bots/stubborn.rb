class Stubborn
  include RSP::Bot
  
  def next
    # good ol' rock... nothin' beats that!
    moves.first
  end
end