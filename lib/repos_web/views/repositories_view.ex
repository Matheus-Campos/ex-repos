defmodule ReposWeb.RepositoriesView do
  use ReposWeb, :view

  def render("repositories.json", %{repositories: repositories}) do
    %{repositories: repositories}
  end
end
