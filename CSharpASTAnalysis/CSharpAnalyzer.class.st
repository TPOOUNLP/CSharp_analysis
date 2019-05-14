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
	#name : #CSharpAnalyzer,
	#superclass : #Object,
	#instVars : [
		'cSharpAnalysis'
	],
	#category : #CSharpASTAnalysis
}

{ #category : #parsing }
CSharpAnalyzer class >> parseProject: aProjectFolder [
	"Parse all the .cs files from a project's folder."
	 ^ (self new)
			parseCSharpProject: aProjectFolder;
			yourself.
]

{ #category : #accessing }
CSharpAnalyzer >> ast_collection [
	^ cSharpAnalysis ast_collection
]

{ #category : #accessing }
CSharpAnalyzer >> ast_collection: anObject [
	cSharpAnalysis ast_collection: anObject.
]

{ #category : #accessing }
CSharpAnalyzer >> cSharpAnalysis [
	^ cSharpAnalysis
]

{ #category : #accessing }
CSharpAnalyzer >> cSharpAnalysis: anObject [
	cSharpAnalysis := anObject
]

{ #category : #'as yet unclassified' }
CSharpAnalyzer >> detectCodeSmells [
	"Detects code smells from the loaded project. Returns a collection of reports."

	^self cSharpAnalysis detect.
]

{ #category : #initialization }
CSharpAnalyzer >> initialize [
	cSharpAnalysis := CSharpAnalysis new.
]

{ #category : #'file in/out' }
CSharpAnalyzer >> loadParsing: aFilePath [
	| working_dir fstream |
	working_dir := FileSystem disk workingDirectory.
	fstream := (working_dir/aFilePath) readStream.
	cSharpAnalysis:= (STON fromString: (fstream contents)).
	fstream close.
]

{ #category : #parsing }
CSharpAnalyzer >> parseCSharpProject: aProjectFolder [
	"Parse all the .cs files from a project's folder."

	| work files |
	work := aProjectFolder asFileReference.
	files := work allChildrenMatching: '*.cs'.
	cSharpAnalysis ast_collection: (files collect: [ :each | CSharpParser parseFile: each fullName ]).
]

{ #category : #'file in/out' }
CSharpAnalyzer >> saveParsingTo: aFilePath [
	| ston fstream workingDir |
	ston := STON toStringPretty: self cSharpAnalysis  .
	workingDir := FileSystem disk workingDirectory.
	fstream := (workingDir / aFilePath) writeStream.
	fstream nextPutAll: ston.
	fstream close
]
