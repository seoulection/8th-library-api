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

  test "renders current_user.json" do
    current_user = %{
      first_name: "some first name",
      last_name: "some last name",
      email: "some email",
      image_url: "some image url",
      id: 0
    }
    assert render(UserView, "current_user.json", %{user: current_user}) == %{user: current_user}
  end

  test "render users.json" do
    users = [
      %{
        first_name: "some first name",
        last_name: "some last name",
        email: "some email",
        image_url: "some image url",
        id: 0,
        books: [],
        borrowed_books: []
      },
      %{
        first_name: "some first name",
        last_name: "some last name",
        email: "some email",
        image_url: "some image url",
        id: 1,
        books: [],
        borrowed_books: []
      }
    ]
    assert render(UserView, "users.json", %{users: users}) == %{
      users: [
        %{
          user: %{
            first_name: "some first name",
            last_name: "some last name",
            email: "some email",
            image_url: "some image url",
            id: 0,
            books: [],
            borrowed_books: []
          }
        },
        %{
          user: %{
            first_name: "some first name",
            last_name: "some last name",
            email: "some email",
            image_url: "some image url",
            id: 1,
            books: [],
            borrowed_books: []
          }
        }
      ]
    }
  end
end
