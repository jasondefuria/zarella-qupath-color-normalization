Using the QuPath Script
This script will color normalize your images. See HE3.png (before) to HE3_Normalized_Image.tif (after).

1. Setup QuPath and MATLAB per #2 here: https://github.com/qupath/qupath/wiki/Working-with-MATLAB
2. Download the attached zip and unzip to your MATLAB Directory. Find your MATLAB Directory: https://www.mathworks.com/help/matlab/matlab_env/matlab-startup-folder.html
3. Open QuPath
4. Open an image in QuPath (File→ Open) (see Figure 1)
5. Select a Region of Interest using the rectangle tool in QuPath (see Figure 2)
6. Open the Automate menu, and then select “Show script editor” (see Figure 3)
7. Load the “QuPathColorNormalization.groovy” script (or copy it in)
8. With the script editor selected, select the “run” menu (see Figure 4)
9. Select “Run” from the Run menu, and the script should begin. (see Figure 5)
    a.If running, you should see “INFO: Starting parallel pool (parpool) using the 'local' profile …
10. A GUI will load with the selected ROI (see Figure 6)
    a. Use the view to highlight the structures in the thumbnail
    b. Select the values for Lumen, Nuclei, Stroma, and Cytoplasm
      i. You need AT LEAST 1 selection per above structure
    c. When finished with selection, click the “Done” button and move the GUI to the background
      i. In its current iteration, it will not close automatically
11. After selection of color values per structure, the rest of the script will run automatically
12. At the end of the workflow, the first of two dialog boxes will appear to ask where to save the image vectors (see Figure 7).
13. The second dialog box will ask where to save the color normalized image (see Figure 8)
13. Voila, you now have a color normalized image!
