defmodule HwtPhoenixBlogWeb.Router do
  use HwtPhoenixBlogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {HwtPhoenixBlogWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HwtPhoenixBlogWeb do
    pipe_through :browser

    get "/", PostController, :index
    resources "/posts", PostController
  end

  # Other scopes may use custom stacks.
  # scope "/api", HwtPhoenixBlogWeb do
  #   pipe_through :api
  # end
end
