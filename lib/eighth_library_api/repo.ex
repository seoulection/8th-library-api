defmodule EighthLibraryApi.Repo do
  use Ecto.Repo,
    otp_app: :eighth_library_api,
    adapter: Ecto.Adapters.Postgres
end
