defmodule App.Pages.Crawler do
  def crawl do
    result = File.ls!(Application.app_dir(:app, "priv/pages"))
    |> Enum.map(fn(file) -> Task.async(fn -> App.Pages.Page.compile(file) end) end)
    |> Enum.map(&Task.await/1)
    |> Enum.sort(&sort/2)

    # HTTPoison.start

    # case HTTPoison.get("https://medium.com/feed/@benscholtz") do
    #   {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
    #     {:ok, map_of_rss} = FastRSS.parse(body)
    #     IO.puts Map.keys(map_of_rss)
    #   {:ok, %HTTPoison.Response{status_code: 404}} ->
    #     IO.puts "Not found :("
    #   {:error, %HTTPoison.Error{reason: reason}} ->
    #     IO.inspect reason
    # end

    result
  end

  def sort(a, b) do
    Timex.compare(a.date, b.date) > 0
  end
end

