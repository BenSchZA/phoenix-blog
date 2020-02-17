defmodule App.Posts.Crawler do
  def crawl do
    File.ls!(Application.app_dir(:app, "priv/posts"))
    |> Enum.map(fn(file) -> Task.async(fn -> App.Posts.Post.compile(file) end) end)
    |> Enum.map(&Task.await/1)
    |> Enum.filter(&draft/1)
    |> Enum.sort(&sort/2)
  end

  def sort(a, b) do
    Timex.compare(a.date, b.date) > 0
  end

  def draft(a) do
    !a.draft
  end
end

