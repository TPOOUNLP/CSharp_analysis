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
]

{ #category : #accessing }
CodeSmellReport >> name [
	^ name
]

{ #category : #accessing }
CodeSmellReport >> name: anObject [
	name := anObject
]
