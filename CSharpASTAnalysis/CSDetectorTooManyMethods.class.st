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

{ #category : #initialization }
CSDetectorTooManyMethods >> clearInternalStates [
	methods := Bag new.
]

{ #category : #initialization }
CSDetectorTooManyMethods >> initialize [
	methods := Bag new.
	length:= 30.
]

{ #category : #accessing }
CSDetectorTooManyMethods >> length [
	^ length
]

{ #category : #accessing }
CSDetectorTooManyMethods >> length: anObject [
	length := anObject
]

{ #category : #private }
CSDetectorTooManyMethods >> printResult [
	| text report |
	report := CodeSmellReport new.
	report name: (self printString).
	methods sortedElements
		do: [ :class |
			(methods occurrencesOf: class key) > length
				ifTrue: [ report csClassName: class key.
						text := WriteStream on: ''.
						text nextPutAll: class key;
						nextPutAll: ' class has ';
						nextPutAll: (methods occurrencesOf: class key) printString;
						nextPutAll: ' methods'.
						report addDetection: text.
				].
			].
	^ report.
]

{ #category : #printing }
CSDetectorTooManyMethods >> printString [
	^ 'Too Many Methods'
]

{ #category : #visitor }
CSDetectorTooManyMethods >> visitMethodDeclaration: aMethodDeclaration [
	| class |
	class:= aMethodDeclaration parent.
	methods add: (class name value).
]
