defmodule TelemetryPublisher.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {TelemetryPublisher.Services.EntityManager, []},
      {DynamicSupervisor, name: SubscriptionsSupervisor, strategy: :one_for_one},
      {Registry, keys: :duplicate, name: ReadingsPubSub, partitions: System.schedulers_online()},
      {TelemetryPublisher.SubscriptionsManager, []},
      {TelemetryPublisher.TelemetryConsumer, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TelemetryPublisher.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
