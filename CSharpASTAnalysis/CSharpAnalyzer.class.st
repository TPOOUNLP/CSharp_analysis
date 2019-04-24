Class {
	#name : #CSharpAnalyzer,
	#superclass : #Object,
	#category : #CSharpASTAnalysis
}

{ #category : #voyage }
CSharpAnalyzer class >> isVoyageRoot [
	^ true
]

{ #category : #parsing }
CSharpAnalyzer class >> parseCSharpProject: aProjectFolder [
	"Parse all the .cs files from a project's folder."

	| work files |
	work := aProjectFolder asFileReference.
	files := work allChildrenMatching: '*.cs'.
	^ files collect: [ :each | CSharpParser parseFile: each fullName ].
]

{ #category : #voyage }
CSharpAnalyzer class >> setUpConnection [
	| repository |
	repository := VOMongoRepository
		host: 'localhost'
		database: 'CSharpAnalyzer'.
	repository enableSingleton.
]

{ #category : #voyage }
CSharpAnalyzer class >> voyageCollectionName [
	^ 'CSharpAnalyzer'
]
