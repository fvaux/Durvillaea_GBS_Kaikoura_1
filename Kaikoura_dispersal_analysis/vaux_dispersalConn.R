library(ncdf4)
library(raster) # pkg retired - code could be refactored to work in terra
library(rWind)
library(gdistance)
library(spatstat.geom)

# custom functions
source("functions/uv2dsRaster.R")source("functions/dispersalCost.R")source("functions/fill_na.R")source("functions/moana2dirspd.R")

# read in and project site coordinates to NZGD2000
kelp_site_data <- read.csv("Vaux_kelp_coords.csv", row.names = 1)[,c("lon", "lat")]
kelp_site_data$projX <- spTransform(SpatialPoints(kelp_site_data[,c("lon", "lat")], proj4string = CRS("+proj=longlat +datum=WGS84 +no_defs")), "+proj=tmerc +lat_0=0 +lon_0=173 +k=0.9996 +x_0=1600000 +y_0=10000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")@coords[,1]
kelp_site_data$projY <- spTransform(SpatialPoints(kelp_site_data[,c("lon", "lat")], proj4string = CRS("+proj=longlat +datum=WGS84 +no_defs")), "+proj=tmerc +lat_0=0 +lon_0=173 +k=0.9996 +x_0=1600000 +y_0=10000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")@coords[,2]


# pre-processing of Moana hindcast data - depending on how many months/years of Moana data used this can take a long time
# the moana_data/raw folder should contain netcdf files from the 28-year Moana surface hindcast (https://doi.org/10.5281/zenodo.5895265) - full dataset available from https://www.moanaproject.org/hindcast
# first convert all moana project data into transition layers
sapply(list.files("moana_data/raw", full.names = T, recursive = T), moana2dirspd) #loop moana2dirspd function over moana hindcast netcdf files and convert for transitions layers


# once all moana hindcast layers have been converted to transition layers calculate dispersal cost from each site of interest
lapply(1:nrow(kelp_site_data), function(i){ # loop dispersalCost function over all sites and transition layers
	sapply(list.files("moana_data/processed", full.names = TRUE), dispersalCost, site_coord = c(kelp_site_data$projX[i], kelp_site_data$projY[i]), site = rownames(kelp_site_data)[i]) #loop dispersalCost function over all transition layers; site_coord = coordinates of site from which you want calculate cost (in NZ2000 projectied coordinates); site = site name as a character string - used for output file naming
	})

##calculate per-day weights to apply for calculating seasonally (based on kelp reporduction) weighted medians. Same weights can be used for all sites as they have the same timeseries
wghts <- lapply(list.files("moana_data/accCost/Wharanui", full.names = T, pattern = ".grd"), function(x){
	tmp <- brick(x)
	names(tmp)
}) |> do.call(what = c) |> as.Date(format = "nz5km%Y%m%d_00z_Wharanui") |> format("%m") |> as.numeric() |> sapply(FUN = function(x){
	if(x < 4 | x > 9)return(0.01)
	if(x == 4)return(0.25)
	if(x == 5)return(0.5)
	if(x == 6 | x == 9)return(0.75)
	if(x == 7 | x == 8)return(1)
})


# Once pre-processing is complete you should have cost-distance rasters from all sites to all other sites, and for every day in the origianl Moana dataset
# Next calculate a weighted median distance matrix from all processed cost distance rasters in the accCost folder
# Note that the resultant distance matrix will be aysymetric (i.e. the cost change based on the to/from direction)
distMat <- lapply(rownames(kelp_site_data), function(x){

	lst <- list.files(paste0("moana_data/accCost/", x), pattern = ".grd", full.names = T)
	dat <- lapply(lst, function(i){
		rst <- brick(i)
		dist_dat <- raster::extract(rst, SpatialPoints(kelp_site_data[,c("projX", "projY")]))}) |> do.call(what = cbind)
	sapply(1:nrow(dat), function(x){if(max(dat[x,]) == 0){return(0)}else{spatstat.geom::weighted.quantile(dat[x,], w = wghts, probs = 0.5)}})
	
}) |> do.call(what = cbind)

# easy naming for distance matrix
rownames(distMat) <- rownames(kelp_site_data)
colnames(distMat) <- rownames(kelp_site_data)

# convert distance matrix from accumulated cost to relative connectivity
distMat <- distMat - min(distMat[distMat > 0])
distMat <- (max(distMat)+100) - distMat
distMat[distMat >= max(distMat)] <- NA #remove self-connectivity
distMat <- (distMat/sum(distMat , na.rm = T))*100 #convert to % relative connectivity 

distMat #final asymmetric distance matrix showing relative connectivty between all site combinations