defmodule EighthLibraryApiWeb.HelloControllerTest do
  use EighthLibraryApiWeb.ConnCase

  test "index/2 responds with 'Hello World!' message", %{conn: conn} do
    response =
      conn
      |> get(Routes.hello_path(conn, :index))
      |> json_response(200)

    expected = %{
      "message" => "Hello World!"
    }

    assert response == expected
  end
end
