defmodule ActiveMQForwarder.MixProject do
  use Mix.Project

  def project do
    [
      app: :activemq_forwarder,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {MyApp.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:stomp_client, "~> 0.1.1"} # Ensure this version is compatible
    ]
  end
end
