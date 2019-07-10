"
Abstract visitor class.
It visits the ASTs to detect an specific code smell.

"
Class {
	#name : #CodeSmellDetector,
	#superclass : #CSProgramNodeVisitor,
	#instVars : [
		'filePath'
	],
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
	| report |
	self detect: aCompilationNode.
	filePath:= aCompilationNode filename.
	report:= self printResult.
	self initializeCollections.
	^ report.
]

{ #category : #detection }
CodeSmellDetector >> detectCodeSmellFromCollection: anAstCollection [
	"Base method to detect code smells from a collection of nodes"

	| reports |
	reports := OrderedCollection new.
	reports := anAstCollection
		collect: [ :ast | (self detectCodeSmell: ast) ].
	reports:= reports
		select: [ :report | report csClassName isNotEmpty  ].
	^ reports
]

{ #category : #accessing }
CodeSmellDetector >> filePath [
	^ filePath
]

{ #category : #accessing }
CodeSmellDetector >> filePath: anObject [
	filePath := anObject
]

{ #category : #initialization }
CodeSmellDetector >> initializeCollections [
	"Initialize all the instance variable collections after visiting an AST"
	^ self subclassResponsibility.
]

{ #category : #private }
CodeSmellDetector >> printResult [
	"Base method to detect code smells from a SmaCC node"

	^ self subclassResponsibility.
]
