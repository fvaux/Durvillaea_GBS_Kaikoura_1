moana2dirspd <- function(moana_ncdf){ #function to convert moana netcdf files to raster of speed and direction

	nc <- nc_open(moana_ncdf) #open netcdf files
	
	lon <- ncvar_get(nc, "lon") #extract meta
	lat <- ncvar_get(nc, "lat")
	time <- ncvar_get(nc, "time")
	
	lonIdx <- 1:length(lon) #indices
	latIdx <- 1:length(lat)
	
	trans <- sapply(1:length(time), function(x){ #apply UV->speed/dir transformation to all time steps
		timeIdx <- which(time == time[x]) #get index of time 
		
		u_dat <- ncvar_get(nc, "um")[lonIdx, latIdx, timeIdx] #get V component
		v_dat <- ncvar_get(nc, "vm")[lonIdx, latIdx, timeIdx] #get U component
		
		indices <- expand.grid(lon[lonIdx], lat[latIdx], time[timeIdx]) #get all combinations of lat, lon, and time
		df <- spTransform(SpatialPointsDataFrame(coords = indices[,1:2], data = data.frame(u = as.vector(u_dat), v = as.vector(v_dat)), proj4string = CRS("+proj=longlat +datum=WGS84 +no_defs")), crs("+proj=tmerc +lat_0=0 +lon_0=173 +k=0.9996 +x_0=1600000 +y_0=10000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")) #project combinations of lat/lon to NZ2000 projection (to match moana data) 

		# create a blank raster template to use to rasterize moana data
		r5km <- raster(new("Extent", xmin = 425253.935655553, xmax = 2773503.93565555, ymin = 4144850.07444745, ymax = 6594940.07444745), res = 5000, crs = "+proj=tmerc +lat_0=0 +lon_0=173 +k=0.9996 +x_0=1600000 +y_0=10000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")

	if(!file.exists("NZL_adm/NZL_adm0.shp")){
			# if it doesn't already exist (not included in code distribution): download NZ coastline shapefile from diva-gis.org 		
			download.file("https://biogeo.ucdavis.edu/data/diva/adm/NZL_adm.zip", "NZL_adm.zip")
			unzip("NZL_adm.zip", exdir = "NZL_adm") #unzip
		}
		NZoutline <- shapefile("NZL_adm/NZL_adm0.shp") #open shapefile
		
		x5km <- rasterize(df, r5km, fun=mean, na.rm = T, field = c("u", "v")) # rasterize dataframe 
				
		x5km_fill <- mask(brick(focal(x5km[[1]], w = matrix(1,3,3), fun = fill.na, pad = FALSE, na.rm = FALSE), focal(x5km[[2]], w = matrix(1,3,3), fun = fill.na, pad = FALSE, na.rm = FALSE)), NZoutline, inverse = T) #fill gaps arising from unequal grid used by moana dataset and then mask out land using NZ shapefile		
		seaRst <- stack(calc(x5km_fill, uv2dsRaster)) #convert raster of U and V components to speed and direction
		names(seaRst) <- c("direction", "speed") #rename layers for flow.dispersion
		seaCond <- flow.dispersion(seaRst, output = "transitionLayer") #calculate transition cost layer based on spd and dir
		return(seaCond) #return the calculate transition layer
	})
	
	saveRDS(do.call(stack, trans), paste0("moana_data/processed/",tail(strsplit(moana_ncdf, "/")[[1]], 1) |> substr(start = 1, stop = 22))) #output stacked transition layer as R data file
	return(tail(strsplit(moana_ncdf, "/")[[1]], 1) ) #return name of processed moana file for progress tracking purposes
}