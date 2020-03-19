defmodule EighthLibraryApiWeb.BookView do
  use EighthLibraryApiWeb, :view

  def render("book.json", %{book: book}) do
    %{
      title: book.title,
      author: book.author,
      description: book.description,
      image: book.image,
      isAvailable: book.is_available,
      id: book.id
    }
  end

  def render("books.json", %{books: books}) do
    %{
      books: render_many(books, EighthLibraryApiWeb.BookView, "book.json")
    }
  end
end
