# BayesComp

R package and computational companion for STA5001 Bayesian & Computational
Statistics. Section numbers follow the lecture notes. The companion currently
covers Sections 1–7. Sections 1–6 each contain a computational companion
with worked examples and a separate homework handout. Section 7 contains
investigations that extend the Gibbs sampling examples in the notes. Each
document has an R Markdown source and rendered HTML.

| Section | Computational companion | Homework handout | Homework data |
| --- | --- | --- | --- |
| 1. Introduction | [R Markdown](section-01/section-01.Rmd) · [HTML](section-01/section-01.html) | [R Markdown](section-01/homework-01.Rmd) · [HTML](section-01/homework-01.html) | [CSV](BayesComp/data/hw01_admissions.csv) |
| 2. One-parameter Models | [R Markdown](section-02/section-02.Rmd) · [HTML](section-02/section-02.html) | [R Markdown](section-02/homework-02.Rmd) · [HTML](section-02/homework-02.html) | [CSV](BayesComp/data/hw02_incidents.csv) |
| 3. Univariate and Multivariate Normal Models | [R Markdown](section-03/section-03.Rmd) · [HTML](section-03/section-03.html) | [R Markdown](section-03/homework-03.Rmd) · [HTML](section-03/homework-03.html) | [CSV](BayesComp/data/hw03_labs.csv) |
| 4. Gaussian Linear Regression | [R Markdown](section-04/section-04.Rmd) · [HTML](section-04/section-04.html) | [R Markdown](section-04/homework-04.Rmd) · [HTML](section-04/homework-04.html) | [CSV](BayesComp/data/hw04_braking.csv) |
| 5. Bayesian Model Uncertainty | [R Markdown](section-05/section-05.Rmd) · [HTML](section-05/section-05.html) | [R Markdown](section-05/homework-05.Rmd) · [HTML](section-05/homework-05.html) | [CSV](BayesComp/data/hw05_process_loss.csv) |
| 6. Direct Simulation and Importance Sampling | [R Markdown](section-06/section-06.Rmd) · [HTML](section-06/section-06.html) | [R Markdown](section-06/homework-06.Rmd) · [HTML](section-06/homework-06.html) | [CSV](BayesComp/data/hw06_latency.csv) |
| 7. Gibbs Sampling Investigations | [R Markdown](section-07/section-07.Rmd) · [HTML](section-07/section-07.html) | — | — |

Download an HTML file and open it in a browser to see the code, results, and
figures. Each HTML file is generated from the R Markdown source beside it
and includes a source download. The [BayesComp package](BayesComp/) contains
shared functions, data, lecture figures, and the render script.

## Knit a companion or handout

Install the rendering dependencies and the package from GitHub.

```r
install.packages(c("remotes", "rmarkdown"))
remotes::install_github("sj156/BayesComp", subdir = "BayesComp")
```

Open the companion or homework source in RStudio and choose **Knit**.
Rendering uses the installed BayesComp package and Pandoc, which is bundled
with RStudio. The companions use lecture-note figures where the setups match.
Each HTML file records the R and BayesComp versions used to render it.

## Homework data

The assignments use fixed synthetic datasets. Load them with the provided
`data()` calls after installing or reinstalling BayesComp. The CSV links in
the table lead to the same inputs as semicolon-delimited files. Each assignment
links to the documentation for a related public dataset.

The [data generator](BayesComp/tools/generate-homework-data.R) records the seeds
and generating models. To reproduce the CSVs from the repository root, run
`Rscript --vanilla BayesComp/tools/generate-homework-data.R`.

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

The script renders each companion and homework source in a separate local R
session and writes its HTML beside the source. In a folder named `section-NN/`,
use `section-NN.Rmd` for the companion and `homework-NN.Rmd` for the handout.
Run the package check and rebuild locally before committing revised sources and
HTML.
