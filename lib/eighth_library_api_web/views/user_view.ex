defmodule EighthLibraryApiWeb.UserView do
  use EighthLibraryApiWeb, :view

  def render("login.json", %{user: user}) do
    %{
      user: %{
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        image_url: user.image_url,
        id: user.id
      }
    }
  end

  def render("users.json", %{users: users}) do
    %{
      users: render_many(users, EighthLibraryApiWeb.UserView, "login.json")
    }
  end

  def render("current_user.json", %{current_user: current_user}) do
    %{
      current_user: current_user
    }
  end
end