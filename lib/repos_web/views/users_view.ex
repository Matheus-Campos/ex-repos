defmodule ReposWeb.UsersView do
  use ReposWeb, :view

  def render("created.json", %{user_id: id, token: token}) do
    %{id: id, token: token, message: "User created!"}
  end
end
