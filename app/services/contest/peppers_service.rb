class Contest::PeppersService
  def initialize(contest: nil)
    @contest = contest
  end

  def starting_heat_tolerance(pet_1,pet_2)
    (pet_1["speed"]*Contest::SPEED_FACTOR*2 + pet_1["strength"]*Contest::STRENGTH_FACTOR/5) - (pet_2["intelligence"]*Contest::INTELLIGENCE_FACTOR*3 + pet_2["integrity"]*Contest::INTEGRITY_FACTOR)
  end

  def peppers
    pet_1 = @contest.contestant_1_json
    pet_2 = @contest.contestant_2_json

    pet_1_tolerance = starting_heat_tolerance(pet_1, pet_2)
    pet_2_tolerance = starting_heat_tolerance(pet_2, pet_1)

    sleep 3

    peppers_response = Faraday.get "https://gist.githubusercontent.com/ThatHurleyGuy/2e4e712c0d1b3a554efea69baff8611f/raw/fb1d6d489f5befd97d8da67d3488af10bf7b8313/peppers.json"
    peppers_json = JSON.parse(peppers_response.body)

    while true do
      chosen_pepper = peppers_json.sample(1)[0]
      pepper_damage = chosen_pepper["shu"]/1000000 + chosen_pepper["color"]["r"] + chosen_pepper["color"]["g"]
      pet_1_tolerance -= pepper_damage
      pet_2_tolerance -= pepper_damage
      break if pet_1_tolerance <= 0 || pet_2_tolerance <= 0
    end

    # Ensures pet_2 is the arbitrary winner in the case of a tie.
    contest_winner_id = pet_1_tolerance >= pet_2_tolerance ? pet_1["id"] : pet_2["id"]
    @contest.update(status: "complete", winner_id: contest_winner_id)
  end
end