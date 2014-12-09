class AjaxController < ApplicationController
  def collaborators
    if params[:term]
      like = "%".concat(params[:term].concat("%"))
      users = User.where("name like ?", like)
    else
      users = User.all
    end
    list = users.map { |u| Hash[id: u.id, label: u.name, name: u.name]}
    render json: list
  end
end
