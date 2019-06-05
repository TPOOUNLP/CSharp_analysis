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
	aProjectManager:= CSharpProjectManager parseProject: '/home/naparicio/Documentos/Facultad/TPOO/Practica/Repos Prueba/HelloWorld'.
]

{ #category : #tests }
CSharpProjectManager_Test >> test_init [
	self assert: (aProjectManager astCollection size) equals: 2.
]

{ #category : #tests }
CSharpProjectManager_Test >> test_parsing [
	self test_init.
	aProjectManager saveParsingTo: 'parsing.STON'.
	aProjectManager:= CSharpProjectManager new.
	self deny: (aProjectManager astCollection notNil).
	aProjectManager loadParsing: 'parsing.STON'.
	self assert: (aProjectManager astCollection size) equals: 2.
]
