defmodule Repos do
  alias Repos.Repositories.List, as: ListRepositories

  alias Repos.Users.Create, as: CreateUser
  alias Repos.Users.Get, as: GetUser

  defdelegate get_repos_by_username(params), to: ListRepositories, as: :call

  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate get_user_by_id(id), to: GetUser, as: :by_id
end
