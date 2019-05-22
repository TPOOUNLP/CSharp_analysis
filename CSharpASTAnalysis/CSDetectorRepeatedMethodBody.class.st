Class {
	#name : #CSDetectorRepeatedMethodBody,
	#superclass : #CodeSmellDetector,
	#instVars : [
		'methods'
	],
	#category : #CSharpASTAnalysis
}

{ #category : #detection }
CSDetectorRepeatedMethodBody >> detectCodeSmell: aCSCompilationUnitNode [

	aCSCompilationUnitNode acceptVisitor: self.
	^ self printResult: (self evaluateRepeatedMethods).
]

{ #category : #detection }
CSDetectorRepeatedMethodBody >> evaluateRepeatedMethods [
	|duplicateList bag|
	duplicateList := Bag new.
	bag := methods asBag.
	methods do: [:each | (bag occurrencesOf: each) > 1 ifTrue: [duplicateList add: each parent]].
	^ duplicateList.

]

{ #category : #initialization }
CSDetectorRepeatedMethodBody >> initialize [
	methods := OrderedCollection new.
]

{ #category : #accessing }
CSDetectorRepeatedMethodBody >> methods [
	^ methods
]

{ #category : #accessing }
CSDetectorRepeatedMethodBody >> methods: anObject [
	methods := anObject
]

{ #category : #detection }
CSDetectorRepeatedMethodBody >> printResult: aMethodCollection [
	| text |
	text := WriteStream on: ''.
	aMethodCollection do: [ :method | text nextPutAll: 'Class "';
						nextPutAll: method parent name value;
						nextPutAll: '", Method "';
						nextPutAll: method header name value;
						nextPutAll: '" repeated implementation.';
						nextPut: Character cr.
			].
	^ text contents.
]

{ #category : #detection }
CSDetectorRepeatedMethodBody >> visitMethodDeclaration: aMethodDeclaration [
	methods add: aMethodDeclaration body.
]
