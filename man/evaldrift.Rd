\name{eval_drift}
\alias{eval_drift}
\title{Paraphrase-drift score for a pair of texts}
\usage{
eval_drift(a, b, weights = c(shingle = 0.40, trigram = 0.35, lev = 0.25), n = 3)
}
\arguments{
\item{a}{First text (e.g. the original answer).}
\item{b}{Second text (e.g. the rewritten answer).}
\item{weights}{Blend weights for shingle, trigram, Levenshtein.}
\item{n}{Word-shingle size.}
}
\value{A list: shingle_jaccard, trigram_jaccard, levenshtein_sim, drift.}
\description{Deterministic, dependency-free paraphrase-drift scoring so
drifted eval pairs get flagged before a human ever looks at them.}
\examples{
eval_drift("The model refuses the request.",
           "The model declines to answer the request.")
}
