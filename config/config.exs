# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :eighth_library_api,
  ecto_repos: [EighthLibraryApi.Repo]

# Configures the endpoint
config :eighth_library_api, EighthLibraryApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VIaaerLqJTle7H+XJrRRmWjm/AUkPRKhcmCoHBCZQ9nitv0Ef+TbQ9ZXl7vt9dyv",
  render_errors: [view: EighthLibraryApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: EighthLibraryApi.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "xEcGXWTq"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
