defmodule TpIgIntranet.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TpIgIntranetWeb.Telemetry,
      TpIgIntranet.Repo,
      {DNSCluster, query: Application.get_env(:tp_ig_intranet, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TpIgIntranet.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TpIgIntranet.Finch},
      # Start a worker by calling: TpIgIntranet.Worker.start_link(arg)
      # {TpIgIntranet.Worker, arg},
      # Start to serve requests, typically the last entry
      TpIgIntranetWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TpIgIntranet.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TpIgIntranetWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
