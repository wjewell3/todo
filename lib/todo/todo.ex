defmodule Todo.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :action, :string
    field :status, :integer

    timestamps()
  end

  @doc false
  # def changeset(todo, attrs) do
  #   todo
  #   |> cast(attrs, [:action, :status])
  #   |> validate_required([:action, :status])
  # end
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:action, :status])
    |> validate_required([:action, :status])
  end
end
