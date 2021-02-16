defmodule AppWeb.ProjectController do
  use AppWeb, :controller

  def index(conn, _params) do
    {:ok, projects} = App.Projects.Repo.list()
    render conn, "index.html", projects: projects
  end

  def show(conn, %{"slug" => slug}) do
    case App.Projects.Repo.get_by_slug(slug) do
      {:ok, project} -> render conn, "show.html", project: project
      :not_found -> not_found(conn)
    end
  end

  def not_found(conn) do
    conn
    |> put_status(:not_found)
    |> render(App.ErrorView, "404.html")
  end
end
