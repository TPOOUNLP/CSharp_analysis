"
Abstract visitor class.
It visits the ASTs to detect an specific code smell.

"
Class {
	#name : #CodeSmellDetector,
	#superclass : #CSProgramNodeVisitor,
	#category : #CSharpASTAnalysis
}

{ #category : #detection }
CodeSmellDetector >> detect: aCompilationNode [
	"Base method to detect a code smell, you can overwrite it if you need it"

	aCompilationNode acceptVisitor: self.
]

{ #category : #detection }
CodeSmellDetector >> detectCodeSmell: aCompilationNode [
	"Base method to detect code smells from a SmaCC node"
	self initializeCollections.
	self detect: aCompilationNode.
	^ self printResult.
]

{ #category : #detection }
CodeSmellDetector >> detectCodeSmellFromCollection: anAstCollection [
	"Base method to detect code smells from a collection of nodes"

	| reports |
	reports := OrderedCollection new.
	reports:= anAstCollection collect: [ :ast | (self detectCodeSmell: ast). ].
	^ reports.
]

{ #category : #private }
CodeSmellDetector >> initializeCollections [
	"Method to initialize all instance variable of the collections type"

	^ self subclassResponsibility.
]

{ #category : #private }
CodeSmellDetector >> printResult [
	"Base method to detect code smells from a SmaCC node"

	^ self subclassResponsibility.
]
