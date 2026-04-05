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

setBatchMode(true);
run("Set Measurements...", "area mean standard modal perimeter shape limit redirect=None decimal=5"); 

//Calculate initial soma count

firstImagePath = mainFolder + "/" + listFirstTier[0];
open(firstImagePath);
rename("image");
run("8-bit");
setThreshold(thresh_input_min, thresh_input_max, "raw");
setOption("BlackBackground", true);
run("Convert to Mask");
run("Analyze Particles...", "summarize add");
selectWindow("Summary");
IJ.renameResults("Summary","Results");
initialCount = getResult("Count", 0);
selectWindow("image");
close(); 
run("Clear Results");

//Calculate CDF

for (k = 0; k < listFirstTier.length; k++) { 

	currentImagePath = mainFolder + "/" + listFirstTier[k];
	open(currentImagePath);
	setOption("ScaleConversions", true);
	run("8-bit");  
	setThreshold(thresh_input_min, thresh_input_max, "raw");
	setOption("BlackBackground", true);
	run("Convert to Mask");
	rename("image");
	run("Options...", "iterations=2 count=1 black do=Open");

	run("Set Measurements...", "area perimeter redirect=None decimal=5");
	run("Analyze Particles...", "display summarize");
	totalPerimeter = 0;

	for (i = 0; i < nResults; i++) {
		totalPerimeter += getResult("Perim.", i);
	}

	CDF = initialCount/totalPerimeter;
	run("Clear Results");
	setResult("CDF", 0, CDF);

	saveAs("Results", outputFolder + "/" + File.getNameWithoutExtension(currentImagePath) + "_CDF.csv");
	run("Close All");	
		
}

run("Close All");
setBatchMode(false);