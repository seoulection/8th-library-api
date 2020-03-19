defmodule EighthLibraryApiWeb.Router do
  use EighthLibraryApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :api_auth do
    plug :ensure_authenticated
  end

  scope "/api", EighthLibraryApiWeb do
    pipe_through :api

    post "/users/login", UserController, :login
    get "/users/current", UserController, :current_user
  end

  # Protected Routes
  scope "/api", EighthLibraryApiWeb do
    pipe_through [:api, :api_auth]

    get "/books", BookController, :index
    post "/books/new", BookController, :create
  end

  # Plug function
  defp ensure_authenticated(conn, _opts) do
    current_user_id = get_session(conn, :current_user_id)

    if current_user_id do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> put_view(EighthLibraryApiWeb.ErrorView)
      |> render("401.json", message: "Unauthenticated user")
      |> halt()
    end
  end
end
