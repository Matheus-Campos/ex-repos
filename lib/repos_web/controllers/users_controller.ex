defmodule ReposWeb.UsersController do
  use ReposWeb, :controller

  alias Ecto.Changeset
  alias Repos.User
  alias ReposWeb.{Auth.Guardian, FallbackController, Params.Login}

  action_fallback FallbackController

  def login(conn, params) do
    with %Changeset{valid?: true} <- Login.changeset(params),
         {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> json(%{token: token})
    else
      %Changeset{valid?: false} = changeset -> {:error, changeset}
    end
  end

  def create(conn, params) do
    with {:ok, %User{id: id} = user} <- Repos.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("created.json", user_id: id, token: token)
    end
  end
end
