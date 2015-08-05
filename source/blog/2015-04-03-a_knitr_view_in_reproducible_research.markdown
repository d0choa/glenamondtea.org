---
title: A knitr view in reproducible research
date: 2015-04-03
author: David Ochoa
type: Tutorial
tags: tutorial
standfirst: XXXX
published: false
---

Last May we celebrated our first [evocellnet](XXX) group retreat in Alghero, Sardinia. Among the many scientific activities that went on during these three days, we had a series of *geeky* talks about different systems that people in the group have in place in order to achieve a more reproducible research. Brandon Invergo (XXX) gave an excellent talk about Makefiles, Marco Galardini (XXX) spoke about the usefulness of Jupyter notebooks (formerly known as iPython Notebooks) and I described knitr as tool to build reproducible reports in R. As a side product, we decided to write a series of back-to-back blog posts describing the advantages and disadvantages of the three systems in Computational Biology.

My experience using integrated notebooks started 5 years ago. By that time, I was collaborating with two other scientists in San Diego and Barcelona. We usually met by Skype every one or two weeks and I needed a way to share my progress in the most effective way. After exchanging a few emails containing some plots generated in R and a few lines describing my results, I realized we were wasting a lot of time trying to remember each week how exactly each of the plots was generated. By that time, I met some people who was using [Sweave](XXX) as a tool to intercalate code chunks within text document. Contrary to some people who found Sweave interesting to generate final research documents, I started using it as a digital notebook the same way the wet-lab scientist keeps track of their progress in a physical notebook. It worked great for me. I was including more and more results at the end of the document and we could see the project growing as we were having interesting discussions on what could be changed or which plots should be removed in the next version.

However, the Sweave love story was not complete. As the project started growing, there were a few steps that required a larger computational time. I didn't want to re-run all the pipeline every time, so I started using [cacheSweave](XXX). The concept of storing a cache for the long-running tasks was great and offer me the opportunity to re-run the project starting from the previous cache or re-run everything from scratch.  The cache implementation required a few lines of code for each cached chunk, so the Sweave solution was not optimal. I found a few other annoying things. For instance, it was almost imposible to generate multiple figures in the same code chunk. I had to deal with multiple workarounds to be able to print figures in a loop. Other obvious problem was that the text was a LaTeX document so it required to open the figure vignette to print each of the figures. When you start talking about  a notebook with hundreds of figures, it takes a long time.

After my PhD defense, I noticed Sweave have passed away. [Knitr](XXX) had taken its place covering most of the functional limitations of Sweave. Above any other feature I liked its simplicity. A regular knitr formatted file (.Rmd) contains a combination of markdown text and R code chunks. You can take any regular R script and with a few magical pieces of code convert it into a fully functional report to share with your collaborators or keep track of your progress. If you haven't heard about markdown is simply plain text with a few special characters to flavor it. Learn how to write in markdown shouldn't take you longer than 10 minutes, even if you don't have any previous coding experience. The R code must be encapsulated in blocks where you can also provide specific options for its interpretation or output. The resulting aspect of an .Rmd file is just a perfect combination of text and code. Interestingly, you can also include in-line code which will be interpreted and displayed within the markdown text. 

If you are up to jump in to knitr I would recommend to use the same editor you use to edit your R code. If you use Rstudio, there are a few built-in features you would like to check when working with knitr. In my case, I work remotely most of the time and very frequently run the code in a cluster, so I prefer to use more general tools. I use emacs using [polymode](XXX) for syntax highlighting.  You can check how to set it up on my emacs [init file](XXX).  

> R -e 'library(knitr);knit("knitr_example.Rnw")'

The easIn order to edit the report the easiest way is to use [Rstudio](XXX). It incorporates syntax highlighting, an integrated console and some specific features for knitr including compilation to different formats. I don't use Rstudio. I prefer to use more flexible tools that could 

You will not only have syntax highlighting but also a "Knit" button to compile your code and generate different report outputs, including HTML, PDF or Word. I'm not a big fan of Rstudio.I understand why so many people is using it, but I prefer to use more general tools. I write the code

* What's knitr. Notebook idea. Why I think it's necessary. Links to interesting references
* Basics of knitr. Markdown + R code. Code organization. Cache. Options. Inline code. Compilation.
* Sharing. Publishing. A few examples.
* My experience
* Connections with others
* Pros and Cons.