"
Generates a Report for a CodeSmell detector.
"
Class {
	#name : #CodeSmellReport,
	#superclass : #Object,
	#instVars : [
		'name',
		'csClassName',
		'detections'
	],
	#category : #CSharpASTAnalysis
}

{ #category : #accessing }
CodeSmellReport class >> name:aCodeSmellDetectorStringName [
	^ (self new)
		name: aCodeSmellDetectorStringName;
		yourself.
]

{ #category : #accessing }
CodeSmellReport class >> name:aCodeSmellDetectorStringName className:aCSharpClassName [
	^ (self new)
		name: aCodeSmellDetectorStringName;
		csClassName: aCSharpClassName;
		yourself.
]

{ #category : #adding }
CodeSmellReport >> addDetection: aString [
	detections add: aString.
]

{ #category : #accessing }
CodeSmellReport >> csClassName [
	^ csClassName
]

{ #category : #accessing }
CodeSmellReport >> csClassName: anObject [
	csClassName := anObject
]

{ #category : #accessing }
CodeSmellReport >> detections [
	^ detections
]

{ #category : #accessing }
CodeSmellReport >> detections: anObject [
	detections := anObject
]

{ #category : #initialization }
CodeSmellReport >> initialize [
	detections:= OrderedCollection new.
	csClassName:= ''.
]

{ #category : #accessing }
CodeSmellReport >> name [
	^ name
]

{ #category : #accessing }
CodeSmellReport >> name: anObject [
	name := anObject
]

{ #category : #printing }
CodeSmellReport >> toJSON [
	| text |
	text := WriteStream on: ''.
	csClassName = ''
		ifFalse: [ text
				nextPutAll: '{';
				nextPut: Character cr;
				nextPut: Character tab;
				nextPutAll: '"name": "';
				nextPutAll: self name;
				nextPutAll: '",';
				nextPut: Character cr;
				nextPut: Character tab;
				nextPutAll: '"class": "';
				nextPutAll: self csClassName;
				nextPutAll: '",';
				nextPut: Character cr;
				nextPut: Character tab;
				nextPutAll: '"detections": [';
				nextPut: Character cr.
			detections
				do: [ :detection | 
					text
						nextPut: Character tab;
						nextPut: Character tab;
						nextPutAll: '"';
						nextPutAll: detection contents;
						nextPutAll: '",';
						nextPut: Character cr ].
			text
				nextPut: Character tab;
				nextPutAll: '],';
				nextPut: Character cr;
				nextPutAll: '},' ].
	^ text
]
