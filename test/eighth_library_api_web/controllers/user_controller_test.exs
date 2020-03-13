defmodule EighthLibraryApiWeb.UserControllerTest do
  use EighthLibraryApiWeb.ConnCase

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
end
