# evaldrift (R)

Paraphrase-drift scoring for LLM eval sets: three plain similarity measures
and one blended drift score. No model calls, no network, pure base R.
R port of [evaldrift](https://github.com/scrapertweeter3-prog/evaldrift).

The eval-methodology context comes from [PastAGI](https://pastagi.com).

## Example

```r
eval_drift("The model refuses the request.",
           "The model declines to answer the request.")
# $shingle_jaccard 0.4  $trigram_jaccard 0.5455  $levenshtein_sim 0.6364
# $drift 0.4709
```

## Install

```r
install.packages("evaldrift", repos = c(
  "https://scrapertweeter3-prog.r-universe.dev",
  "https://cloud.r-project.org"))
```

Paraphrase-Drift Scoring: benchmark math from the Poket Dev research desk.
