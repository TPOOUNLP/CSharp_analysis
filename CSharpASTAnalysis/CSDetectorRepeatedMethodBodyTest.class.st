Class {
	#name : #CSDetectorRepeatedMethodBodyTest,
	#superclass : #CodeSmellDetectorTest,
	#category : #'CSharpASTAnalysis-Test'
}

{ #category : #tests }
CSDetectorRepeatedMethodBodyTest >> setUp [
	super setUp.
	
	csharpProjectManager parseCSharpProject: './CSharpProjectTest'.
]

{ #category : #tests }
CSDetectorRepeatedMethodBodyTest >> testDetectCodeSmellFromCollection [
	|report|
	
	report := (repeatedMethodBodyDetector detectCodeSmellFromCollection: csharpProjectManager astCollection).
	self assert: (report anySatisfy: [ :rep | rep detections anySatisfy: [:d | d contents includesSubstring: 'AnotherMethodRepeated1']]).
	self assert: (report anySatisfy: [ :rep | rep detections anySatisfy: [:d | d contents includesSubstring: 'AnotherMethodRepeated2']]).
	
	self assert: (report anySatisfy: [ :rep | rep detections anySatisfy: [:d | d contents includesSubstring: 'MethodRepeated1']]).
	self assert: (report anySatisfy: [ :rep | rep detections anySatisfy: [:d | d contents includesSubstring: 'MethodRepeated2']]).
	
	self deny: (report anySatisfy: [ :rep | rep detections anySatisfy: [:d | d contents includesSubstring: 'NoCodeSmellsClass']]).
	
	csharpProjectManager parseCSharpProject: './CSharpProjectTest/NoCodeSmells'.
	report := (repeatedMethodBodyDetector detectCodeSmellFromCollection: csharpProjectManager astCollection).
	
	self deny: (report anySatisfy: [ :rep | rep detections anySatisfy: [:d | d contents includesSubstring: 'AnotherMethodRepeated1']]).
	self deny: (report anySatisfy: [ :rep | rep detections anySatisfy: [:d | d contents includesSubstring: 'AnotherMethodRepeated2']]).
	
	self deny: (report anySatisfy: [ :rep | rep detections anySatisfy: [:d | d contents includesSubstring: 'MethodRepeated1']]).
	self deny: (report anySatisfy: [ :rep | rep detections anySatisfy: [:d | d contents includesSubstring: 'MethodRepeated2']]).
	
	self assert: (report isEmpty).

	
	
	

]
