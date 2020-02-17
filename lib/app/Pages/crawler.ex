defmodule App.Pages.Crawler do
  def crawl do
    File.ls!(Application.app_dir(:app, "priv/pages"))
    |> Enum.map(fn(file) -> Task.async(fn -> App.Pages.Page.compile(file) end) end)
    |> Enum.map(&Task.await/1)
    |> Enum.sort(&sort/2)
  end

  def sort(a, b) do
    Timex.compare(a.date, b.date) > 0
  end
end

