class Game < ApplicationRecord
  has_many :game_players
  has_many :players, :through => :game_players
  has_many :hand_players, :through => :game_players
  has_many :hands
  belongs_to :first_dealer, :class_name => "GamePlayer", optional: true

  after_create_commit :create_hands

  def max_hand_size
    # 51, because at least one card must be left
    # in the deck to denote the trump suit.
    return 51 / self.size
  end

  def total_hands
    return (self.max_hand_size * 2) - 2
  end

  def max_player_hand_count
    return self.size * self.total_hands
  end

  # Returns the `Hand` that is currently being scored.
  def current_hand
    last_hand = self.hand_players.joins(:hand).reorder('hands.position ASC').where.not(bid: nil).last
    # if no scores are recorded, the current hand
    # is the first hand
    if !last_hand
      current_hand = self.hands.first
    # if we haven't scored all the players for
    # the last hand, it is still the current hand.
    elsif last_hand.hand.hand_players.where.not(bid: nil).count != self.size
      current_hand = last_hand.hand
    # otherwise, get the next hand.
    else
      current_hand = self.hands.where(position: last_hand.hand.position + 1).first
    end
    return current_hand
  end

  # Returns the `GamePlayer`s that haven't been scored
  # in the current hand.
  def still_to_play
    return self.game_players.where.not(
      id: self.current_hand.hand_players.where.not(bid: nil).select(:game_player_id)
    )
  end

  # Returns the position of the `GamePlayer`
  # we are currently scoring. `0` is the first person,
  # on the score sheet, `1` is to that person's left, etc.
  def current_game_player_position
    p = self.current_hand.dealer.position - (self.still_to_play.count - 1)
    if p < 0
      p = self.size + p
    end
    if p >= self.size
      p = 0
    end
    return p
  end

  # Returns the position of the `HandPlayer`
  # we are currently scoring. `0` is the dealer
  # of the hand, `1` is to their left, etc.
  def current_hand_position
    p = (self.size + 1) - self.still_to_play.count
    if p >= self.size
      p = 0
    end
    return p
  end

  # Returns the `GamePlayer` that is currently being scored
  def current_player
    if self.hand_players.where(bid: nil).empty?
      return nil
    end
    gp = self.still_to_play.where(position: self.current_game_player_position).first
    return gp
  end

  # returns the `HandPlayer` that is currently being scored.
  def current_hand_player
    return self.hand_players.where(game_player: self.current_player, hand: self.current_hand).first
  end

  def status
    player_hand_count = self.hand_players.where.not(position: nil).count
    # no hands have been entered
    if player_hand_count == 0
      return "not started"
    # some hands have been entered
    elsif player_hand_count < self.max_player_hand_count
      return "in progress"
    # all hands have been entered
    else
      return "completed"
    end
  end

  def next_position
    c = self.players.count
    if c < self.size
      return self.players.count
    else
      return nil
    end
  end

  def create_hands
    for p in 0..self.total_hands
      h = Hand.create(game: self, position: p)
      puts(h.errors.full_messages)
    end
  end
end
