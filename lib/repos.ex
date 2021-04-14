defmodule Repos do
  alias Repos.Repositories.List, as: ListRepositories

  alias Repos.Users.Create, as: CreateUser

  defdelegate get_repos_by_username(params), to: ListRepositories, as: :call

  defdelegate create_user(params), to: CreateUser, as: :call
end
