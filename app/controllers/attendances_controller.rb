class AttendancesController < ApplicationController
  before_filter :authenticate_user!, :find_talk

  def create
    @talk.participants.create(user_id: current_user.id)
    redirect_to request.referrer
  end

  def destroy
    participant = @talk.participants.where(user_id: current_user.id).last
    participant.try(:destroy)
    redirect_to request.referrer
  end

  private

  def find_talk
    @talk = Talk.find(params[:talk_id])
  end

end
