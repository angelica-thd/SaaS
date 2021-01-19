class ItemsController < ApplicationController
  before_action :set_todo
  before_action :set_todo_item, only: [:show, :update, :destroy]
  # GET /todos/:todo_id/items
 def index
   json_response(@todo.items)
 end

private
  def set_todo
      @todo = Todo.find(params[:todo_id])
  end

end
