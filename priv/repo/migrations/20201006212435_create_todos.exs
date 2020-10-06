defmodule Todo.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :action, :string
      add :status, :integer

      timestamps()
    end

  end
end
