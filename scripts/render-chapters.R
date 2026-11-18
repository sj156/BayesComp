# Run from the repository root after installing BayesComp and rmarkdown.
chapters <- list.files("docs/chapters", "^chapter-[0-9]+[.]Rmd$", full.names = TRUE)
if (!length(chapters)) {
  stop("No chapter sources found. Run this script from the repository root.")
}

for (chapter in chapters) {
  render <- "rmarkdown::render(commandArgs(trailingOnly = TRUE)[1])"
  result <- system2(file.path(R.home("bin"), "Rscript"), c(
    "--vanilla", "-e", shQuote(render), shQuote(chapter)
  ))
  if (result != 0L) {
    stop("Rendering failed for ", chapter, call. = FALSE)
  }
}
