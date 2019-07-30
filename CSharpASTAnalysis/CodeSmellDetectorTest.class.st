Class {
	#name : #CodeSmellDetectorTest,
	#superclass : #TestCase,
	#instVars : [
		'csharpProjectManager',
		'repeatedMethodBodyDetector',
		'tooManyLinesInMethodDetector',
		'tooManyMethodsDetector'
	],
	#category : #'CSharpASTAnalysis-Test'
}

{ #category : #running }
CodeSmellDetectorTest >> setUp [
	csharpProjectManager := CSharpProjectManager new.
	repeatedMethodBodyDetector := CSDetectorRepeatedMethodBody new.
	tooManyLinesInMethodDetector := CSDetectorTooManyLinesInMethod new.
	tooManyMethodsDetector := CSDetectorTooManyMethods new.
	csharpProjectManager addDetector: repeatedMethodBodyDetector.
	csharpProjectManager addDetector: tooManyLinesInMethodDetector.
	csharpProjectManager addDetector: tooManyMethodsDetector.
	
	"poner carpeta CSharpProjectTest en la misma carpeta que la imagen"
]
