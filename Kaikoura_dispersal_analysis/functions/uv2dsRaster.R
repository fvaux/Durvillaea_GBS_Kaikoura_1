uv2dsRaster <- function (uv){if(any(is.na(uv))){ #function to convert raster of U and V vectors to raster direction and speed
				res <- cbind(dir = NA, speed = NA)
		}else{
		    	u <- uv[1]
		    	v <- uv[2]
		    	direction <- atan2(u, v) #arc-tangent
		    	direction <- (direction * 180)/(pi) #convert radians to degrees
		    	direction[direction < 0] <- 360 + direction[direction < 0]
		    	speed <- sqrt((u * u) + (v * v))
		    	res <- cbind(dir = direction, speed = speed)
		    	}
		    	return(res)}
