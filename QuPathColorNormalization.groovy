/**
 * Script to Pass QuPath to Color Normalization in Workflow. Must use RGB image at input, but can be of any fileformat that QuPath Supports
 * QuPath detection objects.
 *
 *
 * MATLAB functions written by Dr. Mark Zarella and Dr. David Breen
 *
 * This requires the MATLAB Engine, available with MATLAB R2016b or later,
 * and setup as described at https://github.com/qupath/qupath/wiki/Working-with-MATLAB
 *
 * NOTE: You will also need the Parallel Computing Toolbox installed for MATLAB, or if you do not have it, comment out the lines in the MATLAB scripts. (AKA- change ('UseParallel',true) to ('UseParallel',false))
 *
 * @author Jason DeFuria (jay@jasondefuria.com)
 * Special thanks to Laurence Liss and Pete Bankhead for their support when helping to troubleshoot.
 */

import qupath.lib.classifiers.PathClassificationLabellingHelper
import qupath.lib.common.ColorTools
import qupath.lib.objects.classes.PathClass
import qupath.lib.objects.classes.PathClassFactory
import qupath.lib.scripting.QP
import qupath.extension.matlab.QuPathMATLABExtension
import com.mathworks.matlab.types.Struct
import qupath.lib.images.tools.BufferedImageTools
import qupath.lib.objects.PathObject
import qupath.lib.objects.PathTileObject
import qupath.lib.regions.RegionRequest
import qupath.lib.roi.PolygonROI
import qupath.lib.scripting.QP
import qupath.extension.matlab.QuPathMATLABExtension

// For Save Dialog at End
import java.io.File;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.Callable;
import java.util.concurrent.CountDownLatch;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javafx.application.Platform;
import javafx.beans.property.ObjectProperty;
import javafx.beans.property.SimpleObjectProperty;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Insets;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.BorderPane;
import javafx.stage.DirectoryChooser;
import javafx.stage.FileChooser;
import javafx.stage.FileChooser.ExtensionFilter;
import qupath.lib.gui.helpers.dialogs.DialogHelper;
import javafx.stage.Window;

import java.awt.image.BufferedImage


// Import the helper class
QuPathMATLAB = this.class.classLoader.parseClass(QuPathMATLABExtension.getQuPathMATLABScript())

// Get the MATLAB engine
QuPathMATLAB.getEngine(this)
try {

    def imageData = QP.getCurrentImageData()
double downsample = 1
    BufferedImage img;
    def roi = QP.getSelectedROI()
    if (roi != null) {
        img = imageData.getServer().readBufferedImage(RegionRequest.createInstance(imageData.getServerPath(), downsample, roi))
    } else
        img = imageData.getServer().getBufferedThumbnail(1000, -1, 0)

    // Put RGB version of QuPath image & calibration data into MATLAB workspace
    if (roi == null) {
    //println("Error running script: No ROI Selected")
    throw new Exception("No ROI Selected")
      
    }
    else {
       def imgMask = BufferedImageTools.createROIMask(img.getWidth(), img.getHeight(), roi, roi.getBoundsX(), roi.getBoundsY(), downsample)
        QuPathMATLAB.putQuPathImageStruct("smimg", img, imgMask, roi.getBoundsX(), roi.getBoundsY(), downsample, true)
    }
    // Take Image and Move Into MATLAB Color Assign Manual function. Function should load GUI, and you must select at least 1 value each for Nuclei, Stroma, Lumen, and Cytoplasm. 
      QuPathMATLAB.eval("loadedimage = smimg.im;")
      QuPathMATLAB.eval("[idx, lumen, nuclei, stroma, cytoplasm] = colorassign_manual(loadedimage)")

       // Print a message so we know we reached the end of the first function
    println("Color Assign Manual Complete")

    // Take Image and outputted Lumen, Nuclei, Stroma, and Cytoplasm variables and Move Into MATLAB Train Classifier function.
      QuPathMATLAB.eval("classifier = train_classifier(loadedimage,idx,lumen,nuclei,stroma,cytoplasm)")

       // Print a message so we know we reached the end of the second function
    println("Train Classifier Function Complete")
 
// Load whole image and apply color assign to it
lgimg = imageData.getServer().getBufferedThumbnail(1000, -1, 0)
double downsampleH = (double)imageData.getServer().getHeight()/(double)lgimg.getHeight()
        double downsampleW = (double)imageData.getServer().getWidth()/(double)lgimg.getWidth()
        double downsampleActual = Math.max(downsampleH, downsampleW)
QuPathMATLAB.putQuPathImageStruct("largeimg", lgimg, null, 0, 0, downsampleActual, true)
QuPathMATLAB.eval("largeimg = largeimg.im;")

// Take Image and Move Into MATLAB Color Classifier
QuPathMATLAB.eval("[classified] = color_classify(largeimg, classifier);")
       // Print a message so we know we reached the end of the third function
    println("Color Classifier Function Complete")


// Take Image and Move Into MATLAB Color Normalize

       QuPathMATLAB.eval("load('target.mat')")
       QuPathMATLAB.eval("[rgb,vectors] = color_normalize(largeimg, target, classified);")
          // Print a message so we know we reached the end of the fourth function
    println("Color Normalize Function Complete")

// Save Vector that Image was transformed
file1 = getQuPath().getDialogHelper(). promptToSaveFile("Save Image Vector ", null, "Image_Vector", null, "mat")
QuPathMATLAB.eval("save('" + file1.toString() + "','vectors')")

// Take Color Normalized image and Save Output to User Selected Location
file2 = getQuPath().getDialogHelper(). promptToSaveFile("Save Normalized Image", null, "Normalized_Image", null, "tif")
QuPathMATLAB.eval("imwrite(rgb,'" + file2.toString() + "')")

    // Print a message so we know we know the image was saved to the Present Working Directory in MATLAB
    println("Image Saved")
    
    // Print a message so we know we reached the end
    print("Complete Color Classify and Normalize Process Complete")
} catch (Exception e) {
    println("Error running script: " + e.getMessage())
} finally {
    QuPathMATLAB.close()
}