# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :meat_api,
  ecto_repos: [MeatApi.Repo]

# Configures the endpoint
config :meat_api, MeatApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wU2sBlI4cjM3LyOpOmIoSRpl9GSEeO3CPX1yJP0Hb7Rp1TUz8aJK2bRcw/IPIGms",
  render_errors: [view: MeatApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: MeatApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :meat_api, MeatApiWeb.Web.Endpoint,
  # "host": "localhost:4000" in generated swagger
  url: [host: "localhost"]

config :meat_api, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      # phoenix routes will be converted to swagger paths
      router: MeatApiWeb.Router
      # endpoint: MeatApiWeb.Endpoint  # (optional) endpoint config used to set host, port and https schemes.
    ]
  }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
