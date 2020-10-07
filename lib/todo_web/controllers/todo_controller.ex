defmodule TodoWeb.TodoController do
  use TodoWeb, :controller

  alias Todo.Todo

  def index(conn, _params) do
    todos = Repo.all(Todo)
    render conn, "index.html", todos: todos
  end

  def new(conn, _params) do
    changeset = Todo.changeset(%Todo{},%{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, params) do
    %{"todo" => todo_param} = params
    changeset = Todo.changeset(%Todo{}, todo_param)

    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Task Created")
        |> redirect(to: todo_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end

  end

end
