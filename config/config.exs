# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :repos,
  ecto_repos: [Repos.Repo]

# Configures the endpoint
config :repos, ReposWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "G/nt/KyqqXtnYl/sFJJt/pVf+wHdc2c+2Ag2GbuOHxmPDqk6gSz6RtMpvGtZrkCY",
  render_errors: [view: ReposWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Repos.PubSub,
  live_view: [signing_salt: "tGBAU43E"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :repos, ReposWeb.Auth.Guardian,
  issuer: "repos",
  secret_key: "XCxbRGwT+AZh8gEsENa5EWF9mjJKeLzELpCNxh/6dT6X7gQb/OjeJBpfUeZA0IAZ"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
