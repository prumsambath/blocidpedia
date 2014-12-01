class WikisController < ApplicationController
  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    authorize @wiki
    @wiki.user_id = current_user.id

    if @wiki.save
      flash[:notice] = 'Wiki successfuly created.'
      redirect_to wikis_path
    else
      flash[:error] = 'Error while saving a new wiki.'
      render :new
    end
  end

  def index
    @wikis = Wiki.public_wikis
    authorize @wikis
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.update_attributes(wiki_params)
      redirect_to wikis_path, notice: 'Wiki saved successfully.'
    else
      flash[:error] = 'Error while saving wiki.'
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @wiki.destroy
    redirect_to wikis_path, notice: 'Wiki deleted successfully.'
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
