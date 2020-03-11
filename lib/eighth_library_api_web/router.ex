defmodule EighthLibraryApiWeb.Router do
  use EighthLibraryApiWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "https://eighth-library-web.herokuapp.com"
    plug CORSPlug, origin: "http://localhost:3000"
    plug :accepts, ["json"]
  end

  scope "/api", EighthLibraryApiWeb do
    pipe_through :api

    get "/hello", HelloController, :index
  end
end
