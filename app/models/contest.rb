class Contest < ApplicationRecord
  # Allows the race to be in an 'in progress' state without a winner_id
  validates :winner_id, presence: false

  SPEED_FACTOR = 2.25
  STRENGTH_FACTOR = 0.75
  INTELLIGENCE_FACTOR = 0.25
  INTEGRITY_FACTOR = 0.25

  def contestant_1_json
    fetch_pet(first_contestant_id)
  end

  def contestant_2_json
    fetch_pet(second_contestant_id)
  end

  def fetch_pet(contestant_id)
    response = Faraday.get "https://wunder-pet-api-staging.herokuapp.com/pets/#{contestant_id}" do |request|
      request.headers['X-Pets-Token'] = 'UXhygiNEP1vYvRuPA4EluyJxLnscJ6uerTsUlnObFUqKxoyCnN'
      request.headers['Accept'] = 'application/json'
    end
    JSON.parse(response.body)
  end
end
