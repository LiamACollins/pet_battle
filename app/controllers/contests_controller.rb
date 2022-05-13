class ContestsController < ApplicationController
  before_action :set_contest, only: [:show]

  def index
    @contests = Contest.all.to_json
    @contestant_1 = params["contestant_1"]
    @contestant_2 = params["contestant_2"]
  end

  # /contests/1
  def show
    render :json => @contest
  end

  def create
    @contest = Contest.create(first_contestant_id: contest_params[:first_contestant_id], second_contestant_id: contest_params[:second_contestant_id], contest_type: contest_params[:type], status: "started")
    if @contest.contest_type == "race"
      # Used threading here to run enable the return of the JSON for the get status request of the contest whilst running the race in parallel
      Thread.new do
        race_service = Contest::RaceService.new(contest: @contest)
        race_service.race
      end
      render :json => @contest
    elsif @contest.contest_type == "peppers"
      Thread.new do
        peppers_service = Contest::PeppersService.new(contest: @contest)
        peppers_service.peppers
      end
      render :json => @contest
    else
      puts "Sorry this contest type doesn't exist yet! Try 'race' or 'pepper.'"
    end
  end

  private

  def set_contest
    @contest = Contest.find(params[:id])
  end

  def contest_params
    params.require(:contest).permit(:first_contestant_id, :second_contestant_id, :type)
  end
  end

