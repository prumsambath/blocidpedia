class CollaborationsController < ApplicationController
  def new
    @wiki = Wiki.find(params[:wiki_id])
    @available_collaborators = User.available_collaborators(@wiki, current_user)
    @collaboration = @wiki.collaborators.build
  end

  def create
    wiki = Wiki.find(params[:wiki_id])
    wiki.collaborators << User.find_by(name: params[:user_id])

    if wiki.save
      redirect_to wiki_collaborations_path(wiki), notice: 'A new collaborator added successfully.'
    else
      flash[:error] = 'Error while adding a collaborator.'
      render :new
    end
  end

  def index
    @wiki = Wiki.find(params[:wiki_id])
  end

  def destroy
    collaboration = Collaboration.find(params[:id])
    wiki = Wiki.find(params[:wiki_id])
    collaborator = User.find(collaboration.user_id)
    if collaboration.destroy
      redirect_to wiki_collaborations_path(wiki), notice: "#{collaborator.name} is removed successfully."
    end
  end
end
