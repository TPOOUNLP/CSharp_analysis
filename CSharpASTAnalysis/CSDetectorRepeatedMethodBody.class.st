"
I'm a CodeSmellDetector that detects code smell of repeated method body.
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
	duplicatedMethods:= Bag new.
	bag := methods asBag.
	methods do: [:each | (bag occurrencesOf: each) > 1 ifTrue: [duplicatedMethods add: each parent]].

]

{ #category : #initialization }
CSDetectorRepeatedMethodBody >> initialize [
	methods := OrderedCollection new.
	duplicatedMethods := Bag new.
]

{ #category : #initialization }
CSDetectorRepeatedMethodBody >> initializeCollections [
	methods := OrderedCollection new.
	duplicatedMethods := Bag new.
]

{ #category : #private }
CSDetectorRepeatedMethodBody >> printResult [
	| text report |
	report := CodeSmellReport new.
	report name: (self printString).
	self evaluateRepeatedMethods.
	duplicatedMethods do: [ :method |
		report csClassName: (method parent name value).
		text := WriteStream on: ''.
		text nextPutAll: method header name value;
		nextPutAll: ' method has a repeated implementation'.
		report addDetection: text.
	].
	^ report.
]

{ #category : #printing }
CSDetectorRepeatedMethodBody >> printString [
	^ 'Repeated Methods'
]

{ #category : #visitor }
CSDetectorRepeatedMethodBody >> visitMethodDeclaration: aMethodDeclaration [
	methods add: aMethodDeclaration body.
]
