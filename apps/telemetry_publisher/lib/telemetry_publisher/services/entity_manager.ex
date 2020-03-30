defmodule TelemetryPublisher.Services.EntityManager do
  use GenServer
  alias TelemetryPublisher.RPCClient

  @queue_name "entity_manager"

  # Client

  def start_link(default) when is_list(default) do
    GenServer.start_link(__MODULE__, default, name: __MODULE__)
  end

  def get_subscriptions do
    Task.async(fn ->
      GenServer.call(__MODULE__, {:get_subscriptions})
    end)
  end

  # Server (callbacks)

  @impl true
  def init(_opts) do
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    service = RPCClient.create_service(EntityManager, queue_name: @queue_name)

    state = %{connection: connection, channel: channel, service: service}
    {:ok, state}
  end

  @impl true
  def handle_call({:get_subscriptions}, _from, %{channel: channel, service: service} = state) do
    result =
      RPCClient.call(channel, service, %{
        "id" => "b671c9e6-46e3-49e6-bd03-d154d12ee2a0",
        "pattern" => %{"cmd" => "SUBSCRIPTION::GET_MANY"}
      })

    {:reply, result, state}
  end

  @impl true
  def terminate(_reason, %{connection: connection}) do
    AMQP.Connection.close(connection)
  end
end
