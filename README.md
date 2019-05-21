# ARKit-Stereoscope-Hipparcos (under construction)
Render Hipparcos Catalogue of 119,617 stars with ARKit and SceneKit.

img src="images/1.jpg" width="640"

Apple has updated iOS Swift Playgrounds 3.0 on May 14, 2019. There is now a simple way to turn off Swift Playgrounds logging every objects created during runtime (little boxes that appears on the right side when "Run My Code", useful for inspection and debugging but consume memory).

In Swift Playgrounds 3.0, a "Blank" template will have a switch for turning off logging. Now Playgrounds can add much more objects to a scene!

img src="images/2.jpg" width="640"

# Hardware

Tested on Apple 2018 9.7" iPad (A9 CPU or higher for ARKit).

# Software

Apple Swift Playgrounds 3.0 from iOS App Store. Swift Playgrounds lets kids ages ~4 and Up program their iPad directly to experiment with ARKit and Scenekit.

There is no Blender for iOS and is optional for a tutorial.

https://www.blender.org/

# Installation

With Swift Playgrounds 3.0 update, the file structure has changed from 2.2.

To keep things simple, a source file Contents.swift is available for pasting into Playgrounds. Resources the program require will either be made available or links given. Use "Clone or download" to get zipped file onto an iPad. Unzip file in Apple Files app or a third-party file manager (eg. GoodReader).

Go to https://www.cv.nrao.edu/~bkent/blender/tutorials.html and tutorial "Reading data: Basic ASCII files". Get catalog.zip. It contains two files: hipparcos.blend and catalog.csv.

Open a new "Blank" template in iOS Swift Playgrounds. Copy and paste the texts of Contents.swift.

Press "+" on upper right and select the third icon (folded paper). Insert catalog.csv.

Before "Run My Code", turn off "Enable Results".

The Sun is located (0,0,0) on the RGB axis. All positions of stars are placed relative to this axis.

# How it works

The 20MB catalog.csv contains data on 119,617 stars. Use Blender, hipparcos.blend, and https://www.youtube.com/watch?v=C3u2Gkdgxfw to learn how to read and display catalog.csv in another complimentary environment. We want to extract the HID, ProperName, and X, Y, and Z positions of the stars in Playgrounds.

Fragment of code of how to display the first ASCII line in catalog.csv.

<pre>
import UIKit

let fileurl = Bundle.main.url(forResource: "catalog", withExtension: "csv")
let filecontent = try String(contentsOf: fileurl!,encoding: String.Encoding.utf8)
let line = filecontent.components(separatedBy: "\n")

line.count

line[0]
line[0].components(separatedBy: ",")

let HID = 71683

for i in 2 ... line.count-2 {
    let A = line[i].components(separatedBy: ",")
    if Int(A[1]) == HID {
        print(A)
        break
    }
}
</pre>

With "Enable Results" on.

img src="images/3.jpg" width="640"

Go to https://www.cosmos.esa.int/web/hipparcos/common-star-names and try different HID numbers. Some HID doesn't have a ProperName.

For example, HID 71683 has a name "Rigel Kentaurus A" and a distance 1.34 parsec.

img src="images/4.jpg" width="640"

The rest of Contents.swift is basically the same as ARKit-Stereoscope-67P. Displaying thousands of stars in SceneKit with ARKit is possible with iOS Swift Playgrounds 3.0 update. There is still a memory limit on a 2018 9.7" iPad with 2GB of RAM. The solution to not being able to display all 119,617 stars is to add a variable "parsec" which will only plot stars within certain distance.

# References

https://www.cosmos.esa.int/web/hipparcos/home

https://en.wikipedia.org/wiki/Hipparcos

https://www.cv.nrao.edu/~bkent/blender/thebook.html

https://www.cv.nrao.edu/~bkent/blender/tutorials.html

https://github.com/astronexus/HYG-Database

https://en.wikipedia.org/wiki/Parsec

https://stars.chromeexperiments.com/

https://www.html5rocks.com/en/tutorials/casestudies/100000stars/

https://www.apple.com/ca/swift/playgrounds/

https://developer.apple.com/swift-playgrounds/release-notes/


Copyright (c) 2019 Hartwell Fong
