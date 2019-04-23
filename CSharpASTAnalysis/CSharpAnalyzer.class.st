Class {
	#name : #CSharpAnalyzer,
	#superclass : #Object,
	#category : #CSharpASTAnalysis
}

{ #category : #parsing }
CSharpAnalyzer class >> parseCSharpProject: aProjectFolder [
	"Parse all the .cs files from a project's folder."

	| work files |
	work := aProjectFolder asFileReference.
	files := work allChildrenMatching: '*.cs'.
	^files collect: [ :each | CSharpParser parseFile: each fullName ].
]
