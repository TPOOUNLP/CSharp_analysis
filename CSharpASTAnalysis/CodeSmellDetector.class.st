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

	self detect: aCompilationNode.
	^ self printResult.
]

{ #category : #detection }
CodeSmellDetector >> detectCodeSmellFromCollection: anAstCollection [
	"Base method to detect code smells from a collection of nodes"

	| text |
	text := WriteStream on: ''.
	anAstCollection
		do: [ :ast |
			text
				nextPutAll: (ast attributes at:#filename);
				nextPut: Character cr;
				nextPutAll: (self detectCodeSmell: ast);
				nextPut: Character cr. ].
	^ text contents
]

{ #category : #private }
CodeSmellDetector >> printResult [
	"Base method to detect code smells from a SmaCC node"

	^ self subclassResponsibility.
]
