# BayesComp

R package and computational companion for STA5001 Bayesian & Computational
Statistics. Section numbers follow the lecture notes. The companion currently
covers Sections 1–6. Each worked example develops the concept, states the
example, explains the code, and shows the resulting numbers and figures.

| Section | R Markdown | Rendered HTML |
| --- | --- | --- |
| 1. Introduction | [Source](section-01/section-01.Rmd) | [HTML file](section-01/section-01.html) |
| 2. One-parameter Models | [Source](section-02/section-02.Rmd) | [HTML file](section-02/section-02.html) |
| 3. Univariate and Multivariate Normal Models | [Source](section-03/section-03.Rmd) | [HTML file](section-03/section-03.html) |
| 4. Gaussian Linear Regression | [Source](section-04/section-04.Rmd) | [HTML file](section-04/section-04.html) |
| 5. Bayesian Model Uncertainty | [Source](section-05/section-05.Rmd) | [HTML file](section-05/section-05.html) |
| 6. Direct Simulation and Importance Sampling | [Source](section-06/section-06.Rmd) | [HTML file](section-06/section-06.html) |

Download an HTML file and open it in a browser to see the code, results, and
figures. Each HTML file is generated from the R Markdown source beside it
and includes a source download. The [BayesComp package](BayesComp/) contains
shared functions, data, lecture figures, and the render script.

## Run the examples

Install the rendering dependencies and the package from GitHub.

```r
install.packages(c("remotes", "rmarkdown"))
remotes::install_github("sj156/BayesComp", subdir = "BayesComp")
```

Open a section source in RStudio and choose **Knit**. Rendering also needs
Pandoc, which is bundled with RStudio. During rendering, the document
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
R CMD build BayesComp
R CMD check --no-manual BayesComp_*.tar.gz
R CMD INSTALL BayesComp_*.tar.gz
Rscript --vanilla BayesComp/tools/render-sections.R
```

The render script runs each section in a separate local R session and writes
its HTML beside the source. Run the package check and rebuild locally before
committing revised sources and HTML.
