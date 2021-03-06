module RPS
  class Round
    attr_reader :first_player, :second_player, :first_player_move, :second_player_move, :winner

    def initialize(first_player, second_player, game)
      @first_player, @second_player, @game = first_player, second_player, game
      execute
    end

    def my_move(me)
      me == @first_player ? @first_player_move : @second_player_move
    end

    def other_player_move(my_player)
      my_player == @first_player ? @second_player_move : @first_player_move
    end

    def to_s
      result = ""
      [[@first_player, @first_player_move], [@second_player, @second_player_move]].each_with_index do |set, index|
        player, move = set
        result << "Player #{index + 1} (#{player}) - #{move} - "
        if player == @winner
          result << "WON!\n"
        elsif @winner == false
          result << "tied\n"
        else
          result << "lost\n"
        end
      end
      result
    end

   private

    def execute
      first_player_move_not_instance = first_player.throw(@game)
      @second_player_move = second_player.throw(@game)
      @first_player_move = first_player_move_not_instance

      if first_player_move > second_player_move
        @winner = first_player
      elsif first_player_move < second_player_move
        @winner = second_player
      else
        @winner = false
      end
      
      @fir
    end
  end
end
