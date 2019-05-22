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
CodeSmellDetector >> detectCodeSmell: aCompilationNode [
	"Base method to detect code smells from a SmaCC node"

	self subclassResponsibility.
]

{ #category : #detection }
CodeSmellDetector >> detectCodeSmellFromCollection: anAstCollection [
	"Base method to detect code smells from a collection of nodes"

	| code_smells |
	code_smells := WriteStream on: ''.
	anAstCollection
		do: [ :ast |
			code_smells
				nextPutAll: (ast attributes at:#filename);
				nextPut: Character cr;
				nextPutAll: (self detectCodeSmell: ast);
				nextPut: Character cr. ].
	^ code_smells
]
