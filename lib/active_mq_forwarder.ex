defmodule ActiveMQForwarder do
  require Logger
  alias StompClient  # Use the module from the local stomp_client library

  @broker_host "localhost"
  @broker_port 61613
  @username "admin"
  @password "admin"
  @source_queue "/queue/source"
  @target_queue "/queue/target"

  # Entry point to start the forwarder service
  def start do
    Logger.info("Starting ActiveMQ Message Forwarder Service...")
    # Connection options
    options = [
      host: @broker_host,
      port: @broker_port,
      login: @username,
      passcode: @password,
      id: 123
    ]
    # Connect to the ActiveMQ broker
    case StompClient.connect(options) do
      pid when is_pid(pid) ->
        IO.puts("Connected successfully to ActiveMQ: #{inspect(pid)}")
        Logger.info("Connected to ActiveMQ STOMP broker")
        subscribe_to_source(pid)
        listen_for_messages(pid)
      unexpected ->
          IO.puts("Failed to connect to ActiveMQ. Response: #{inspect(unexpected)}")
    end

    # Keep the process alive
    Process.sleep(:infinity)
  end

  # Subscribe to the source queue
  defp subscribe_to_source(pid) do
    Logger.info("Subscribing to #{@source_queue}")
    # Subscribe to the source queue
    StompClient.subscribe(pid, @source_queue, id: "forwarder_subscription")
  end

  # Listen for messages and forward them
  defp listen_for_messages(pid) do
    Logger.info("Inside listen for msg to #{inspect(pid)}")
    receive do
      {:stomp_message, headers, body} ->
        Logger.info("Received message: #{body} with headers: #{inspect(headers)}")
        forward_message(pid, body)
        listen_for_messages(pid)
      {:stomp_error, reason} ->
        Logger.error("STOMP error occurred: #{inspect(reason)}")
    end
  end

  # Forward the received message to the target queue
  defp forward_message(pid, message_body) do
    Logger.info("Forwarding message to #{@target_queue}")
    StompClient.send(pid, @target_queue, message_body)
    Logger.info("Message forwarded successfully.")
  end
end
