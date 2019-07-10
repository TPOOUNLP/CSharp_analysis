"
I'm a CodeSmellDetector that detects code smell of an identifier being too long.
"
Class {
	#name : #CSDetectorIdentifierTooLong,
	#superclass : #CodeSmellDetector,
	#instVars : [
		'ids',
		'size',
		'currentClass'
	],
	#category : #CSharpASTAnalysis
}

{ #category : #accesing }
CSDetectorIdentifierTooLong >> idSize [

	^size
]

{ #category : #accesing }
CSDetectorIdentifierTooLong >> idSize: anObject [

	size := anObject
]

{ #category : #initialization }
CSDetectorIdentifierTooLong >> initialize [

	ids := OrderedCollection new.
	size := 30.
]

{ #category : #initialization }
CSDetectorIdentifierTooLong >> initializeCollections [
	ids := OrderedCollection new.
]

{ #category : #private }
CSDetectorIdentifierTooLong >> printResult [
	| text report |
	report := CodeSmellReport new.
	report name: 'Identifier Too Long'.
	report csFilePath: filePath.
	(ids reject: [ :id | id isNil ])
		do: [ :id | 
			text := WriteStream on: ''.
			text nextPutAll: (id printMessageTooLong: size).
			report csClassName: currentClass.
			report addDetection: text contents ].
	^ report
]

{ #category : #generated }
CSDetectorIdentifierTooLong >> visitClassDeclaration: aClassDeclaration [ 
	
	currentClass := aClassDeclaration name value.
	(aClassDeclaration name value size > size)
		ifTrue: [ids add: (CSIdentifier new withName: aClassDeclaration name value location: ('class ', aClassDeclaration name value))].
	
	aClassDeclaration declarations do: [ :md | md acceptVisitor: self ].
]

{ #category : #generated }
CSDetectorIdentifierTooLong >> visitLocalVariableDeclaration: aLocalVariableDeclaration [ 

	((aLocalVariableDeclaration declarators at: 1) name identifierToken value size > size)
	ifTrue: [ 
		ids add: (CSIdentifier new 
			withName: (aLocalVariableDeclaration declarators at: 1) name identifierToken value 
			location: ('a local variable of method ', aLocalVariableDeclaration parent parent parent parent header name value))
	 ]
]

{ #category : #generated }
CSDetectorIdentifierTooLong >> visitMethodDeclaration: aMethodDeclaration [

	(aMethodDeclaration header name value size > size)
	ifTrue: [ 
		ids add: (CSIdentifier new withName: aMethodDeclaration header name value location: ('method ', aMethodDeclaration header name value))
	].
	
	ids addAll: (aMethodDeclaration header parameters collect: [ :p | 
		(p name value size > size)
		ifTrue: [ 
			(CSIdentifier new 
			withName: p name value 
			location: ('a parameter of method ', aMethodDeclaration header name value))
		 ]
	]).
	
	aMethodDeclaration body block statements do: [ :st | 
		st acceptVisitor: self. 
	].
]
