defmodule EighthLibraryApiWeb.Router do
  use EighthLibraryApiWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "http://localhost:3000"
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :api_auth do
    plug :ensure_authenticated
  end

  scope "/api", EighthLibraryApiWeb do
    pipe_through :api

    post "/users/login", UserController, :login
  end

  # Protected Routes
  scope "/api", EighthLibraryApiWeb do
    pipe_through [:api, :api_auth]
  end

  # Plug function
  defp ensure_authenticated(conn, _opts) do
    current_user_email = get_session(conn, :current_user_email)

    if current_user_email do
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
