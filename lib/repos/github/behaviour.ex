defmodule Repos.Github.Behaviour do
  alias Repos.{Error, Repository}

  @callback get_repos_by_username(String.t()) :: {:ok, list(Repository.t())} | {:error, Error.t()}
end
