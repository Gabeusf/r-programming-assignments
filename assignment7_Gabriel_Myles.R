# assignment7_Gabriel_Myles.R
# Author: Gabriel Myles
# Course: LIS4370 — R Programming
# Assignment #7: Exploring R's Object-Oriented Systems (S3 & S4)
# ---------------------------------------------------------------
# This script demonstrates:
#   1) Loading/inspecting a dataset
#   2) Trying a few base generic functions
#   3) Creating/using an S3 class with methods
#   4) Creating/using an S4 class with methods
#   5) Simple comparisons between S3 and S4

# ------------------------------
# 1) Choose or Download Data
# ------------------------------
data(mtcars)              # built-in dataset
df <- mtcars
df$cyl <- factor(df$cyl)  # a quick factor for plotting

cat('Head of df:\n'); print(head(df, 3))
cat('\nStructure of df:\n'); str(df)
cat('\nClass of df:', class(df), '\n')
cat('Underlying storage type (typeof):', typeof(df), '\n\n')

# ------------------------------
# 2) Test Generic Functions
# ------------------------------
cat('Summary(df):\n')
print(summary(df))  # summary() is a generic

# A quick plot to show base generic plotting.
# (Will open a plot device if run in RStudio or R GUI)
# Uncomment if you need the figure in your blog.
# plot(mpg ~ cyl, data = df,
#      main = 'MPG by Cylinder (mtcars)',
#      xlab = 'Cylinders', ylab = 'Miles per Gallon')

# ------------------------------
# 3) Explore S3 vs S4
# ------------------------------
# ---------- S3 Example ----------
# Make a simple "student" object as a list and tag a class on it.
s3_obj <- list(name = 'Gabriel Myles', age = 29, GPA = 3.5)
class(s3_obj) <- 'student_s3'

# Define S3 methods by naming convention: generic.class
print.student_s3 <- function(x, ...) {
  cat(sprintf('<student_s3> %s (age %d) — GPA: %.2f\n',
              x$name, as.integer(x$age), x$GPA))
  invisible(x)
}

summary.student_s3 <- function(object, ...) {
  out <- list(
    name = object$name,
    age  = object$age,
    GPA  = object$GPA,
    status = if (object$GPA >= 3.7) 'Dean\'s List'
             else if (object$GPA >= 3.0) 'Good Standing'
             else 'Probation'
  )
  class(out) <- 'summary.student_s3'
  print(out)
  invisible(out)
}

# A small generic + methods to demonstrate dispatch
gpa_status <- function(x, ...) UseMethod('gpa_status')
gpa_status.student_s3 <- function(x, ...) {
  if (x$GPA >= 3.7) 'Excellent'
  else if (x$GPA >= 3.0) 'Solid'
  else 'Needs improvement'
}
gpa_status.default <- function(x, ...) 'Unknown (no method for this type)'

cat('S3 print(s3_obj):\n'); print(s3_obj)
cat('S3 summary(s3_obj):\n'); summary(s3_obj)
cat('S3 gpa_status(s3_obj):\n'); print(gpa_status(s3_obj))
cat('S3 gpa_status(df) (should hit default):\n'); print(gpa_status(df))

# ---------- S4 Example ----------
# S4 classes require formal declarations.
setClass('student_s4',
         slots = c(name = 'character', age = 'numeric', GPA = 'numeric'),
         prototype = list(name = NA_character_, age = NA_real_, GPA = NA_real_))

# Create an instance
s4_obj <- new('student_s4', name = 'Gabriel Myles', age = 29, GPA = 3.5)

# Define methods using setGeneric/setMethod (or existing generics like show())
setMethod('show', 'student_s4', function(object) {
  cat(sprintf('<student_s4> %s (age %d) — GPA: %.2f\n',
              object@name, as.integer(object@age), object@GPA))
})

# Create a new generic only if it does not already exist
if (!isGeneric('gpa_status_s4')) {
  setGeneric('gpa_status_s4', function(x) standardGeneric('gpa_status_s4'))
}
setMethod('gpa_status_s4', 'student_s4', function(x) {
  if (x@GPA >= 3.7) 'Excellent'
  else if (x@GPA >= 3.0) 'Solid'
  else 'Needs improvement'
})

# Another example: a simple summary method for S4
if (!isGeneric('summary')) {
  setGeneric('summary', function(object, ...) standardGeneric('summary'))
}
setMethod('summary', 'student_s4', function(object, ...) {
  status <- if (object@GPA >= 3.7) 'Dean\'s List'
            else if (object@GPA >= 3.0) 'Good Standing'
            else 'Probation'
  out <- list(name = object@name, age = object@age, GPA = object@GPA, status = status)
  # Keep it simple: print and return the list
  print(out)
  invisible(out)
})

cat('\nS4 object display (show):\n'); s4_obj
cat('S4 summary(s4_obj):\n'); summary(s4_obj)
cat('S4 gpa_status_s4(s4_obj):\n'); print(gpa_status_s4(s4_obj))

# Quick S3 vs S4 inspection helpers
cat('\n--- S3 vs S4 checks ---\n')
cat('isS4(s3_obj):', isS4(s3_obj), '\n')
cat('isS4(s4_obj):', isS4(s4_obj), '\n')
cat('class(s3_obj):', class(s3_obj), '\n')
cat('class(s4_obj):', class(s4_obj), '\n')
cat('Methods for print on s3_obj class exist via naming convention.\n')
cat('Methods for s4_obj are registered via setMethod().\n')
