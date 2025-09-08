# Module #2 – Importing Data and Writing Functions in R

# Provided vector
assignment2 <- c(16, 18, 14, 22, 27, 17, 19, 17, 17, 22, 20, 22)

# Buggy version (kept here for documentation)
myMean <- function(assignment2) {
  return(sum(someAssignment) / length(someData))
}

# This will throw an error, so leave it commented:
# myMean(assignment2)

# Corrected version
myMean <- function(x) {
  return(sum(x) / length(x))
}

# Test run
myMean(assignment2)  # Expected output: 19.25
