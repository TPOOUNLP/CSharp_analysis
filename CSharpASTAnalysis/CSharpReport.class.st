Class {
	#name : #CSharpReport,
	#superclass : #Object,
	#instVars : [
		'code_smells'
	],
	#category : #CSharpASTAnalysis
}

{ #category : #accessing }
CSharpReport >> code_smells [
	^ code_smells
]

{ #category : #accessing }
CSharpReport >> code_smells: anObject [
	code_smells := anObject
]

{ #category : #initialization }
CSharpReport >> initialize [ 
	code_smells:= OrderedCollection new.
]
