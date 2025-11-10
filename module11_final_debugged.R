# LIS4370 – Module 11 (Final): Debugging and Defensive Programming
# Student: Gabriel Myles
# Date: 2025-11-10

# Safe mean with input validation and NA handling
calculate_mean_safe <- function(numbers) {
  if (missing(numbers)) stop("'numbers' argument is required.")
  if (!is.numeric(numbers)) stop("'numbers' must be numeric.")
  if (length(numbers) == 0) stop("'numbers' must have length >= 1.")
  if (all(is.na(numbers))) stop("'numbers' cannot be all NA.")
  if (anyNA(numbers)) numbers <- numbers[!is.na(numbers)]
  sum(numbers) / length(numbers)
}

# Graceful wrapper to demonstrate tryCatch behavior
safe_call_example <- function(x) {
  tryCatch(
    calculate_mean_safe(x),
    error = function(e) {
      message("Caught error in calculate_mean_safe: ", conditionMessage(e))
      NA_real_
    }
  )
}

# Defensive division
divide_numbers_safe <- function(a, b) {
  if (!is.numeric(a) || !is.numeric(b)) stop("Both inputs must be numeric.")
  if (length(a) != 1 || length(b) != 1) stop("Both inputs must be length-1 (scalars).")
  if (b == 0) stop("Cannot divide by zero.")
  a / b
}

# Examples / Tests
cat("Mean (1,2,3,4): ", calculate_mean_safe(c(1,2,3,4)), "\n")
cat("Mean with NA (1,NA,3,5): ", calculate_mean_safe(c(1,NA,3,5)), "\n")
cat("Safe call example (should print a number): ", safe_call_example(c(10,20,30)), "\n")
cat("Divide 10 by 2: ", divide_numbers_safe(10,2), "\n")

# Uncomment to see defensive errors:
# calculate_mean_safe("not numeric")
# calculate_mean_safe(numeric(0))
# divide_numbers_safe(10, 0)
