defmodule AppWeb.LayoutView do
  use AppWeb, :view

  def active_class(conn, path) do
    current_path = Path.join(["/" | conn.path_info])
    if path == current_path do
      "active"
    else
      nil
    end
  end

  def avatar_url() do
    App.Github.Api.avatar_url()
  end
end
