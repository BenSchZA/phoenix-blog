defmodule AppWeb.AboutController do
  use AppWeb, :controller

  def index(conn, _params) do
    {:ok, post} = App.Pages.Repo.get_by_slug("about")
    render conn, "index.html", post: post
  end
end
