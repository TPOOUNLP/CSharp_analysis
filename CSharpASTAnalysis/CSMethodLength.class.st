Class {
	#name : #CSMethodLength,
	#superclass : #CodeSmellDetector,
	#instVars : [
		'methods',
		'length'
	],
	#category : #CSharpASTAnalysis
}

{ #category : #detection }
CSMethodLength >> detectCodeSmell: aCSCompilationUnitNode [
	| code_smells |
	code_smells := WriteStream on: ''.
	aCSCompilationUnitNode acceptVisitor: self.
	methods sortedElements
		do: [ :class | 
			(methods occurrencesOf: class key) > length
				ifTrue: [ code_smells
						nextPutAll: 'Class: "';
						nextPutAll: class key;
						nextPutAll: '": ';
						nextPutAll: (methods occurrencesOf: class key) printString;
						nextPutAll: ' methods.';
						nextPut: Character cr. 
				]. 
			].
	^ code_smells contents.
]

{ #category : #detection }
CSMethodLength >> detectCodeSmellFromCollection: anAstCollection [
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

{ #category : #initialization }
CSMethodLength >> initialize [
	methods := Bag new.
	length := 30.
]

{ #category : #accessing }
CSMethodLength >> length [
	^ length
]

{ #category : #accessing }
CSMethodLength >> length: anObject [
	length := anObject
]

{ #category : #accessing }
CSMethodLength >> methods [
	^ methods
]

{ #category : #accessing }
CSMethodLength >> methods: anObject [
	methods := anObject
]

{ #category : #generated }
CSMethodLength >> visitMethodDeclaration: aMethodDeclaration [
	| class |
	class:= aMethodDeclaration parent.
	methods add: (class name value).
]
