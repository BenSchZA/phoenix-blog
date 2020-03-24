defmodule App.Projects.Crawler do
  def crawl do
    File.ls!(Application.app_dir(:app, "priv/projects"))
    |> Enum.map(fn(file) -> Task.async(fn -> App.Projects.Project.compile(file) end) end)
    |> Enum.map(&Task.await/1)
    |> Enum.filter(&draft/1)
    |> Enum.sort_by(&(&1.title))
  end

  def sort(a, b) do
    Timex.compare(a.date, b.date) > 0
  end

  def draft(a) do
    !a.draft
  end
end

