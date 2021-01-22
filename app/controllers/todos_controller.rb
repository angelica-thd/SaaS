class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]
  before_action :authorize_request

  # GET /todos
  def index
    # get current user's todos
    @todos = current_user.todos
    json_response(@todos)
  end

  # POST /todos
  def create
    @todo = current_user.todos.create!(todo_params)
    json_response(@todo, :created)
  end

  # PUT /todos/:id
  def update
    @todo.update(todo_params)
    head :no_content
  end
  # GET /todos/:id
   def show
     json_response(@todo)
   end
   # DELETE /todos/:id
   def destroy
     @todo.destroy
     head :no_content
   end

  private

    def todo_params
      # whitelist params
      params.permit(:title)
    end

    def set_todo
      @todo = Todo.find(params[:id])
    end
end
