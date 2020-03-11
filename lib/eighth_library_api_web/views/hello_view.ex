defmodule EighthLibraryApiWeb.HelloView do
  use EighthLibraryApiWeb, :view

  def render("hello.json", %{message: message}) do
    %{
      message: message
    }
  end
end
