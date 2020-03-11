defmodule EighthLibraryApiWeb.HelloController do
  use EighthLibraryApiWeb, :controller

  def index(conn, _params) do
    conn
    |> render("hello.json", message: "Hello World!")
  end
end
