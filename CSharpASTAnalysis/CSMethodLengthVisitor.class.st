"
A visitor for declarations of a CSharp program.
"
Class {
	#name : #CSMethodLengthVisitor,
	#superclass : #CSProgramNodeVisitor,
	#instVars : [
		'methods',
		'length'
	],
	#category : #CSharpASTAnalysis
}

{ #category : #detection }
CSMethodLengthVisitor >> detectCodeSmell: aCSCompilationUnitNode [
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
CSMethodLengthVisitor >> detectCodeSmellFromCollection: anAstCollection [
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
CSMethodLengthVisitor >> initialize [
	methods := Bag new.
	length := 30.
]

{ #category : #accessing }
CSMethodLengthVisitor >> length [
	^ length
]

{ #category : #accessing }
CSMethodLengthVisitor >> length: anObject [
	length := anObject
]

{ #category : #accessing }
CSMethodLengthVisitor >> methods [
	^ methods
]

{ #category : #accessing }
CSMethodLengthVisitor >> methods: anObject [
	methods := anObject
]

{ #category : #generated }
CSMethodLengthVisitor >> visitMethodDeclaration: aMethodDeclaration [
	| class |
	class:= aMethodDeclaration parent.
	methods add: (class name value).
]
