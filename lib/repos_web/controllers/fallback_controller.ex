defmodule ReposWeb.FallbackController do
  use ReposWeb, :controller

  alias Ecto.Changeset
  alias Repos.Error
  alias ReposWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end

  def call(conn, {:error, %Changeset{valid?: false} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("error.json", changeset: changeset)
  end
end
