defmodule ReposWeb.UsersController do
  use ReposWeb, :controller

  alias Repos.User
  alias ReposWeb.{Auth.Guardian, FallbackController}

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{id: id} = user} <- Repos.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("created.json", user_id: id, token: token)
    end
  end
end
