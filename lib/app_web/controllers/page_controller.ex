defmodule AppWeb.PageController do
  use AppWeb, :controller

  def index(conn, _params) do
    {:ok, posts} = App.Posts.Repo.list()
    github_repos = Enum.map([
      "pier",
      "cadex",
      "system-modelling",
      "molecule-alpha",
      "ixo-liquidity-mechanism",
      "mechatronics-engineering-thesis",
      "nix-shells",
      "wattie-whatsapp-bot"
    ], fn repo -> App.Github.Api.github_repo(repo) end)
    tags = Enum.sort([
      "Android",
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
      "VueJS",
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
      "TailwindCSS",
      "Nix",
      "NixOS",
      "Unix",
      "Bash",
      "AWS",
      "Postgres"
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
      "Plentify",
      "Commons Stack"
    ])
    render conn, "index.html",
      posts: posts,
      github_repos: github_repos,
      tags: tags,
      clients: clients
  end
end
