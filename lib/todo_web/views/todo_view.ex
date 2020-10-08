defmodule TodoWeb.TodoView do
  use TodoWeb, :view
  # add class "completed" to a todo if todo.status=1
  # def complete(todo) do
  #   case todo.status do
  #     1 -> "completed"
  #     _ -> "" # empty string means empty class so no style applied
  #   end
  # end
end
