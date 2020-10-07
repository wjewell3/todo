defmodule TodoWeb.TodoController do
  use TodoWeb, :controller

  #alias Todo.Todo
  alias Todo.Repo
  

  def index(conn, _params) do
    todos = Repo.all(Todo.Todo)
    render conn, "index.html", todos: todos
  end

  def new(conn, _params) do
    changeset = Todo.Todo.changeset(%Todo.Todo{},%{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, params) do
    IO.inspect(params)
    %{"todo" => todo_param} = params
    changeset = Todo.Todo.changeset(%Todo.Todo{}, todo_param)
    IO.inspect(changeset)

    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Task Created")
        |> redirect(to: Routes.todo_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end

  end

end
