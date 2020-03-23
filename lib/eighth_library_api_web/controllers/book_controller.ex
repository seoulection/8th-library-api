defmodule EighthLibraryApiWeb.BookController do
  use EighthLibraryApiWeb, :controller
  alias EighthLibraryApi.Accounts
  alias EighthLibraryApi.Library
  alias EighthLibraryApi.Repo
  alias EighthLibraryApiWeb.BookView

  def index(conn, _params) do
    books = Library.list_books
            |> Repo.preload([:borrowed_user, :user])
    conn
    |> put_status(:ok)
    |> put_view(BookView)
    |> render("books.json", books: books)
  end

  def show(conn, %{"id" => id}) do
    book = Library.get_book!(id)
           |> Repo.preload([:borrowed_user, :user])

    conn
    |> put_status(:ok)
    |> put_view(BookView)
    |> render("book.json", book: book)
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
      {:ok, book} ->
        conn
        |> put_status(:created)
        |> put_view(BookView)
        |> render("book.json", book: Repo.preload(book, [:borrowed_user, :user]))
      {:error, _} ->
        conn
        |> send_resp(400, "")
    end
  end

  def update(conn, params) do
    user = Accounts.get_user!(params["user_id"])

    book_changeset = Library.get_book!(params["book_id"])
                     |> Repo.preload([:borrowed_user, :user])
                     |> Ecto.Changeset.change(%{borrowed_user: user, is_available: false})

    case Repo.update(book_changeset) do
      {:ok, book} ->
        conn
        |> put_status(:ok)
        |> put_view(BookView)
        |> render("book.json", book: book)
      {:error, _} ->
        conn
        |> send_resp(400, "")
    end
  end
end
