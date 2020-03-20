defmodule AppWeb.PageController do
  use AppWeb, :controller

  def index(conn, _params) do
    {:ok, posts} = App.Posts.Repo.list()
    github_repos =  Enum.map([
      "pier",
      "molecule-alpha",
      "molecule-system-modelling",
      "ixo-liquidity-mechanism",
      "mechatronics-engineering-thesis",
      "nix-shells",
      "wattie-whatsapp-bot"
    ], fn repo -> App.Github.Api.github_repo(repo) end)
    tags = Enum.sort([
      "Ethereum",
      "Kubernetes",
      "Docker",
      "Traefik",
      "Nginx",
      "Solidity",
      "React",
      "Redux",
      "MongoDB",
      "NodeJS",
      "Vue",
      "TypeScript",
      "Phoenix",
      "Elixir",
      "Python",
      "Redux Saga",
      "GraphQL",
      "FreeRTOS",
      "C",
      "C++",
      "Rust",
      "HTML5",
      "CSS",
      "Tailwind",
      "Nix",
      "NixOS",
      "Unix",
      "Bash"
    ])
    clients = Enum.sort([
      "Linum Labs",
      "Molecule Protocol",
      "Rooster Media",
      "Zyteq Technologies",
      "Strait Access Technologies",
      "Protea Ecosystem",
      "ManMakeMachine",
      "ixo Foundation",
      "Cloudline",
      "Plentify"
    ])
    render conn, "index.html",
      posts: posts,
      github_repos: github_repos,
      tags: tags,
      clients: clients
  end
end
