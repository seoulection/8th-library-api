defmodule EighthLibraryApiWeb.UserControllerTest do
  use EighthLibraryApiWeb.ConnCase
  alias Plug.Test
  alias EighthLibraryApi.Accounts

  @valid_params %{
    first_name: "some first name",
    last_name: "some last name",
    email: "some email",
    image_url: "some image url"
  }

  @invalid_params %{
    first_name: nil,
    last_name: nil,
    email: nil,
    image_url: nil
  }

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@valid_params)
      |> Accounts.create_user()

    user
  end

  test "renders user when login credentials are good", %{conn: conn} do
    response =
      conn
      |> post(Routes.user_path(conn, :login, @valid_params))
      |> json_response(200)

    assert response["user"]["first_name"] == "some first name"
    assert response["user"]["last_name"] == "some last name"
    assert response["user"]["email"] == "some email"
    assert response["user"]["image_url"] == "some image url"
  end

  test "renders errors when login credentials are bad", %{conn: conn} do
    response =
      conn
      |> post(Routes.user_path(conn, :login, @invalid_params))
      |> json_response(401)

    assert response["errors"]["detail"] == "Error logging in"
  end

  test "renders error if no current user in session", %{conn: conn} do
    response =
      conn
      |> get(Routes.user_path(conn, :current_user))
      |> json_response(401)

    assert response["errors"]["detail"] == "Current user not found"
  end

  test "renders user if current user is in session", %{conn: conn} do
    user = user_fixture()
    response =
      conn
      |> Test.init_test_session(current_user: user)
      |> get(Routes.user_path(conn, :current_user))
      |> json_response(200)

    assert response["user"]["first_name"] == "some first name"
    assert response["user"]["last_name"] == "some last name"
  end

  test "shows a single user", %{conn: conn} do
    user = user_fixture()

    response =
      conn
      |> Test.init_test_session(current_user: user)
      |> get(Routes.user_path(conn, :show, user.id))
      |> json_response(200)

    assert response["user"]["first_name"] == "some first name"
    assert response["user"]["last_name"] == "some last name"
    assert response["user"]["owned_books"] == []
    assert response["user"]["borrowed_books"] == []
  end

  test "logs a user out", %{conn: conn} do
    user = user_fixture()

    response =
      conn
      |> Test.init_test_session(current_user: user)
      |> delete(Routes.user_path(conn, :logout))
      |> get_session(:current_user)

    assert response == nil
  end
end
