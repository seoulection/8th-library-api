defmodule EighthLibraryApiWeb.HelloViewTest do
  use EighthLibraryApiWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders hello.json" do
    assert render(EighthLibraryApiWeb.HelloView, "hello.json", %{message: "Hello World!"}) == %{message: "Hello World!"}
  end
end
