Class {
	#name : #CSDetectorTooManyLinesInMethodTest,
	#superclass : #CodeSmellDetectorTest,
	#category : #'CSharpASTAnalysis-Test'
}

{ #category : #tests }
CSDetectorTooManyLinesInMethodTest >> setUp [
	super setUp.
	
	csharpProjectManager parseCSharpProject: './CSharpProjectTest'.
]

{ #category : #tests }
CSDetectorTooManyLinesInMethodTest >> testDetectCodeSmellFromCollection [
	|report|
		
	tooManyLinesInMethodDetector methodBodyMaxlength: 10.
	report := (tooManyLinesInMethodDetector detectCodeSmellFromCollection: csharpProjectManager astCollection).
	self assert: (report anySatisfy: [ :rep | rep detections anySatisfy: [:d | d contents includesSubstring: 'MethodWith21Lines']]).
	self assert: (report anySatisfy: [ :rep | rep detections anySatisfy: [:d | d contents includesSubstring: 'MethodWith11Lines']]).
	
	self deny: (report anySatisfy: [ :rep | rep detections anySatisfy: [:d | d contents includesSubstring: 'MethodWith1Line']]).
	self deny: (report anySatisfy: [ :rep | rep detections anySatisfy: [:d | d contents includesSubstring: 'MethodWith5Lines']]).
	
	csharpProjectManager parseCSharpProject: './CSharpProjectTest/NoCodeSmells'.
	report := (tooManyLinesInMethodDetector detectCodeSmellFromCollection: csharpProjectManager astCollection).
	self deny: (report anySatisfy: [ :rep | rep detections anySatisfy: [:d | d contents includesSubstring: 'MethodWith21Lines']]).
	
	self assert: (report isEmpty).
	
	

]
