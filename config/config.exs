# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :swbatnet,
  ecto_repos: [Swbatnet.Repo]

# Configures the endpoint
config :swbatnet, SwbatnetWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZctxTwAxQwe2Tj9r/8KPzxVu/DcpxrxQd14oZmJIgQIbdjZHnhjP3jrbctauRCPn",
  render_errors: [view: SwbatnetWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Swbatnet.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Configure OAuth
config :ueberauth, Ueberauth,
  providers: [
    github: { Ueberauth.Strategy.Github, [default_scope: "user,read:org"] }
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
