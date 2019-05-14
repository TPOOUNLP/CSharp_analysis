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
CodeSmellDetector >> detectCodeSmellFromCollection: aCollection [
	"Base method to detect code smells from a collection of nodes"

	self subclassResponsibility.
]
