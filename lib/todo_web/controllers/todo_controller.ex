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

  def edit(conn, params) do
    %{"id" => todo_id} = params
    todo = Repo.get(Todo.Todo, todo_id)
    changeset = Todo.Todo.changeset(todo)
    render conn, "edit.html", changeset: changeset, todo: todo
  end

  def update(conn, %{"id" => todo_id, "todo" => todo_param}) do
    old_todo = Repo.get(Todo.Todo, todo_id)
    changeset = Todo.Todo.changeset(old_todo, todo_param)
    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Todo Updated")
        |> redirect(to: Routes.todo_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, todo: old_todo
    end
  end

  def delete(conn, %{"id" => todo_id}) do
    Repo.get!(Todo.Todo, todo_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Todo Deleted")
    |> redirect(to: Routes.todo_path(conn, :index))
  end

end
