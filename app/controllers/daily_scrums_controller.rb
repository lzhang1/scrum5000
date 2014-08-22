class DailyScrumsController < ApplicationController
  def index
  end

  def new
    #This is present to prevent 'nil' errors when the form is loaded on the 'new' action
    @daily_scrum = DailyScrum.new
  end

  def create
    @daily_scrum = DailyScrum.new(daily_scrum_params)

    #If the form is successfully saved, display the saved info. Else, render the error.
    if @daily_scrum.save
      redirect_to @daily_scrum
    else
      render 'new'
    end
    #render plain: params[:daily_scrum].inspect
  end

  def show
    @daily_scrum = DailyScrum.find(params[:id])
  end

  def user_scrums
  end

  def search_user_scrums
    sprint_selection = params[:daily_scrum][:sprint_id]
    #Find all scrums in the sprint by user
    @scrum_by_user = DailyScrum.where(:scrum_user => current_user.email, :sprint_id => sprint_selection)
    #For use in the display
    @user_selected_sprint = Sprint.find(sprint_selection)
  end

  def all_scrums
  end

  def search_all_scrums
    sprint_selection = params[:daily_scrum][:sprint_id]
    #Find all scrums in the sprint
    @all_scrums = DailyScrum.where(:sprint_id => sprint_selection)
    #For use in the display
    @selected_sprint = Sprint.find(sprint_selection)
  end

  def update
  end

  def destroy
  end

  def edit
  end

  #Strong Parameters, new in Rails 4. This whitelists the
  #Acceptable parameters to be passed to the model.
  private
  def daily_scrum_params
    params.require(:daily_scrum).permit(:scrum_date, :sprint_id, :scrum_yesterday, :scrum_today, :scrum_blockers, :scrum_user)
  end

end
