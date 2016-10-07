defmodule Magnetissimo.Router do
  use Magnetissimo.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :exq do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
    plug ExqUi.RouterPlug, namespace: "exq"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/exq", ExqUi do
    pipe_through :exq
    forward "/", RouterPlug.Router, :index
  end

  scope "/", Magnetissimo do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :landing
    get "/browse", TorrentController, :index
    get "/summary", TorrentController, :summary
  end
  
  # API pipe
  scope path: "/api" do
    pipe_through :api

    forward "/", PhoenixAPI.API
  end
end
