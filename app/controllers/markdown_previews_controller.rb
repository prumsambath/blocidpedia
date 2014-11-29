class MarkdownPreviewsController < ApplicationController
  include ApplicationHelper

  def create
    render plain: markdown(params[:text])
  end
end
