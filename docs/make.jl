using Pkg
cd(@__DIR__)
Pkg.activate(".")
pkg"dev .."
Pkg.precompile()

using Lenia
using Documenter

Documenter.DocMeta.setdocmeta!(
    Lenia,
    :DocTestSetup,
    :(using Lenia);
    recursive = true
)

makedocs(;
  modules = [Lenia],
  doctest = true,
  linkcheck = true,
  authors = "Martin Malenický <z.jindrova@email.cz>",
  repo = "https://github.com/jindrzuz/Lenia.jl/blob/{commit}{path}#{line}",
  sitename = "Lenia.jl",
  format = Documenter.HTML(;
    prettyurls = get(ENV, "CI", false) == "true",
    canonical = "https://jindrzuz.github.io/Lenia.jl",
  ),
  pages = ["Home" => "index.md", "Reference" => "reference.md"],
)

deploydocs(; repo = "github.com/jindrzuz/Lenia.jl", push_preview = false)