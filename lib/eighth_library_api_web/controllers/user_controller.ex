defmodule EighthLibraryApiWeb.UserController do
  use EighthLibraryApiWeb, :controller
  alias EighthLibraryApi.Accounts
  alias EighthLibraryApi.Repo
  alias EighthLibraryApiWeb.UserView
  alias EighthLibraryApiWeb.ErrorView

  def index(conn, _params) do
    users = Accounts.list_users
    conn
    |> put_status(:ok)
    |> put_view(UserView)
    |> render("users.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
           |> Repo.preload([:books, :borrowed_books])

    conn
    |> put_status(:ok)
    |> put_view(UserView)
    |> render("user.json", user: user)
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

  def current_user(conn, _params) do
    current_user = get_session(conn, :current_user)
    case current_user do
      nil ->
        conn
        |> delete_session(:current_user)
        |> put_status(:unauthorized)
        |> put_view(ErrorView)
        |> render("401.json", message: "Current user not found")
      _ ->
        conn
        |> put_view(UserView)
        |> render("current_user.json", user: current_user)
    end
  end

  defp create_user(conn, params) do
    case Accounts.create_user(params) do
      {:ok, user} ->
        conn
        |> authenticate_user(user)
      {:error, _} ->
        conn
        |> delete_session(:current_user)
        |> put_status(:unauthorized)
        |> put_view(ErrorView)
        |> render("401.json", message: "Error logging in")
    end
  end

  defp authenticate_user(conn, user) do
    conn
    |> put_session(:current_user, user)
    |> put_status(:ok)
    |> put_view(UserView)
    |> render("current_user.json", user: user)
  end
end
