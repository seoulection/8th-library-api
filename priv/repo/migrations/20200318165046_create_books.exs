defmodule EighthLibraryApi.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :author, :string
      add :description, :string
      add :rating, :float
      add :image, :binary
      add :is_available, :boolean, default: false, null: false
      add :user_id, references(:users)
      add :borrowed_user_id, references(:users)

      timestamps()
    end

  end
end
