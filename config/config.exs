# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :chaski,
  ecto_repos: [Chaski.Repo]

config :chaski_web,
  ecto_repos: [Chaski.Repo],
  generators: [context_app: :chaski]

# Configures the endpoint
config :chaski_web, ChaskiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NAckPB4HmzuNaW1ViSq5+kR1TEwk6q9qlJuXnvayPd2WJnmIFX/eaeHcYiTgQ11L",
  render_errors: [view: ChaskiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ChaskiWeb.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "ONVse37I"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
