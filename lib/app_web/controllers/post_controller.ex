defmodule AppWeb.PostController do
  use AppWeb, :controller

  def show(conn, %{"slug" => slug}) do
    case App.Posts.Repo.get_by_slug(slug) do
      {:ok, post} -> render conn, "show.html", post: post
      :not_found -> not_found(conn)
    end
  end

  def not_found(conn) do
    conn
    |> put_status(:not_found)
    |> render(App.ErrorView, "404.html")
  end
end
