Class {
	#name : #CSDetectorTooManyMethodsTest,
	#superclass : #CodeSmellDetectorTest,
	#category : #'CSharpASTAnalysis-Test'
}

{ #category : #tests }
CSDetectorTooManyMethodsTest >> setUp [
	super setUp.
	
	csharpProjectManager parseCSharpProject: './CSharpProjectTest'.
]

{ #category : #tests }
CSDetectorTooManyMethodsTest >> testDetectCodeSmellFromCollection [
	|report|
		
	tooManyMethodsDetector length: 10.
	report := (tooManyMethodsDetector detectCodeSmellFromCollection: csharpProjectManager astCollection).
	self assert: (report anySatisfy: [ :rep | rep csClassName = 'TooManyMethodsClass' ]).
	self deny: (report anySatisfy: [ :rep | rep csClassName = 'NoCodeSmellsClass' ]).
	
	csharpProjectManager parseCSharpProject: './CSharpProjectTest/NoCodeSmells'.
	report := (tooManyLinesInMethodDetector detectCodeSmellFromCollection: csharpProjectManager astCollection).
	
	self assert: (report isEmpty).
	
	

]
