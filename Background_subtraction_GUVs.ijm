run("Close All");
filepath_string = "";
list = getFileList(filepath_string);
for (i = 0; i < list.length; i++){
filename_fromlist =list[i];
filename_string = filename_fromlist;
if(startsWith(filename_string, "GUV6_")){
open(filepath_string + filename_string);
//close();
}
}
run("Concatenate...", "all_open title=data open");
run("Next Slice [>]");
run("Delete Slice", "delete=channel");
rename("Data")
run("32-bit");
	//REMOES BRIGHT SPOTS
makeRectangle(542, 532, 337, 337);
//makeRectangle(334, 348, 726, 726);
run("Crop");
//run("Remove Outliers...", "radius=50 threshold=1 which=Bright");
//run("Gaussian Blur...", "sigma=5");
run("Select All");
run("32-bit");
run("Subtract Background...", "rolling=15 stack");
rename("Background-subtracted Data")
run("Duplicate...", "duplicate");
rename("Blurred-subtracted Data")
getDimensions(width, height, channels, slices, frames);
//FOR VIEWING
run("Enhance Contrast", "saturated=0.35");
//GO THROUGH EACH STEP AND FIX THE MEDIAN FOR A LARGE ROI
//run("Gaussian Blur...", "sigma=3 stack");
setSlice(1);
for (i = 0; i < frames; i++){
run("Select All");
makeOval(88, 96, 144, 144);
//makeOval(294, 279, 146, 146);
run("Make Inverse");
getStatistics(area, mean, min, max, std, histogram);
median_value = getValue("Median");
run("Select All");
run( "Subtract...", "value=[median_value]" );
//MEASURE THE TOTAL INTENSITY ABOVE BACKGROUND FOR A SMALL ROI
makeOval(88, 96, 144, 144);
//makeOval(296, 282, 142, 142);
run("Measure");
run("Next Slice [>]");
}