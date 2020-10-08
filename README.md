
<!-- README.md is generated from README.Rmd. Please edit that file -->

gt3x\_comparison
================

<!-- badges: start -->
<!-- badges: end -->

The goal of `gt3x_comparison` is to compare reading in GT3X files from
different devices and comparing the reading in from ActiLife and
R/Python implementations.

Reports
-------

The [`old`](reports/old.html) shows the old NHANES GT3X format
comparison.

    x = list.files(pattern = ".Rmd", path = "reports", full.names = TRUE)
    x = x[file.exists(sub("[.]Rmd$", ".html", x))]

old\_upper\_limb

Packages
--------

The packages we’ll use is:

| url                                                                                                                               | package              |
|:----------------------------------------------------------------------------------------------------------------------------------|:---------------------|
| <a href="https://github.com/THLfi/read.gt3x" class="uri">https://github.com/THLfi/read.gt3x</a>                                   | read.gt3x            |
| <a href="https://github.com/muschellij2/read.gt3x" class="uri">https://github.com/muschellij2/read.gt3x</a>                       | read.gt3x            |
| <a href="https://github.com/muschellij2/pygt3x" class="uri">https://github.com/muschellij2/pygt3x</a>                             | pygt3x               |
| <a href="https://github.com/muschellij2/SummarizedActigraphy" class="uri">https://github.com/muschellij2/SummarizedActigraphy</a> | SummarizedActigraphy |
| <a href="https://github.com/paulhibbing/AGread" class="uri">https://github.com/paulhibbing/AGread</a>                             | AGread               |

Examples of zeros in CSV from ActiLife: ID-PU13, serial-NEO1B41100262.
Still not giving exact answers: ID-PU2, serial-NEO1B41100255.
