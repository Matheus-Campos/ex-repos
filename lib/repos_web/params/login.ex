defmodule ReposWeb.Params.Login do
  use Ecto.Schema

  import Ecto.Changeset

  @required_params [:id, :password]

  embedded_schema do
    field :password, :string
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
  end
end
