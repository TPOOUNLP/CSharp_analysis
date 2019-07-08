"
I'm a CodeSmellDetector that detects code smell of having too many parameters in a method.
"
Class {
	#name : #CSDetectorTooManyMethodParameters,
	#superclass : #CodeSmellDetector,
	#instVars : [
		'methods',
		'length'
	],
	#category : #CSharpASTAnalysis
}

{ #category : #initialization }
CSDetectorTooManyMethodParameters >> initialize [

	methods := Dictionary new.
	length := 4.
]

{ #category : #initialization }
CSDetectorTooManyMethodParameters >> initializeCollections [
	methods := Dictionary new.
]

{ #category : #accessing }
CSDetectorTooManyMethodParameters >> length [
	^ length
]

{ #category : #accessing }
CSDetectorTooManyMethodParameters >> length: anObject [
	length := anObject
]

{ #category : #private }
CSDetectorTooManyMethodParameters >> printResult [
	"Base method to detect code smells from a SmaCC node"

	| code_smells report |
	
	report := CodeSmellReport new.
	report name: 'Too Many Parameters in Method'.
	methods keysAndValuesDo: [ :method :params | 
			(params > length)
				ifTrue: [ code_smells := WriteStream on: ''.
						code_smells
						nextPutAll: 'Method "';
						nextPutAll: method header name value;
						nextPutAll: '" has ';
						nextPutAll: params printString;
						nextPutAll: ' params. The upper-bound limit is ';
						nextPutAll: length printString.
						report csClassName: (method parent name value).
						report addDetection: code_smells contents.
				]. 
			].
	^ report.
	

]

{ #category : #generated }
CSDetectorTooManyMethodParameters >> visitMethodDeclaration: aMethodDeclaration [

		methods at: aMethodDeclaration put: aMethodDeclaration header parameters size.
]
