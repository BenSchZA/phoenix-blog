defmodule AppWeb.Router do
  use AppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AppWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/posts", PostController, :index
    get "/posts/:slug", PostController, :show
    get "/projects", ProjectController, :index
    get "/projects/:slug", ProjectController, :show
    get "/about", AboutController, :index
    resources "/contact", EmailController, only: [:index, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", AppWeb do
  #   pipe_through :api
  # end
end
