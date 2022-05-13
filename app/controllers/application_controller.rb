class ApplicationController < ActionController::Base
  # Skip token authentication to allow for post request from demo_script.rb
  skip_before_action :verify_authenticity_token, only: [:create]
end
