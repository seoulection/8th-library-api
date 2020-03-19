defmodule EighthLibraryApi.Library.Book do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "books" do
    field :author, :string, null: false
    field :description, :string, null: false
    field :image, :binary, default: nil
    field :is_available, :boolean, default: true
    field :rating, :float, default: 0.0
    field :title, :string, null: false
    belongs_to :user, EighthLibraryApi.Accounts.User, type: :id

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :author, :description, :rating, :image, :is_available])
    |> validate_required([:title, :author, :description, :rating, :image, :is_available])
    |> unique_constraint(:id)
  end
end
