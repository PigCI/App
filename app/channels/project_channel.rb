class ProjectChannel < ApplicationCable::Channel
  def subscribed
    project = current_user.projects.find(params[:id])
    stream_for project
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
