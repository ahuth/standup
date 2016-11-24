class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams = current_account.teams.order(:name)
  end

  def show
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.account = current_account
    if @team.save
      redirect_to teams_path, notice: "Team was succesfully created"
    else
      render action: "new"
    end
  end

  def edit
  end

  def update
    if @team.update(team_params)
      redirect_to @team, notice: "Team was succesfully updated"
    else
      render action: "edit"
    end
  end

  def destroy
    @team.destroy!
    redirect_to teams_path
  end

  private

  def load_team
    @team = current_account.teams.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :time_zone)
  end
end
