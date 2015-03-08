## Instructions on how to run the R codes for plotting "plot1-4.png"

The R codes plot(1-4).R when ran, will first create a "data" folder in your
current directory. 
It will then download the two days data (from the dates 2007-02-01 and 2007-02-02) required
for the assignment.
The data will then be processed and used to generate the requested plots.


<ol>
<li>The R codes <b>plot(1-4).R</b> when ran, will first create a "data" folder in your
current directory.</li>
<li>It will then download the two days data (from the dates <b>2007-02-01</b> and <b>2007-02-02)</b> required
for the assignment.</li>
<li>The data will then be processed and used to generate the requested plots <b>plot(1-4).png</b>. </li>
<li>Comments are inserted throughout the codes to explain each command. </li>
</ol>



<b>Notes:</b> 

Running the codes in RStudio using the <b>source("plot(1-4).R"</b> method will produce some errors and
warnings. However, it works fine in R but will produce some warning messages that do not affect the 
results. 

For the code to work in RStudio, you will need to remove "method="wget"" from the command below: 
download.file(url, destfile="./data/zip_file.zip", mode="wb", method="wget")
This will work for the first 3 plots but will produce "Error in plot.new() : figure margins too large"
for the 4th plot.

Please when using RStudio, remember to clear all plots by clicking on the "Clear All" option.
I am not sure why the codes work differently depending the tool used.
