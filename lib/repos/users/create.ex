defmodule Repos.Users.Create do
  alias Repos.{Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
