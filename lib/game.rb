module RSP
  class Game
    attr_reader :history, :first_player, :second_player, :first_player_wins, :second_player_wins, :ties
    
    def initialize(first_player_klass, second_player_klass, options = {})
      @rounds_to_run = options[:rounds_to_run] || 2000
      @verbose = options[:verbose] || false
      @first_player, @second_player = first_player_klass.new(self), second_player_klass.new(self)
      @first_player_wins, @second_player_wins, @ties = 0, 0, 0
    end
    
    def execute
      @history = []
      @rounds_to_run.times do |count|
        puts "------- ROUND #{count + 1} ------------" if @verbose
        round = RSP::Round.new(@first_player, @second_player)
        @history << round
        if round.winner == first_player
          @first_player_wins += 1
        elsif round.winner == second_player
          @second_player_wins += 1
        else
          @ties = ties + 1
        end
        
        puts round if @verbose
      end
      
      puts "------------------"
      puts self
    end
    
    def wins(player)
      first_player.is_a?(player.class) ? first_player_wins : second_player_wins
    end

    def losses(player)
      first_player.is_a?(player.class) ? second_player_wins : first_player_wins
    end
    
    def winner
      must_win_by = (0.02 * @rounds_to_run).to_i
      if (first_player_wins - must_win_by) > second_player_wins
        first_player
      elsif first_player_wins < (second_player_wins - must_win_by)
        second_player
      end
    end
    
    def loser
      winner == first_player ? second_player : first_player
    end
    
    def to_s
      result = ""
      if winner
        result << "Winner is #{winner}\n"
        result << "Loser is #{loser}\n"
      else
        result << "DRAW between #{first_player} and #{second_player}\n"
      end
      
      result << "#{first_player}: Won #{((first_player_wins / @rounds_to_run.to_f) * 100).to_i}%\n"
      result << "#{second_player}: Won #{((second_player_wins / @rounds_to_run.to_f) * 100).to_i}%"
    end
  end
end
