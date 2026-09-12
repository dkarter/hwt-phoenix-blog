defmodule HwtPhoenixBlog.Application do
  # See https://elixir.hexdocs.pm/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HwtPhoenixBlogWeb.Telemetry,
      HwtPhoenixBlog.Repo,
      {DNSCluster, query: Application.get_env(:hwt_phoenix_blog, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: HwtPhoenixBlog.PubSub},
      # Start a worker by calling: HwtPhoenixBlog.Worker.start_link(arg)
      # {HwtPhoenixBlog.Worker, arg},
      # Start to serve requests, typically the last entry
      HwtPhoenixBlogWeb.Endpoint
    ]

    # See https://elixir.hexdocs.pm/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HwtPhoenixBlog.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HwtPhoenixBlogWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
