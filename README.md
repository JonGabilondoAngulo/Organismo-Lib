# Organismo for Mac
Organismo framework for Mac be injected into Mac Apps to explore them at runtime. For a good technical background you could read https://medium.com/@jon.gabilondo.angulo_7635/how-to-inject-code-into-mach-o-apps-part-i-17ed375f736e

To inject it into a Mac App:

$ DYLD_INSERT_LIBRARIES=/path_to/Organismo-mac.framework/Versions/A/Organismo-mac /Applications/Calculator.app/Contents/MacOS/Calculator

# Organismo for iOS
Organismo is a framework to bypass all vital systems of iOS Apps in order to retrieve information and simulate any condition in real life, from network conditions to motion and location. It works in conjuction with [Organismo-Desktop](https://github.com/JonGabilondoAngulo/Organismo-Desktop) as a visualizer and generator of virtual scenerarios.

## Quick Start
This repository comes with sample Apps for a quick start. Open the Organismo workspace in this repository. Select one of the Sample Apps, change the Team & Certificate and run it on your device. The App will be running with Organismo bypass ready to comunicate with Organismo-Desktop.

## Build
Build the Organismo framework target from the Xcode workspace in this repository. You may take the the framework already compiled from "dist" subfolder.

## Compiling Apps with Organismo-iOS-Driver
The App must embed the Organismo-iOS-Driver framework. This means that the framework must be copied to the Apps Frameworks folder. Xcode provides an easy way to embed a framework. Look in the target's General section.

## Injecting Organismo-iOS-Driver into Compiled Apps
It is possible to inject the framework into already compiled Apps (.ipa files). Look into [bypass](https://github.com/JonGabilondoAngulo/bypass) repository.

## Connecting to Organismo-Desktop
Organismo-iOS-Driver framework opens a port in 5567 to communicate. Use [Organismo-Desktop](https://github.com/JonGabilondoAngulo/Organismo-Desktop) to connect to the App.
