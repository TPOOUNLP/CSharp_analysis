"
Test Class of CSharpProjectManager
"
Class {
	#name : #'CSharpProjectManager_Test',
	#superclass : #TestCase,
	#instVars : [
		'aProjectManager'
	],
	#category : #'CSharpASTAnalysis-Tests'
}

{ #category : #accessing }
CSharpProjectManager_Test >> aProjectManager [
	^ aProjectManager
]

{ #category : #accessing }
CSharpProjectManager_Test >> aProjectManager: anObject [
	aProjectManager := anObject
]

{ #category : #running }
CSharpProjectManager_Test >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp.
	aProjectManager:= CSharpProjectManager parseProject: './Projects/CSSharpProjectTest'.
]

{ #category : #tests }
CSharpProjectManager_Test >> test_identifierTooLong [
	"Test case of the identifier too long code smell detector"
	| reports |
	aProjectManager addDetector: CSDetectorIdentifierTooLong new.
	aProjectManager detectCodeSmells.
   self assert: (aProjectManager reports size) equals: 1.
	reports:= (aProjectManager reports at: 1).
	self assert: reports size equals: 2.
	self assert: ((reports at: 1) name) equals: 'Identifier Too Long'.
	self assert: ((reports at: 1) csClassName) equals: 'IdentifierTooLongClass'.
	self assert: ((reports at: 2) csClassName) equals: 'AnotherClassWithRepeatedMethods'.
]

{ #category : #tests }
CSharpProjectManager_Test >> test_init [
	self assert: (aProjectManager astCollection size) equals: 8.
]

{ #category : #tests }
CSharpProjectManager_Test >> test_parsing [
	self test_init.
	aProjectManager saveParsingTo: 'parsing.STON'.
	aProjectManager:= CSharpProjectManager new.
	self deny: (aProjectManager astCollection notNil).
	aProjectManager loadParsing: 'parsing.STON'.
	self assert: (aProjectManager astCollection size) equals: 8.
]

{ #category : #tests }
CSharpProjectManager_Test >> test_repeatedMethodBody [
	"Test case of the repeated method body code smell detector"
	| reports |
	aProjectManager addDetector: CSDetectorRepeatedMethodBody new.
	aProjectManager detectCodeSmells.
   self assert: (aProjectManager reports size) equals: 1.
	reports:= (aProjectManager reports at: 1).
	self assert: reports size equals: 2.
	self assert: ((reports at: 1) name) equals: 'Repeated Methods'.
	self assert: ((reports at: 1) csClassName) equals: 'AnotherClassWithRepeatedMethods'.
	self assert: ((reports at: 2) csClassName) equals: 'ClassWithRepeatedMethods'.
]

{ #category : #tests }
CSharpProjectManager_Test >> test_tooManyLinesInMethod [
	"Test case of the too many lines in methods code smell detector"
	| reports |
	aProjectManager addDetector: CSDetectorTooManyLinesInMethod new.
	aProjectManager detectCodeSmells.
   self assert: (aProjectManager reports size) equals: 1.
	reports:= (aProjectManager reports at: 1).
	self assert: reports size equals: 1.
	self assert: ((reports at: 1) name) equals: 'Too Many Lines in Method'.
]

{ #category : #tests }
CSharpProjectManager_Test >> test_tooManyMethods [
	"Test case of the too many methods code smell detector"
	| detector reports |
	detector:= CSDetectorTooManyMethods new.
	detector length: 10.
	aProjectManager addDetector: detector.
	aProjectManager detectCodeSmells.
   self assert: (aProjectManager reports size) equals: 1.
	reports:= (aProjectManager reports at: 1).
	self assert: reports size equals: 1.
	self assert: ((reports at: 1) name) equals: 'Too Many Methods'.
]
