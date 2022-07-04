defmodule Quizium.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Quizium.Repo,
      # Start the Telemetry supervisor
      QuiziumWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Quizium.PubSub},
      # Start the Endpoint (http/https)
      QuiziumWeb.Endpoint
      # Start a worker by calling: Quizium.Worker.start_link(arg)
      # {Quizium.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Quizium.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    QuiziumWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
