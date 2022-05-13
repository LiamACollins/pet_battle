class Contest::RaceService
  def initialize(contest: nil)
    @contest = contest
  end

  def race_score(pet_1, pet_2)
    (pet_1["speed"]*Contest::SPEED_FACTOR + pet_1["strength"]*Contest::STRENGTH_FACTOR) - (pet_2["intelligence"]*Contest::INTELLIGENCE_FACTOR + pet_2["integrity"]*Contest::INTEGRITY_FACTOR)
  end

  def race
    pet_1 = @contest.contestant_1_json
    pet_2 = @contest.contestant_2_json

    pet_1_score = race_score(pet_1, pet_2)
    pet_2_score = race_score(pet_2, pet_1)

    sleep 3

    # Ensures pet_2 is the arbitrary winner in the case of a tie.
    contest_winner_id = pet_1_score >= pet_2_score ? pet_1["id"] : pet_2["id"]
    @contest.update(status: "complete", winner_id: contest_winner_id)
  end
end
