# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :app,
  ecto_repos: []

# Configures the endpoint
config :app, AppWeb.Endpoint,
  url: [host: System.get_env("HOST")],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: AppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: App.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# GitHub
config :app, :github,
  handle: System.get_env("GITHUB_HANDLE"),
  username: System.get_env("GITHUB_USERNAME"),
  access_token: System.get_env("GITHUB_PAT")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
