# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     EighthLibraryApi.Repo.insert!(%EighthLibraryApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias EighthLibraryApi.{Accounts, Repo}

# create test user with some books
test_user = %Accounts.User{
  email: "test@8thlight.com",
  first_name: "Test",
  last_name: "User",
  image_url: "some image url"
}
test_user = Repo.insert!(test_user)

book_attrs = %{
  title: "Test User Book",
  author: "Some Random Author",
  description: "Some random description"
}
book = Ecto.build_assoc(test_user, :owned_books, book_attrs)
Repo.insert!(book)

book_attrs = %{
  title: "Another Test User Book",
  author: "Some Really Random Author",
  description: "Some really random description"
}
book = Ecto.build_assoc(test_user, :owned_books, book_attrs)
book_to_be_borrowed = Repo.insert!(book)

# create cool person with some books
cool_person = %Accounts.User{
  email: "cool@8thlight.com",
  first_name: "Cool",
  last_name: "Person",
  image_url: "some image url"
}

cool_person = Repo.insert!(cool_person)
book_attrs = %{
  title: "A New York Times Best Seller",
  author: "Worst Author",
  description: "This is a troll description"
}
book = Ecto.build_assoc(cool_person, :owned_books, book_attrs)
book = Repo.insert!(book)

# cool person borrows a book
book_changeset = book_to_be_borrowed
                 |> Repo.preload([:borrower, :owner])
                 |> Ecto.Changeset.change(%{borrower: cool_person, is_available: false})

Repo.update(book_changeset)
