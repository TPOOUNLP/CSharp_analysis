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
CSDetectorIdentifierTooLong >> detectCodeSmell: aCSCompilationUnitNode [

	ids := OrderedCollection new.
	aCSCompilationUnitNode acceptVisitor: self.
	^ids collect: [ :id | (id length > size) ifTrue:[ id printMessageTooLong: size ] ].
]

{ #category : #detection }
CSDetectorIdentifierTooLong >> detectCodeSmellFromCollection: anAstCollection [

	^anAstCollection collect: [ :ast | self detectCodeSmell: ast ].
]

{ #category : #accessing }
CSDetectorIdentifierTooLong >> idSize [
	^ size
]

{ #category : #accessing }
CSDetectorIdentifierTooLong >> idSize: anObject [
	size := anObject
]

{ #category : #initialization }
CSDetectorIdentifierTooLong >> initialize [
	ids := OrderedCollection new.
	size := 30.
]

{ #category : #generated }
CSDetectorIdentifierTooLong >> visitClassDeclaration: aClassDeclaration [
	
	ids add: (CSIdentifier new withName: aClassDeclaration name value location: ('class ', aClassDeclaration name value)).
	
	aClassDeclaration declarations do: [ :md | md acceptVisitor: self ].
]

{ #category : #generated }
CSDetectorIdentifierTooLong >> visitLocalVariableDeclaration: aLocalVariableDeclaration [

	ids add: (CSIdentifier new 
			withName: (aLocalVariableDeclaration declarators at: 1) name identifierToken value 
			location: ('a local variable of method ', aLocalVariableDeclaration parent parent parent parent header name value))

]

{ #category : #generated }
CSDetectorIdentifierTooLong >> visitMethodDeclaration: aMethodDeclaration [
	"methods at: aMethodDeclaration put: aMethodDeclaration header parameters size."

	ids add: (CSIdentifier new withName: aMethodDeclaration header name value location: ('method ', aMethodDeclaration header name value)).
	ids addAll: (aMethodDeclaration header parameters collect: [ :p | 
		(CSIdentifier new 
			withName: p name value 
			location: ('a parameter of method ', aMethodDeclaration header name value))
		]).
	
	aMethodDeclaration body block statements do: [ :st | 
		st acceptVisitor: self. 
	].

]
