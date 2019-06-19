Class {
	#name : #CSDetectorIdentifierTooLong,
	#superclass : #CodeSmellDetector,
	#instVars : [
		'ids',
		'size'
	],
	#category : #CSharpASTAnalysis
}

{ #category : #detection }
CSDetectorIdentifierTooLong >> detectCodeSmell: aCompilationNode [
	"Base method to detect code smells from a SmaCC node"
	ids := OrderedCollection new.
	self detect: aCompilationNode.
	^ self printResult.
]

{ #category : #'as yet unclassified' }
CSDetectorIdentifierTooLong >> idSize [

	^size
]

{ #category : #'as yet unclassified' }
CSDetectorIdentifierTooLong >> idSize: anObject [

	size := anObject
]

{ #category : #initialization }
CSDetectorIdentifierTooLong >> initialize [

	ids := OrderedCollection new.
	size := 30.
]

{ #category : #private }
CSDetectorIdentifierTooLong >> printResult [

	| text |
	text := WriteStream on: ''.
	(ids select: [ :id | id isNil not. ]) 
		do: [ :id | text nextPutAll: (id printMessageTooLong: size);
						nextPut: Character cr. ].
	^ text contents.
]

{ #category : #generated }
CSDetectorIdentifierTooLong >> visitClassDeclaration: aClassDeclaration [ 
	
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
