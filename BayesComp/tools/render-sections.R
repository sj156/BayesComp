# Run from the repository root after installing BayesComp and rmarkdown.
section_dirs <- list.dirs(".", full.names = FALSE, recursive = FALSE)
section_dirs <- sort(grep("^section-[0-9]+$", section_dirs, value = TRUE))
if (!length(section_dirs)) {
  stop("No section folders found. Run this script from the repository root.",
       call. = FALSE)
}
sources <- file.path(section_dirs, paste0(section_dirs, ".Rmd"))
missing <- sources[!file.exists(sources)]
if (length(missing)) {
  stop("Missing section source: ", paste(missing, collapse = ", "), call. = FALSE)
}

render <- "rmarkdown::render(commandArgs(trailingOnly = TRUE)[1])"
for (source in sources) {
  result <- system2(file.path(R.home("bin"), "Rscript"), c(
    "--vanilla", "-e", shQuote(render), shQuote(source)
  ))
  if (result != 0L) {
    stop("Rendering failed for ", source, call. = FALSE)
  }
}
