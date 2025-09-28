# Assignment #5 – Matrix Algebra in R
# -------------------------------------------------
# 1) Create matrices A (10x10) and B (10x100)
A <- matrix(1:100,  nrow = 10)
B <- matrix(1:1000, nrow = 10)

# 2) Inspect dimensions / squareness
is_square <- function(M) {
  d <- dim(M)
  list(dim = d, square = (d[1] == d[2]))
}

cat("A dims:", paste(dim(A), collapse=" x "), "  square =", is_square(A)$square, "\n")
cat("B dims:", paste(dim(B), collapse=" x "), "  square =", is_square(B)$square, "\n\n")

# 3) Compute inverse and determinant
#    For A (square)
invA <- tryCatch(solve(A),
                 error = function(e) e)
detA <- tryCatch(det(A),
                 error = function(e) e)

#    For B (not square) — capture errors gracefully
invB <- tryCatch(solve(B),
                 error = function(e) e)
detB <- tryCatch(det(B),
                 error = function(e) e)

# 4) Display results clearly
show_result <- function(label, obj) {
  cat("----", label, "----\n")
  if (inherits(obj, "error")) {
    cat("Error:", conditionMessage(obj), "\n\n")
  } else {
    print(obj); cat("\n")
  }
}

show_result("Inverse of A (invA)", invA)
show_result("Determinant of A (detA)", detA)
show_result("Inverse of B (invB)", invB)
show_result("Determinant of B (detB)", detB)

# 5) Brief notes (printed) on what happened
cat("NOTES:\n")
cat("- solve(A) computes A^{-1} for square, non-singular A; det(A) gives its determinant.\n")
cat("- B is 10x100 (non-square), so inversion & determinant are undefined and should error by design.\n")
cat("- Large, poorly-conditioned matrices can produce numerical warnings or unstable inverses.\n")
