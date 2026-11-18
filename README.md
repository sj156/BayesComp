# BayesComp

R package and computational companion for STA5001 Bayesian & Computational
Statistics. Chapter numbers follow the lecture notes. The companion currently
covers Chapters 1–5. Each worked example develops the concept, states the
example, explains the code, and shows the resulting numbers and figures.

| Chapter | R Markdown | Rendered HTML |
| --- | --- | --- |
| 1. Introduction | [Source](docs/chapters/chapter-01.Rmd) | [HTML file](docs/chapters/chapter-01.html) |
| 2. One-parameter Models | [Source](docs/chapters/chapter-02.Rmd) | [HTML file](docs/chapters/chapter-02.html) |
| 3. Univariate and Multivariate Normal Models | [Source](docs/chapters/chapter-03.Rmd) | [HTML file](docs/chapters/chapter-03.html) |
| 4. Gaussian Linear Regression | [Source](docs/chapters/chapter-04.Rmd) | [HTML file](docs/chapters/chapter-04.html) |
| 5. Bayesian Model Uncertainty | [Source](docs/chapters/chapter-05.Rmd) | [HTML file](docs/chapters/chapter-05.html) |

Download an HTML file and open it in a browser to see the code, results, and
figures. The HTML files also include a download of their R Markdown source.
After cloning or downloading the repository, open
[the chapter index](docs/index.html) in your browser to browse all chapters.

## Run the examples

Install the rendering dependencies and the package from GitHub.

```r
install.packages(c("remotes", "rmarkdown"))
remotes::install_github("sj156/BayesComp")
```

Open a chapter source in RStudio and choose **Knit**. Rendering also needs
Pandoc, which is bundled with RStudio. During a chapter render, the document
uses the installed BayesComp package. Its figures come from the lecture notes
where the setups match. Each HTML file records the R and BayesComp versions
used to render it.

## School-means example

Section 3.3 demonstrates the Gaussian update on the six constructed schools
one step at a time, then uses the package to evaluate the same update across
the integration grid. It shows how to specify the prior, check the accuracy of
the quadrature, compare schools, and generate joint posterior draws and
predictions.

- `school_means` contains the six observed means and sample sizes.
- `school_means_conditional()` returns the conditional posterior parameters
  across values of the between-school standard deviation.
- `school_means_log_likelihood()` integrates out the Gaussian parameters.
- `school_means_grid()` combines the marginal likelihood with a supplied
  scale prior and returns quadrature weights and a posterior CDF.

## Rebuild from a checkout

From the repository root, run the following with R, Pandoc, and the
`rmarkdown` package available.

```sh
R CMD build .
R CMD check --no-manual BayesComp_*.tar.gz
R CMD INSTALL BayesComp_*.tar.gz
Rscript --vanilla scripts/render-chapters.R
```

The render script runs each chapter in a separate R session and writes its
HTML beside the source in `docs/chapters/`. Commit the revised HTML with its
source. GitHub Actions checks the package and rebuilds the chapter outputs.
