"
A visitor for declarations of a CSharp program.
"
Class {
	#name : #CSDeclarationVisitor,
	#superclass : #CSProgramNodeVisitor,
	#instVars : [
		'methods'
	],
	#category : #CSharpASTAnalysis
}

{ #category : #initialization }
CSDeclarationVisitor >> initialize [
	methods := OrderedCollection new.
]

{ #category : #accessing }
CSDeclarationVisitor >> methods [
	^ methods
]

{ #category : #accessing }
CSDeclarationVisitor >> methods: anObject [
	methods := anObject
]

{ #category : #generated }
CSDeclarationVisitor >> visitMethodDeclaration: aMethodDeclaration [
	methods add:aMethodDeclaration.
]
