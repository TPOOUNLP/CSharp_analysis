Class {
	#name : #CodeSmellReport,
	#superclass : #Object,
	#instVars : [
		'reportsDict'
	],
	#category : #CSharpASTAnalysis
}

{ #category : #adding }
CodeSmellReport >> add: aFile withSmell: aMessage [
	"Add a new record to the report with a file and message"
	| mess dict |
	dict := self reportsDict at: aFile ifAbsent: nil.
	dict isNil
		ifTrue: [ 
			mess := OrderedCollection new.
			mess add: aMessage.
			self reportsDict at: aFile put: mess. 
		]
		ifFalse: [ 
			dict add: aMessage.
		].
	
	^self reportsDict.
]

{ #category : #initialization }
CodeSmellReport >> initialize [
	self reportsDict: Dictionary new. 
	^self
]

{ #category : #accessing }
CodeSmellReport >> reportsDict [
	^ reportsDict
]

{ #category : #accessing }
CodeSmellReport >> reportsDict: anObject [
	reportsDict := anObject
]
