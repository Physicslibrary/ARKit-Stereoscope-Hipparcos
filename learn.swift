/*
 
 ARKit-Stereoscope-Hipparcos
 
 https://physicslibrary.github.io/ARKit-Stereoscope-Hipparcos/
 
 MIT License
 
 Copyright (c) 2019 Hartwell Fong

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

 
 
 May 21, 2019.
 
 Hardware:
 
 Tested on Apple 2018 9.7" iPad (A9 CPU or higher for ARKit)
 
 The OWL Stereoscope Viewer is from The London Stereoscopic Ltd
 
 https://www.londonstereo.com
 
 Thank to Dr. Brian May for developing an amazingly simple tool that can be used with the 9.7" iPad.
 
 Software:
 
 Apple iOS Swift Playgrounds 3.0
 ARKit and SceneKit (set up scene, read 3D files, attact a virtual camera for lefteye to ARKit iPad 
 camera righteye to make a stereoscope, 6DOF tracking).
 
 https://www.apple.com/ca/swift/playgrounds/
 
 If frame rate < 60Hz, hold iPad still, press HOME button, return to Swift Playgrounds.
 
 This playground doesn't look for a flat plane to put virtual objects on, instead the initial position 
 of the iPad is the world origin when "Run My Code" is pressed.
 
 All virtual objects are positioned and oriented according to this world origin 
 (with righteye.debugOptions on, the world origin is an XYZ or RGB axis)
 
 */


import ARKit
import PlaygroundSupport

let fileurl = Bundle.main.url(forResource: "catalog", withExtension: "csv")

var filecontent = try String(contentsOf: fileurl!,encoding: String.Encoding.utf8)
var line = filecontent.components(separatedBy: "\n")

var righteye = ARSCNView()
righteye.scene = SCNScene()
righteye.scene.background.contents = UIColor.black
righteye.showsStatistics = true  // comment out to turn off

var lefteye = SCNView()
lefteye.scene = righteye.scene
lefteye.showsStatistics = true  // comment out to turn off

let config = ARWorldTrackingConfiguration()
righteye.session.run(config)

 righteye.debugOptions = [
    //ARSCNDebugOptions.showFeaturePoints,
 ARSCNDebugOptions.showWorldOrigin  // comment out to turn off
 ]

/*
 skip the first two lines and stop "Index out of range" with "for i in 2 ... line.count - 2"
 119617 is the total number of stars in catalog.csv
 A[1] = HID
 A[6] = ProperName to identify stars
 limit stars by A[9] = Distance (parsec)
 A[17] = X
 A[18] = Y
 A[19] = Z
 */

for i in 1 ... line.count - 2 {
    
    let A = line[i].components(separatedBy: ",")
    
    let parsec = 50.0  // 1 parsec = 3.2616 light-years
    
    if Double(A[9])! < parsec {
        
        let sphere = SCNSphere(radius: 0.01)
        let node = SCNNode(geometry: sphere)
        node.position = SCNVector3(Float(A[17])!/5,Float(A[18])!/5,Float(A[19])!/5)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
        
        let text = SCNText(string: A[6], extrusionDepth: 0.1)
        text.flatness = 0.01
        let textnode = SCNNode(geometry: text)
        textnode.scale=SCNVector3(0.001,0.001,0.001)
        textnode.position = SCNVector3(Float(A[17])!/5,Float(A[18])!/5,Float(A[19])!/5-0.01)
        textnode.eulerAngles = SCNVector3(0, Float.pi/2, 0)
        textnode.geometry?.firstMaterial?.diffuse.contents = UIColor.cyan
        
        righteye.scene.rootNode.addChildNode(node)
        righteye.scene.rootNode.addChildNode(textnode)
    }
}

// Coded for Owl Stereoscopic Viewer
// Use stereoscope with a 2018 9.7" iPad

var ipd = -0.064 // interpupillary distance (meter)
var cameraNode = SCNNode()  // make a camera for left eye
let camera = SCNCamera()
camera.xFov = 39  // camera.* depends on righteye.frame
camera.yFov = 50
camera.zFar = 1000
camera.zNear = 0.01
cameraNode.camera = camera
cameraNode.position = SCNVector3(ipd,0,0)
righteye.pointOfView?.addChildNode(cameraNode)

lefteye.pointOfView = cameraNode

lefteye.isPlaying = true

var imageView = UIImageView()
lefteye.frame = CGRect(x: 0, y: 0, width: 344, height: 380)
imageView.addSubview(lefteye)

righteye.frame = CGRect(x: 344, y: 0, width: 344, height: 380)
imageView.addSubview(righteye)

PlaygroundPage.current.wantsFullScreenLiveView = true
PlaygroundPage.current.liveView = imageView

// in last line, change imageView to righteye for one view (no stereoscope)

