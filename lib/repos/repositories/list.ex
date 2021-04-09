defmodule Repos.Repositories.List do
  alias Repos.Github.Client

  def call(%{"username" => username}) do
    Client.get_repos_by_username(username)
  end
end
