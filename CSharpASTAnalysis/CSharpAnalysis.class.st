"
A CSharp Project already parsed with the analyzer.
The ASTs of the project are stored in 'ast_collection'.
"
Class {
	#name : #CSharpAnalysis,
	#superclass : #Object,
	#instVars : [
		'ast_collection'
	],
	#category : #CSharpASTAnalysis
}

{ #category : #accessing }
CSharpAnalysis >> ast_collection [
	^ ast_collection
]

{ #category : #accessing }
CSharpAnalysis >> ast_collection: anObject [
	ast_collection := anObject
]
