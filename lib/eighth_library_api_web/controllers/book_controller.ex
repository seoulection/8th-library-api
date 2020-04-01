defmodule EighthLibraryApiWeb.BookController do
  use EighthLibraryApiWeb, :controller
  alias EighthLibraryApi.Library
  alias EighthLibraryApi.Repo
  alias EighthLibraryApiWeb.BookView

  def index(conn, _params) do
    books = Library.list_books
            |> Repo.preload([:borrower, :owner])
    conn
    |> put_status(:ok)
    |> put_view(BookView)
    |> render("books.json", books: books)
  end

  def show(conn, %{"id" => id}) do
    book = Library.get_book!(id)
           |> Repo.preload([:borrower, :owner])

    conn
    |> put_status(:ok)
    |> put_view(BookView)
    |> render("book.json", book: book)
  end

  def create(conn, params) do
    book_params = %{
      title: params["title"],
      author: params["author"],
      description: params["description"],
      image: params["image"]
    }

    current_user = get_session(conn, :current_user)

    book_changeset = Ecto.build_assoc(current_user, :owned_books, book_params)

    case Library.create_user_book(book_changeset) do
      {:ok, book} ->
        conn
        |> put_status(:created)
        |> put_view(BookView)
        |> render("book.json", book: Repo.preload(book, [:borrower, :owner]))
      {:error, _} ->
        conn
        |> send_resp(400, "")
    end
  end

  def borrow(conn, %{"id" => book_id}) do
    current_user = get_session(conn, :current_user)
    book_changeset = Library.get_book!(book_id)
                     |> Repo.preload([:borrower, :owner])
                     |> Ecto.Changeset.change(%{borrower: current_user, is_available: false})

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

  def return(conn, %{"id" => book_id}) do
    book_changeset = Library.get_book!(book_id)
                     |> Repo.preload([:borrower, :owner])
                     |> Ecto.Changeset.change(%{borrower: nil, is_available: true})

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
