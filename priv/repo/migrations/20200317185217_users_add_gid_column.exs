defmodule EighthLibraryApi.Repo.Migrations.UsersAddGidColumn do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :gid, :integer
    end
  end
end
