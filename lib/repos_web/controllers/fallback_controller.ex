defmodule ReposWeb.FallbackController do
  use ReposWeb, :controller

  alias Repos.Error
  alias ReposWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    IO.inspect(result)
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
