run("Close All");
roiManager("reset");
close("Log");
close("Results");

 
// Insert path to folder containing input 2D time-course microscopy images or segmentations (ideally 8-bit .tif), enter lower and upper intensity threshold values at x.
mainFolder = "/path/to/input/folder"
thresh_input_min = x
thresh_input_max = x
// Insert path to output folder where metric files will be stored.
outputFolder = "/path/to/output/folder" 

listFirstTier = getFileList(mainFolder);
listFirstTier = Array.sort(listFirstTier);

firstImagePath = mainFolder + "/" + listFirstTier[0];
open(firstImagePath);
rename("image");

setThreshold(thresh_input_min, thresh_input_max, "raw");
setOption("BlackBackground", true);
run("Convert to Mask");
run("ROI Manager...");
waitForUser("Draw circle around one dissociated soma and press OK");

// Calculate area of user-set ROI
roiManager("Add");
roiManager("Select", 0);
run("Measure");
avSize = getResult("Area");
roiManager("delete");
run("Select None");
selectWindow("image");
close(); 
run("Clear Results");

setBatchMode(true);
run("Set Measurements...", "area mean standard modal perimeter shape limit redirect=None decimal=5"); 

//DI calculation

for (k = 0; k < listFirstTier.length; k++) { 
	
	currentImagePath = mainFolder + "/" + listFirstTier[k];
	open(currentImagePath);

	setOption("ScaleConversions", true);
	setThreshold(thresh_input_min, thresh_input_max, "raw");
	setOption("BlackBackground", true);
	run("Convert to Mask");
	rename("image");
	run("Options...", "iterations=2 count=1 black do=Open");
	
	selectWindow("image");
	run("Analyze Particles...", "summarize add");
	selectWindow("Summary");
	IJ.renameResults("Summary","Results");
	
	count_1 = getResult("Count", 0);
	totArea_1 = getResult("Total Area", 0);
	avObjectArea_1 = totArea_1/count_1;
	DI = avSize/avObjectArea_1;
	run("Clear Results");
	setResult("DI", 0, DI);
	saveAs("Results", outputFolder + "/" + File.getNameWithoutExtension(currentImagePath) + "_DI.csv");
	run("Close All");
	
}

run("Close All");

setBatchMode(false);