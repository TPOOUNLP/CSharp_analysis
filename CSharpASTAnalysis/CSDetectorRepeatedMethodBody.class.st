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
	duplicatedMethods:= Bag new.
	bag := methods asBag.
	methods do: [:each | (bag occurrencesOf: each) > 1 ifTrue: [duplicatedMethods add: each parent]].

]

{ #category : #initialization }
CSDetectorRepeatedMethodBody >> initialize [
	methods := OrderedCollection new.
	duplicatedMethods := Bag new.
]

{ #category : #private }
CSDetectorRepeatedMethodBody >> printReport [
	| text report |
	text := WriteStream on: ''.
 	report := CodeSmellReport new.
	self evaluateRepeatedMethods.
	duplicatedMethods do: [ :method | 
						report name: (self printString); csClassName: (method parent name value).
						text nextPutAll: method header name value;
						nextPutAll: '" repeated implementation.'.
						report addDetection: text.
			].
	^ report.
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
