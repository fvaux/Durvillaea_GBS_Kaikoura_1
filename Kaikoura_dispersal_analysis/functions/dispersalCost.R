dispersalCost <- function(trans_mat, site_coord, site){ #give file path to transiton matrix, coordinates in NZD2000 projection as xy vector , and site name as character string (for filenaming)

	seaCond <- readRDS(trans_mat) #read in transition matrix
	seaCost <- brick(lapply(1:nlayers(seaCond), function(x){accCost(seaCond[[x]], fromCoords =  site_coord)})) #calculate accumulated cost of moving from site to all over cells in raster
	layernames <- rep(substr(tail(strsplit(trans_mat, "/")[[1]], 1), 1, 18), nlayers(seaCost)) #get name/date info from transmat filename
	substr(layernames, 12, 13) <- formatC(1:nlayers(seaCost), width = 2, flag = 0) #format numbers with leading 0
	names(seaCost) <- paste0(layernames, site) #rename layers
	dir.create(paste0("moana_data/accCost/", site), showWarnings = FALSE)
	writeRaster(seaCost, paste0("moana_data/accCost/", site, "/", substr(tail(strsplit(trans_mat, "/")[[1]], 1), 1, 17))) #output accumulated cost layer as a native raster file
	return(trans_mat) #return name of processed transition matrix for progress tracking purposes			
	}