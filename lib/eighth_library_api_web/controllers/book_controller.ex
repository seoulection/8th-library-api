defmodule EighthLibraryApiWeb.BookController do
  use EighthLibraryApiWeb, :controller
  alias EighthLibraryApi.Library
  alias EighthLibraryApi.Accounts
  alias EighthLibraryApiWeb.BookView

  def index(conn, _params) do
    books = Library.list_books
    conn
    |> put_status(:ok)
    |> put_view(BookView)
    |> render("books.json", books: books)
  end

  def create(conn, %{"book" => params, "user_id" => user_id}) do
    book_params = %{
      title: params["title"],
      author: params["author"],
      description: params["description"],
      image: params["image"]
    }

    user = Accounts.get_user!(user_id)
    book_changeset = Ecto.build_assoc(user, :books, book_params)

    case Library.create_user_book(book_changeset) do
      {:ok, _} ->
        conn
        |> send_resp(201, "")
      {:error, _} ->
        conn
        |> send_resp(400, "")
    end
  end
end
