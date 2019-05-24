"
A CSharp project analyzer.
It parses a project and make AST trees of every CSharp file.

--
Usage example:
analyzer:= CSharpAnalyzer parseProject: 'myFiles/CSharpProject/'.

To save the parsing to a file (with STON):
analyzer saveParsingTo: 'Analyser.ston' .

To load the parsing file: 
analyzer loadParsing: 'Analyser.ston'.
"
Class {
	#name : #CSharpProjectManager,
	#superclass : #Object,
	#instVars : [
		'cSharpAnalyzer'
	],
	#category : #CSharpASTAnalysis
}

{ #category : #parsing }
CSharpProjectManager class >> parseProject: aProjectFolder [
	"Parse all the .cs files from a project's folder."
	 ^ (self new)
			parseCSharpProject: aProjectFolder;
			yourself.
]

{ #category : #accessing }
CSharpProjectManager >> addDetector: aCodeSmellDetector [
	"Add a code smell detector"
	
	cSharpAnalyzer addDetector: aCodeSmellDetector.
]

{ #category : #accessing }
CSharpProjectManager >> astCollection [
	^ cSharpAnalyzer astCollection
]

{ #category : #accessing }
CSharpProjectManager >> astCollection: anAstCollection [
	cSharpAnalyzer astCollection: anAstCollection.
]

{ #category : #detection }
CSharpProjectManager >> detectCodeSmells [
	"Detects code smells from the loaded project. Returns a collection of reports."

	^cSharpAnalyzer detect.
]

{ #category : #accessing }
CSharpProjectManager >> detectors [
	^ cSharpAnalyzer detectors
]

{ #category : #accessing }
CSharpProjectManager >> detectors: aDetectorsCollection [
	cSharpAnalyzer detectors: aDetectorsCollection.
]

{ #category : #initialization }
CSharpProjectManager >> initialize [
	cSharpAnalyzer := CSharpAnalyzer new.
]

{ #category : #'file in/out' }
CSharpProjectManager >> loadParsing: aFilePath [
	| working_dir fstream |
	working_dir := FileSystem disk workingDirectory.
	fstream := (working_dir/aFilePath) readStream.
	cSharpAnalyzer := (STON fromString: (fstream contents)).
	fstream close.
]

{ #category : #parsing }
CSharpProjectManager >> parseCSharpProject: aProjectFolder [
	"Parse all the .cs files from a project's folder."

	| work files |
	work := aProjectFolder asFileReference.
	files := work allChildrenMatching: '*.cs'.
	self astCollection: (files collect: [ :each | CSharpParser parseFile: each fullName ]).
]

{ #category : #'file in/out' }
CSharpProjectManager >> saveParsingTo: aFilePath [
	| ston fstream workingDir |
	ston := STON toStringPretty: cSharpAnalyzer.
	workingDir := FileSystem disk workingDirectory.
	fstream := (workingDir / aFilePath) writeStream.
	fstream nextPutAll: ston.
	fstream close
]
