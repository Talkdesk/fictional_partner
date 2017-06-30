# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :fictional_partner, FictionalPartner.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "djFF7jygovpGiTv9223zV9czTDzAc3VEpSWDPCPM09aT9MIUqkUKe8jFgdEkIS9c",
  render_errors: [view: FictionalPartner.ErrorView, accepts: ~w(json)],
  pubsub: [name: FictionalPartner.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
