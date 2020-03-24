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
    get "/books/:id", BookController, :show
    patch "/books/:id/borrow", BookController, :borrow
    patch "/books/:id/return", BookController, :return
    post "/books/new", BookController, :create

    get "/users/:id", UserController, :show
    delete "/users/logout", UserController, :logout
  end

  # Plug function
  defp ensure_authenticated(conn, _opts) do
    current_user = get_session(conn, :current_user)

    if current_user do
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
