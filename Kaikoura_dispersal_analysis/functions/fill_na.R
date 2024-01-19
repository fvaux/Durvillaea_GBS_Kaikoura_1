fill.na <- function(x, i=5) { #fill NA gaps using mean smoother
		  if( is.na(x)[i] ) {
		    return((mean(x, na.rm=TRUE)) )
		  } else {
		    return((x[i]) )
		  }
		}  