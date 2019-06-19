Class {
	#name : #CSDetectorTooManyMethodParameters,
	#superclass : #CodeSmellDetector,
	#instVars : [
		'methods',
		'length'
	],
	#category : #CSharpASTAnalysis
}

{ #category : #detection }
CSDetectorTooManyMethodParameters >> detectCodeSmell: aCSCompilationUnitNode [

	| code_smells |
	code_smells := WriteStream on: ''.
	methods := Dictionary new.
	aCSCompilationUnitNode acceptVisitor: self.
	methods keysAndValuesDo: [ :method :params | 
			(params > length)
				ifTrue: [ code_smells
						nextPutAll: 'Method "';
						nextPutAll: method header name value;
						nextPutAll: '" from class "';
						nextPutAll: method parent name value;
						nextPutAll: '" has ';
						nextPutAll: params printString;
						nextPutAll: ' params. The upper-bound limit is ';
						nextPutAll: length printString; cr.
				]. 
			].
	^ code_smells contents.
]

{ #category : #initialization }
CSDetectorTooManyMethodParameters >> initialize [

	methods := Dictionary new.
	length := 30.
]

{ #category : #accessing }
CSDetectorTooManyMethodParameters >> length [
	^ length
]

{ #category : #accessing }
CSDetectorTooManyMethodParameters >> length: anObject [
	length := anObject
]

{ #category : #generated }
CSDetectorTooManyMethodParameters >> visitMethodDeclaration: aMethodDeclaration [

		methods at: aMethodDeclaration put: aMethodDeclaration header parameters size.
]
