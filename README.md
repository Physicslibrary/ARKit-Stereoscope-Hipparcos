# ARKit-Stereoscope-Hipparcos

Explore Hipparcos Catalogue of 119,617 stars with ARKit and SceneKit.

<img src="images/1.jpg" width="640">


<img src="images/2.jpg" width="640">

Apple has updated iOS Swift Playgrounds to 3.0 on May 14, 2019. There is now a simple way to turn off Swift Playgrounds logging every objects created during runtime (little boxes that appears on the right side when "Run My Code", useful for inspection and debugging but consume memory).

In Swift Playgrounds 3.0, a "Blank" template has a switch "Enable Results" (next to "Run My Code"). Now Playgrounds can add thousands of spheres in a scene!

<img src="images/3.jpg" width="640">

# Hardware

Tested on Apple 2018 9.7" iPad (A9 CPU or higher for ARKit).

The OWL Stereoscopic Viewer(£15.00) from [The London Stereoscopic Company Ltd](https://www.londonstereo.com/)

https://github.com/Physicslibrary/ARKit-Stereoscope-CDEM explains how to use the stereoscope with a 9.7" iPad.

# Software

Apple Swift Playgrounds 3.0 from iOS App Store. Swift Playgrounds lets kids ages >4 program their iPad directly to experiment with ARKit and Scenekit.

There is no Blender for iOS and is optional for a tutorial.

https://www.blender.org/

# Installation

With Swift Playgrounds 3.0 update, the file structure has changed from 2.2.

To keep things simple, a source file learn.swift is available for pasting into Playgrounds. Resources for the program will either be made available or links provided.

Go to https://www.cv.nrao.edu/~bkent/blender/tutorials.html and tutorial "Reading data: Basic ASCII files". Get catalog.zip. It contains two files: hipparcos.blend and catalog.csv. Unzip file in Apple Files app or a third-party file manager (eg. GoodReader).

Open a new "Blank" template in iOS Swift Playgrounds. Copy and paste the texts of learn.swift.

Press "+" on upper right and select the third icon (folded paper). Insert catalog.csv.

Before "Run My Code", turn off "Enable Results".

The Sun is located (0,0,0) on the RGB axis. All positions of stars are placed relative to this axis.

This playground doesn't look for a flat plane to put virtual objects on, instead the initial position of the iPad is the world origin when "Run My Code" is pressed.

Virtual objects are positioned and oriented according to this world origin (with righteye.debugOptions on, the world origin is the XYZ or RGB axis).

If frame rate <60Hz, hold iPad still, press iPad HOME button, return to Swift Playgrounds.

# How it works

The 20MB catalog.csv contains data on 119,617 stars. Use Blender, hipparcos.blend, and https://www.youtube.com/watch?v=C3u2Gkdgxfw to learn how to read and display catalog.csv in another complimentary environment. 

<img src="images/6.png" width="640">

We want to extract HID, ProperName, and X, Y, and Z positions of the stars in Playgrounds.

"filecontent" reads catalog.csv. Each line is separated by "\n". In each line, values like HID, ProperName, X, Y, and Z are separated by ",".

<pre>
import UIKit

let fileurl = Bundle.main.url(forResource: "catalog", withExtension: "csv")
let filecontent = try String(contentsOf: fileurl!,encoding: String.Encoding.utf8)
let line = filecontent.components(separatedBy: "\n")

line.count

line[0]
line[0].components(separatedBy: ",")

let HID = 71683

for i in 2 ... line.count - 2 {
    let A = line[i].components(separatedBy: ",")
    if Int(A[1]) == HID {
        print(A)
        break
    }
}
</pre>

With "Enable Results" on, "Run My Code". When finished, "line.count" is 119619 which equals 119617 stars plus the first two lines. The picture below shows "line[0].components(separatedBy: ",")".

<img src="images/4.png" width="640">

Go to https://www.cosmos.esa.int/web/hipparcos/common-star-names and try different HID numbers. Some HID doesn't have a ProperName.

For example, HID 71683 is named "Rigel Kentaurus A" and its distance is 1.34 parsec. Rigel Kentaurus A is part of the triple star system Alpha Centauri that is the nearest star system to our solar system.

<img src="images/5.png" width="640">

The rest of learn.swift is basically the same as the one in ARKit-Stereoscope-67P. Displaying thousands of stars in SceneKit is possible with Playgrounds 3.0 update. There is still a memory limit on a 2018 9.7" iPad with 2GB of RAM. A solution to not being able to display all 119,617 stars is to add a variable "parsec" which will only plot stars within a certain distance.

# References

https://www.cosmos.esa.int/web/hipparcos/home

http://sci.esa.int/star_mapper/

http://sci.esa.int/hipparcos/58154-star-mapper/

https://en.wikipedia.org/wiki/Hipparcos

https://en.wikipedia.org/wiki/Parsec

Brian R. Kent, 3D Scientific Visualization with Blender, Morgan & Claypool Publishers (2015).

https://www.cv.nrao.edu/~bkent/blender/thebook.html

https://www.cv.nrao.edu/~bkent/blender/tutorials.html

https://stars.chromeexperiments.com/

https://www.html5rocks.com/en/tutorials/casestudies/100000stars/

https://github.com/astronexus/HYG-Database

https://www.apple.com/ca/swift/playgrounds/

https://developer.apple.com/swift-playgrounds/release-notes/

<br><br>Copyright (c) 2019 Hartwell Fong
