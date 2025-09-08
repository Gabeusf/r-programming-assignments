# r-programming-assignments
Gabriel Myles  
LIS4370  

Repository for R Programming Assignments  

## Module #2 – Importing Data and Writing Functions in R  

This assignment focused on importing data into RStudio and debugging a function.  

---

## Problem  
We were given this vector and function:  

```r
assignment2 <- c(16, 18, 14, 22, 27, 17, 19, 17, 17, 22, 20, 22)

myMean <- function(assignment2) {
  return(sum(someAssignment) / length(someData))
}

myMean(assignment2  ```

---

## Error
This produced the following error:

```
Error in sum(someAssignment) : object 'someAssignment' not found
```

---

## Solution
I corrected the function by properly using the input variable:

```r
myMean <- function(x) {
  return(sum(x) / length(x))
}

myMean(assignment2)
```

---

## Result
```
[1] 19.25
```
