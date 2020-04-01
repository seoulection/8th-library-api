defmodule EighthLibraryApi.Library.Book do
  @derive {Jason.Encoder, only: [:author, :description, :image, :is_available, :rating, :title, :owner, :borrower]}
  use Ecto.Schema
  import Ecto.Changeset

  alias EighthLibraryApi.Accounts

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "books" do
    field :author, :string, null: false
    field :description, :string, null: false
    field :image, :binary, default: nil
    field :is_available, :boolean, default: true
    field :rating, :float, default: 0.0
    field :title, :string, null: false
    belongs_to :owner, Accounts.User, type: :id
    belongs_to :borrower, Accounts.User, type: :id, on_replace: :nilify

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
