defmodule EighthLibraryApiWeb.UserController do
  use EighthLibraryApiWeb, :controller
  alias EighthLibraryApi.Accounts

  def index(conn, _params) do
    users = Accounts.list_users
    conn
    |> put_status(:ok)
    |> put_view(EighthLibraryApiWeb.UserView)
    |> render("users.json", users: users)
  end

  def login(conn, params) do
    case Accounts.find_user(params["email"]) do
      {:ok, user} ->
        conn
        |> authenticate_user(user)
      {:error, _} ->
        create_user(conn, params)
    end
  end

  defp create_user(conn, params) do
    case Accounts.create_user(params) do
      {:ok, user} ->
        conn
        |> authenticate_user(user)
      {:error, message} ->
        conn
        |> delete_session(:current_user_email)
        |> put_status(:unauthorized)
        |> put_view(EighthLibraryApiWeb.ErrorView)
        |> render("401.json", message: message)
    end
  end

  defp authenticate_user(conn, user) do
    conn
    |> put_session(:current_user_email, user.email)
    |> put_status(:ok)
    |> put_view(EighthLibraryApiWeb.UserView)
    |> render("login.json", user: user)
  end
end
