"
Visitor to detect code smell of too many methods in a class.
"
Class {
	#name : #CSDetectorTooManyMethods,
	#superclass : #CodeSmellDetector,
	#instVars : [
		'methods',
		'length'
	],
	#category : #CSharpASTAnalysis
}

{ #category : #detection }
CSDetectorTooManyMethods >> detectCodeSmell: aCSCompilationUnitNode [
	| code_smells |
	code_smells := WriteStream on: ''.
	methods := Bag new.
	aCSCompilationUnitNode acceptVisitor: self.
	methods sortedElements
		do: [ :class | 
			(methods occurrencesOf: class key) > length
				ifTrue: [ code_smells
						nextPutAll: 'Class "';
						nextPutAll: class key;
						nextPutAll: '" has ';
						nextPutAll: (methods occurrencesOf: class key) printString;
						nextPutAll: ' methods. The upper-bound limit is ';
						nextPutAll: length printString; cr.
				]. 
			].
	^ code_smells contents.
]

{ #category : #detection }
CSDetectorTooManyMethods >> detectCodeSmellFromCollection: anAstCollection [

	^anAstCollection collect: [ :ast | self detectCodeSmell: ast ].
]

{ #category : #initialization }
CSDetectorTooManyMethods >> initialize [
	methods := Bag new.
	length := 30.
]

{ #category : #accessing }
CSDetectorTooManyMethods >> length [
	^ length
]

{ #category : #accessing }
CSDetectorTooManyMethods >> length: anObject [
	length := anObject
]

{ #category : #accessing }
CSDetectorTooManyMethods >> methods [
	^ methods
]

{ #category : #accessing }
CSDetectorTooManyMethods >> methods: anObject [
	methods := anObject
]

{ #category : #generated }
CSDetectorTooManyMethods >> visitMethodDeclaration: aMethodDeclaration [
	| class |
	class:= aMethodDeclaration parent.
	methods add: (class name value).
]
