defmodule EighthLibraryApiWeb.UserViewTest do
  use EighthLibraryApiWeb.ConnCase, async: true
  alias EighthLibraryApiWeb.UserView

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders user.json" do
    user = %{
      first_name: "some first name",
      last_name: "some last name",
      email: "some email",
      image_url: "some image url",
      id: 0,
      books: [],
      borrowed_books: []
    }
    assert render(UserView, "user.json", %{user: user}) == %{user: user}
  end
end
