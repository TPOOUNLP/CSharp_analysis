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

{ #category : #detection }
CSharpAnalysis >> checkMethodCount [
	"Check if any class has more than 30 methods"
	| code_smells method_visitor |
	code_smells := Dictionary new.
	ast_collection do: [ :csUnitNode | 
		csUnitNode declarations do: [ :namespace | 
			namespace declarations do: [ :class |
				method_visitor:= CSDeclarationVisitor new.
				class declarations  do: [ :declaration | 
					declaration acceptVisitor: method_visitor.
				].
				(method_visitor methods size > 1) ifTrue: [ code_smells at: class name put: 'Too many methods' ]
			].
		].
	].
	^ code_smells.
]
