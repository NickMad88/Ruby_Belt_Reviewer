class EventsController < ApplicationController
  before_action :event_check, only: [:edit,:update,:destroy]

  def index
      @events_in_state = Event.where(state: current_user.state)
      @events_out = Event.where.not(state: current_user.state)
  end

  def show
      @event = Event.find(params[:id])
  end

  def edit
      @event = Event.find(params[:id])
  end

  def update
      @event = Event.find(params[:id])
      @event.name = edit_helper[:name]
      @event.date = edit_helper[:date]
      @event.city = edit_helper[:city]
      @event.state = edit_helper[:state]
      if @event.save
          redirect_to events_path
      else
          flash[:errors] = @event.errors.full_messages
          redirect_to edit_event_path(params[:id])
      end
  end

  def create
      @event = Event.new(name:event_helper[:event_name],city:event_helper[:event_city],state:event_helper[:event_state],date:event_helper[:event_date],user:current_user)
      if @event.save
          redirect_to events_path
      else
          flash[:errors] = @event.errors.full_messages
          redirect_to events_path
      end
  end

  def destroy
      @event = Event.find(params[:id])
      if current_user.id == @event.user.id
          @event.delete
          redirect_to events_path
      else
          flash[:errors] = ["Only the creator can delete an event"]
          redirect_to events_path
      end
  end

  private
  def event_helper
      params.require(:event).permit(:event_name,:event_date,:event_city,:event_state) if params[:event].present?
  end
  def edit_helper
      params.require(:up_event).permit(:name,:date,:city,:state) if params[:up_event].present?
  end
  def event_check
      unless Event.find(params[:id]).user.id == current_user.id
          redirect_to events_path
      end
  end
end
