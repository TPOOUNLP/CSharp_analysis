Class {
	#name : #CSDetectorTooManyLinesInMethod,
	#superclass : #CodeSmellDetector,
	#instVars : [
		'methods',
		'methodBodyMaxlength'
	],
	#category : #CSharpASTAnalysis
}

{ #category : #detection }
CSDetectorTooManyLinesInMethod >> detectCodeSmell: aCSCompilationUnitNode [
	| code_smells |
	code_smells := WriteStream on: ''.
	aCSCompilationUnitNode acceptVisitor: self.
	methods keysAndValuesDo: [ :method :lines | code_smells nextPutAll: 'Class "';
						nextPutAll: method parent name value;
						nextPutAll: '", Method "';
						nextPutAll: method header name value;
						nextPutAll: '" has too many lines with ';
						nextPutAll: lines printString;
						nextPutAll: ' lines.';
						nextPut: Character cr. 
			].
	^ code_smells contents.
]

{ #category : #detection }
CSDetectorTooManyLinesInMethod >> detectCodeSmellFromCollection: anAstCollection [
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
CSDetectorTooManyLinesInMethod >> initialize [
	methods := Dictionary new.
	methodBodyMaxlength := 10.
]

{ #category : #accessing }
CSDetectorTooManyLinesInMethod >> methodBodyMaxlength [
	^ methodBodyMaxlength
]

{ #category : #accessing }
CSDetectorTooManyLinesInMethod >> methodBodyMaxlength: anObject [
	methodBodyMaxlength := anObject
]

{ #category : #accessing }
CSDetectorTooManyLinesInMethod >> methods [
	^ methods
]

{ #category : #accessing }
CSDetectorTooManyLinesInMethod >> methods: anObject [
	methods := anObject
]

{ #category : #generated }
CSDetectorTooManyLinesInMethod >> visitBlockStatement: aBlockStatement [
	| lines |
	lines := aBlockStatement statements size.
	(lines > methodBodyMaxlength)
		ifTrue: [ methods at: (aBlockStatement parent parent) put: lines ]
]
