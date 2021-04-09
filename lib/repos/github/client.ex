defmodule Repos.Github.Client do
  use Tesla

  alias Repos.{Error, Repository}
  alias Repos.Github.Behaviour
  alias Tesla.Env

  @base_url "https://api.github.com"

  @behaviour Behaviour

  plug Tesla.Middleware.Headers, [{"User-Agent", "Tesla"}]
  plug Tesla.Middleware.JSON

  def get_repos_by_username(url \\ @base_url, username) do
    "#{url}/users/#{username}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    repos = Enum.map(body, &Repository.build/1)
    {:ok, repos}
  end

  defp handle_get({:ok, %Env{status: 404}}) do
    {:error, Error.build_user_not_found_error()}
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:internal_server_error, reason)}
  end
end
