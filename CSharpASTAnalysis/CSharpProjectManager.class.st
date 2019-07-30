"
A CSharp project manager.
It parses a project and make AST trees of every CSharp file.

--
Usage example:
analyzer:= CProjectManager parseCSharpProject: 'myFiles/CSharpProject/'.

To save the parsing to a file (with STON):
analyzer saveParsingTo: 'Analyser.ston' .

To load the parsing file: 
analyzer loadParsing: 'Analyser.ston'.
"
Class {
	#name : #CSharpProjectManager,
	#superclass : #Object,
	#instVars : [
		'cSharpAnalyzer',
		'reports'
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

	reports addAll: cSharpAnalyzer detect.
	^ reports reject: [ :report | report isEmpty ].
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
	reports:= OrderedCollection new.
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
	work exists ifFalse: [ self error: 'The specified directory does not exist.' ].
	files := work allChildrenMatching: '*.cs'.
	files isEmpty ifTrue: [ self error: 'The project directory does not contain valid C# files to parse.' ].
	self astCollection: (files collect: [ :each |
		CSharpParser 
			parse: (each contents) 
			onError: [ :desc :tag | 
				| rep |
				rep := CodeSmellReport new.
				rep csFilePath: each fullName.
				rep name: 'Error while parsing file'.
				rep detections: desc.
				self reports add: rep.
				CSCompilationUnitNode new. ]
	]).
	
	^work := work asString.
]

{ #category : #accessing }
CSharpProjectManager >> reports [
	^ reports
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

{ #category : #detection }
CSharpProjectManager >> saveReportsAsJson: aJsonFilePath [
	| json |
	json := WriteStream on: ''.
	json
		nextPutAll: '[';
		nextPut: Character cr.
	reports
		keysAndValuesDo: [ :j :csreports | 
			csreports
				keysAndValuesDo: [ :i :report | 
					report toJSON isEmpty
						ifFalse: [ json nextPutAll: report toJSON.
							((i = csreports size) and: (j + 1 = reports size))
								ifFalse: [ json nextPutAll: ',' ].
							json nextPut: Character cr ] ] ].
	json nextPutAll: ']'.
	"Save the stream into the file passed as a parameter"
	(FileSystem disk workingDirectory / aJsonFilePath) writeStream
		nextPutAll: json contents;
		close.
]
