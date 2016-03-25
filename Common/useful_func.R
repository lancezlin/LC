

# trimws function in R
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
trim.leading <- function (x)  sub("^\\s+", "", x)
trim.trailing <- function (x) sub("\\s+$", "", x)