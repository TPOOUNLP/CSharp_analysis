# CSharp_analysis
This project is aimed to create analysis reports of C# code using Abstract Syntax Trees created with SmaCC by John Brant.
We aspire to detect code smells in C# Projects and help the developer fix them.

### Requirements:
#### STON:
https://github.com/svenvc/ston

#### SmaCC
https://github.com/j-brant/SmaCC

#### Teapot
https://github.com/zeroflag/Teapot

---


## Basic usage
---
#### Parse Project
Initialize and parse a project to generate the AST with the CSharpProjectManager class.
```smalltalk
"Parse a Project"
pm:= CSharpProjectManager new.
pm parseCSharpProject: 'pathTo/HelloWorld'.
```

#### Load/Save Parsing
Save the parsed project with its AST into a ston file and load it whenever you want.
```smalltalk
"Save"
pm saveParsingTo: '/home/naparicio/Pharo/files/analysis.ston'.
"Load"
pm loadParsing: '/home/naparicio/Pharo/files/analysis.ston'.
```

### Detect Code Smells
To detect code smells in your project you need to add detectors to the project manager.
Each detector role is to find an specific code smell in the project he is added to.
To detect a code smell you need to instanciate the code smell detector and then add it to the project manager.
```smalltalk
"Create detector of Too Many Methods in a class code smell"
detector := CSDetectorTooManyMethods new.
"Specify if you want, how many methods in a class is too many for the detector to catch"
detector length: 15.
"Add detector"
pm addDetector: detector.
```
You now have a Project Manager with one code smell detector.
To analyze and detect the code smell in your project simply call this:
```smalltalk
pm detectCodeSmells.
```
This will give you a text report of what code smells the detector/s found in your project.

## Start server API services for Electron
To start the server run:
```smalltalk
|csaAPI|

csaAPI := CSharpAnalysisAPI new.
csaAPI startServer.
```