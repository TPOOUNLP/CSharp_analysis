Class {
	#name : #CSDetectorTooManyLinesInMethod,
	#superclass : #CodeSmellDetector,
	#instVars : [
		'methodBodyMaxlength',
		'tooManyLinesMethods'
	],
	#category : #CSharpASTAnalysis
}

{ #category : #detection }
CSDetectorTooManyLinesInMethod >> detectCodeSmell: aCSCompilationUnitNode [
	aCSCompilationUnitNode acceptVisitor: self.
	^ self printResult.
]

{ #category : #initialization }
CSDetectorTooManyLinesInMethod >> initialize [
	tooManyLinesMethods := Dictionary new.
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

{ #category : #detection }
CSDetectorTooManyLinesInMethod >> printResult [
	| text |
	text := WriteStream on: ''.
	tooManyLinesMethods keysAndValuesDo: [ :method :lines | text nextPutAll: 'Class "';
						nextPutAll: method parent name value;
						nextPutAll: '", Method "';
						nextPutAll: method header name value;
						nextPutAll: '" has too many lines with ';
						nextPutAll: lines printString;
						nextPutAll: ' lines.';
						nextPut: Character cr. 
			].
	^ text contents.
]

{ #category : #accessing }
CSDetectorTooManyLinesInMethod >> tooManyLinesMethods [
	^ tooManyLinesMethods
]

{ #category : #accessing }
CSDetectorTooManyLinesInMethod >> tooManyLinesMethods: anObject [
	tooManyLinesMethods := anObject
]

{ #category : #generated }
CSDetectorTooManyLinesInMethod >> visitBlockStatement: aBlockStatement [
	| lines |
	lines := aBlockStatement statements size.
	(lines > methodBodyMaxlength)
		ifTrue: [ tooManyLinesMethods at: (aBlockStatement parent parent) put: lines ]
]
