eval_drift <- function(a, b,
                       weights = c(shingle = 0.40, trigram = 0.35, lev = 0.25),
                       n = 3) {
  stopifnot(is.character(a), is.character(b), length(a) == 1, length(b) == 1)
  words <- function(x) tolower(strsplit(x, "\\W+")[[1]])
  wa <- words(a); wb <- words(b)
  jac <- function(p, q) {
    p <- unique(p); q <- unique(q)
    if (!length(p) && !length(q)) return(1)
    2 * length(intersect(p, q)) / (length(p) + length(q))
  }
  shingles <- function(w, k) {
    if (length(w) < k) return(paste(w, collapse = " "))
    vapply(seq_len(length(w) - k + 1),
           function(i) paste(w[i:(i + k - 1)], collapse = " "), "")
  }
  tri <- function(x) substring(x, seq_len(nchar(x) - 2), seq_len(nchar(x) - 2) + 2)
  j_shingle <- jac(shingles(wa, n), shingles(wb, n))
  j_tri <- jac(tri(a), tri(b))
  lev_sim <- function(x, y) {
    nx <- nchar(x); ny <- nchar(y)
    d <- matrix(0, nx + 1, ny + 1)
    d[, 1] <- 0:nx; d[1, ] <- 0:ny
    for (i in 2:(nx + 1)) for (j in 2:(ny + 1))
      d[i, j] <- min(d[i - 1, j] + 1, d[i, j - 1] + 1,
                     d[i - 1, j - 1] + (substr(x, i - 1, i - 1) != substr(y, j - 1, j - 1)))
    1 - d[nx + 1, ny + 1] / max(nx, ny, 1)
  }
  j_lev <- lev_sim(a, b)
  drift <- 1 - (weights[["shingle"]] * j_shingle +
                weights[["trigram"]] * j_tri + weights[["lev"]] * j_lev)
  list(shingle_jaccard = round(j_shingle, 4), trigram_jaccard = round(j_tri, 4),
       levenshtein_sim = round(j_lev, 4), drift = round(drift, 4))
}
