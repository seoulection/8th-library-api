defmodule EighthLibraryApi.Accounts.User do
  @derive {Jason.Encoder, only: [:email, :first_name, :image_url, :last_name]}
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :image_url, :string
    field :last_name, :string
    has_many :books, EighthLibraryApi.Library.Book
    has_many :borrowed_books, EighthLibraryApi.Library.Book

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :image_url])
    |> validate_required([:first_name, :last_name, :email, :image_url])
    |> unique_constraint(:email)
  end
end
