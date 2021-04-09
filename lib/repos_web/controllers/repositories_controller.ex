defmodule ReposWeb.RepositoriesController do
  use ReposWeb, :controller

  alias ReposWeb.FallbackController

  action_fallback FallbackController

  def index(conn, params) do
    with {:ok, repositories} <- Repos.get_repos_by_username(params) do
      conn
      |> put_status(:ok)
      |> render("repositories.json", repositories: repositories)
    end
  end
end
