defmodule EighthLibraryApi.LibraryTest do
  use EighthLibraryApi.DataCase

  alias EighthLibraryApi.Library

  describe "books" do
    alias EighthLibraryApi.Library.Book

    @valid_attrs %{author: "some author", description: "some description", image: "some image", is_available: true, rating: 120.5, title: "some title"}
    @update_attrs %{author: "some updated author", description: "some updated description", image: "some updated image", is_available: false, rating: 456.7, title: "some updated title"}
    @invalid_attrs %{author: nil, description: nil, image: nil, is_available: nil, rating: nil, title: nil}

    def book_fixture(attrs \\ %{}) do
      {:ok, book} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Library.create_book()

      book
    end

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Library.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Library.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      assert {:ok, %Book{} = book} = Library.create_book(@valid_attrs)
      assert book.author == "some author"
      assert book.description == "some description"
      assert book.image == "some image"
      assert book.is_available == true
      assert book.rating == 120.5
      assert book.title == "some title"
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      assert {:ok, %Book{} = book} = Library.update_book(book, @update_attrs)
      assert book.author == "some updated author"
      assert book.description == "some updated description"
      assert book.image == "some updated image"
      assert book.is_available == false
      assert book.rating == 456.7
      assert book.title == "some updated title"
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_book(book, @invalid_attrs)
      assert book == Library.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Library.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Library.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Library.change_book(book)
    end
  end
end
