defmodule EighthLibraryApiWeb.BookViewTest do
  use EighthLibraryApiWeb.ConnCase, async: true
  alias EighthLibraryApiWeb.BookView

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders book.json" do
    book = %{
      title: "some title",
      author: "some author",
      description: "some description",
      image: "some image",
      is_available: true,
      id: 1,
      borrowed_user: "some borrowed user",
      user: "some user"
    }
    assert render(BookView, "book.json", %{book: book}) == %{
      title: "some title",
      author: "some author",
      description: "some description",
      image: "some image",
      isAvailable: true,
      id: 1,
      borrowed_user: "some borrowed user",
      user: "some user"
    }
  end

  test "renders books.json" do
    books = [
      %{
        title: "some title",
        author: "some author",
        description: "some description",
        image: "some image",
        is_available: true,
        id: 1,
        borrowed_user: "some borrowed user",
        user: "some user"
      },
      %{
        title: "some title",
        author: "some author",
        description: "some description",
        image: "some image",
        is_available: true,
        id: 2,
        borrowed_user: "some borrowed user",
        user: "some user"
      }
    ]
    assert render(BookView, "books.json", %{books: books}) == %{
      books: [
        %{
          title: "some title",
          author: "some author",
          description: "some description",
          image: "some image",
          isAvailable: true,
          id: 1,
          borrowed_user: "some borrowed user",
          user: "some user"
        },
        %{
          title: "some title",
          author: "some author",
          description: "some description",
          image: "some image",
          isAvailable: true,
          id: 2,
          borrowed_user: "some borrowed user",
          user: "some user"
        }
      ]
    }
  end
end
