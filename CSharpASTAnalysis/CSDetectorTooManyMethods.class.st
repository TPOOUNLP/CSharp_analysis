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

{ #category : #private }
CSDetectorTooManyMethods >> printResult [
	| text |
	text := WriteStream on: ''.
	methods sortedElements
		do: [ :class | 
			(methods occurrencesOf: class key) > length
				ifTrue: [ text
						nextPutAll: 'Class: "';
						nextPutAll: class key;
						nextPutAll: '": ';
						nextPutAll: (methods occurrencesOf: class key) printString;
						nextPutAll: ' methods.';
						nextPut: Character cr. 
				]. 
			].
	methods := Bag new.
	^ text contents.
]

{ #category : #visitor }
CSDetectorTooManyMethods >> visitMethodDeclaration: aMethodDeclaration [
	| class |
	class:= aMethodDeclaration parent.
	methods add: (class name value).
]
