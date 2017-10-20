class AttendeesController < ApplicationController
  
  def create
    @event = Event.find(params[:id])
    @event.user_attendees << current_user
    @event.save
    redirect_to events_path
  end

  def destroy
    @event = Event.find(params[:id])
    @event.user_attendees.delete(User.find(current_user.id))
    redirect_to events_path
  end
end
