defmodule Repos do
  alias Repos.Repositories.List

  defdelegate get_repos_by_username(params), to: List, as: :call
end
