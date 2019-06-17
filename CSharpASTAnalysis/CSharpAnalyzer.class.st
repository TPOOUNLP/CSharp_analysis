"
A CSharp Project already parsed with the project manager.
The ASTs of the project are stored in 'ast_collection'.
"
Class {
	#name : #CSharpAnalyzer,
	#superclass : #Object,
	#instVars : [
		'detectors',
		'astCollection'
	],
	#category : #CSharpASTAnalysis
}

{ #category : #adding }
CSharpAnalyzer >> addDetector: aCodeSmellDetector [
	"Add a code smell detector"
	
	self detectors add: aCodeSmellDetector.
]

{ #category : #accessing }
CSharpAnalyzer >> astCollection [
	^ astCollection
]

{ #category : #accessing }
CSharpAnalyzer >> astCollection: anAstCollection [
	astCollection := anAstCollection.
]

{ #category : #detection }
CSharpAnalyzer >> detect [
	"Detect all the code smells loaded into detectors. Returns a collection of reports."
	
	^self detectors collect: [ :d | d detectCodeSmellFromCollection: self astCollection ].
]

{ #category : #accessing }
CSharpAnalyzer >> detectors [
	^ detectors
]

{ #category : #accessing }
CSharpAnalyzer >> detectors: aDetectorsCollection [
	detectors := aDetectorsCollection.
]

{ #category : #initialization }
CSharpAnalyzer >> initialize [ 

	self detectors: OrderedCollection new.
]
