"
CodeSmellDetector to detect code smell of repeated method body.
"
Class {
	#name : #CSDetectorRepeatedMethodBody,
	#superclass : #CodeSmellDetector,
	#instVars : [
		'methods',
		'duplicatedMethods'
	],
	#category : #CSharpASTAnalysis
}

{ #category : #private }
CSDetectorRepeatedMethodBody >> evaluateRepeatedMethods [
	|bag|
	duplicatedMethods := Bag new.
	bag := methods asBag.
	methods do: [:each | (bag occurrencesOf: each) > 1 ifTrue: [duplicatedMethods add: each parent]].

]

{ #category : #initialization }
CSDetectorRepeatedMethodBody >> initialize [
	methods := OrderedCollection new.
]

{ #category : #private }
CSDetectorRepeatedMethodBody >> printResult [
	| text |
	text := WriteStream on: ''.
	duplicatedMethods do: [ :method | text nextPutAll: 'Class "';
						nextPutAll: method parent name value;
						nextPutAll: '", Method "';
						nextPutAll: method header name value;
						nextPutAll: '" repeated implementation.';
						nextPut: Character cr.
			].
	^ text contents.
]

{ #category : #visitor }
CSDetectorRepeatedMethodBody >> visitMethodDeclaration: aMethodDeclaration [
	methods add: aMethodDeclaration body.
]
