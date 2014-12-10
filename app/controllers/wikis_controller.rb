class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:index]
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
    @wikis = Wiki.public_wikis.page(params[:page]).per(10)
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
      redirect_to @wiki, notice: 'Wiki saved successfully.'
    else
      flash[:error] = 'Error while saving wiki.'
      render :edit
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
