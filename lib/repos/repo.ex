defmodule Repos.Repo do
  use Ecto.Repo,
    otp_app: :repos,
    adapter: Ecto.Adapters.Postgres
end
