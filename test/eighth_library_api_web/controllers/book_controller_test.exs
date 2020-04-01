defmodule EighthLibraryApiWeb.BookControllerTest do
  use EighthLibraryApiWeb.ConnCase
  alias Plug.Test
  alias EighthLibraryApi.Accounts
  alias EighthLibraryApi.Library

  def user_fixture(attrs) do
    {:ok, user} =
      attrs
      |> Enum.into(attrs)
      |> Accounts.create_user()

    user
  end

  @valid_params %{
    title: "some title",
    author: "some author",
    description: "some description",
    image: "some image",
    is_available: false,
    rating: 0.0
  }

  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(@valid_params)
      |> Library.create_book()

    book
  end

  test "renders book when params are valid", %{conn: conn} do
    user_attrs = %{
      first_name: "some first name",
      last_name: "some last name",
      email: "some email",
      image_url: "some image url"
    }
    user = user_fixture(user_attrs)
    params = %{
      title: "some title",
      author: "some author",
      description: "some description",
      image: "some image"
    }
    response =
      conn
      |> Test.init_test_session(current_user: user)
      |> post(Routes.book_path(conn, :create, params))
      |> json_response(201)

    assert response["title"] == "some title"
    assert response["author"] == "some author"
    assert response["description"] == "some description"
    assert response["image"] == "some image"
    assert response["isAvailable"] == true
  end

  test "books can be shown", %{conn: conn} do
    user_attrs = %{
      first_name: "some first name",
      last_name: "some last name",
      email: "some email",
      image_url: "some image url"
    }
    user = user_fixture(user_attrs)
    book = book_fixture()

    response =
      conn
      |> Test.init_test_session(current_user: user)
      |> get(Routes.book_path(conn, :show, book.id))
      |> json_response(200)

    assert response["title"] == "some title";
    assert response["author"] == "some author";
    assert response["description"] == "some description";
    assert response["image"] == "some image";
  end

  test "shows all books", %{conn: conn} do
    user_attrs = %{
      first_name: "some first name",
      last_name: "some last name",
      email: "some email",
      image_url: "some image url"
    }
    user = user_fixture(user_attrs)
    book_fixture()
    book_fixture()
    response =
      conn
      |> Test.init_test_session(current_user: user)
      |> get(Routes.book_path(conn, :index))
      |> json_response(200)

    assert length(response["books"]) == 2
  end

  test "books can be created", %{conn: conn} do
    user_attrs = %{
      first_name: "some first name",
      last_name: "some last name",
      email: "some email",
      image_url: "some image url"
    }
    user = user_fixture(user_attrs)
    params = %{
      "title" => "some title",
      "author" => "some author",
      "description" => "some description",
      "image" => "some image"
    }

    response =
      conn
      |> Test.init_test_session(current_user: user)
      |> post(Routes.book_path(conn, :create, params))
      |> json_response(201)

    assert response["title"] == "some title"
    assert response["author"] == "some author"
    assert response["description"] == "some description"
    assert response["image"] == "some image"
    assert response["owner"]["id"] == user.id
  end

  test "books can be borrowed", %{conn: conn} do
    user_attrs = %{
      first_name: "some first name",
      last_name: "some last name",
      email: "some email",
      image_url: "some image url"
    }
    user = user_fixture(user_attrs)
    book = book_fixture()

    response =
      conn
      |> Test.init_test_session(current_user: user)
      |> patch(Routes.book_path(conn, :borrow, book.id))
      |> json_response(200)

    assert response["borrower"]["id"] == user.id
  end

  test "books can be returned", %{conn: conn} do
    user_attrs = %{
      first_name: "some first name",
      last_name: "some last name",
      email: "some email",
      image_url: "some image url"
    }
    user = user_fixture(user_attrs)
    book_changeset = Ecto.build_assoc(user, :borrowed_books, @valid_params)
    {:ok, book} = Library.create_user_book(book_changeset)

    response =
      conn
      |> Test.init_test_session(current_user: user)
      |> patch(Routes.book_path(conn, :return, book.id))
      |> json_response(200)

    assert response["borrower"] == nil
  end
end
