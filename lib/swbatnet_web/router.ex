defmodule SwbatnetWeb.Router do
  use SwbatnetWeb, :router
  # alias SwbatnetWeb.AuthController

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug SwbatnetWeb.Plugs.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/auth", SwbatnetWeb do
    pipe_through [:browser]

    get "/github", AuthController, :request
    get "/github/callback", AuthController, :callback
    # delete "/logout", AuthController, :delete
  end

  scope "/admin", SwbatnetWeb do
    pipe_through [:browser, :auth]

    get "/reviews/new", ReviewController, :new
    post "/reviews", ReviewController, :create
  end

  scope "/reviews", SwbatnetWeb do
    pipe_through :browser
    get "/:id", ReviewController, :show
  end

  scope "/", SwbatnetWeb do
    pipe_through :browser # Use the default browser stack
    get "/unauthorized", PageController, :unauthorized
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", SwbatnetWeb do
  #   pipe_through :api
  # end
end
