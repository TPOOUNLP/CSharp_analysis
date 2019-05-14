"
A CSharp Project already parsed with the analyzer.
The ASTs of the project are stored in 'ast_collection'.
"
Class {
	#name : #CSharpAnalysis,
	#superclass : #Object,
	#instVars : [
		'ast_collection',
		'detectors'
	],
	#category : #CSharpASTAnalysis
}

{ #category : #adding }
CSharpAnalysis >> addDetector: aCodeSmellDetector [
	"Add a code smell detector"
	
	self detectors add: aCodeSmellDetector.
	^self
]

{ #category : #accessing }
CSharpAnalysis >> ast_collection [
	^ ast_collection
]

{ #category : #accessing }
CSharpAnalysis >> ast_collection: anObject [
	ast_collection := anObject
]

{ #category : #detection }
CSharpAnalysis >> checkMethodCount [
	"Check if any class has more than 30 methods"
	| v |
	v:= CSMethodLength new.
	^ (v detectCodeSmellFromCollection: ast_collection).
]

{ #category : #'as yet unclassified' }
CSharpAnalysis >> detect [
	"Detect all the code smells loaded into detectors. Returns a collection of reports."
	self ast_collection do: [ :a | self detectors do: [ :d | a acceptVisitor: d ] ].
	^self detectors collect: [ :d | d detectCodeSmellFromCollection: self ast_collection ].
]

{ #category : #accessing }
CSharpAnalysis >> detectors [
	^ detectors
]

{ #category : #accessing }
CSharpAnalysis >> detectors: anObject [
	detectors := anObject
]

{ #category : #initialization }
CSharpAnalysis >> initialize [ 

	self detectors: OrderedCollection new.
	^self
]
