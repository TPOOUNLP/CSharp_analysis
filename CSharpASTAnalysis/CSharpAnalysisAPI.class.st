Class {
	#name : #CSharpAnalysisAPI,
	#superclass : #Object,
	#category : #CSharpASTAnalysis
}

{ #category : #'api actions' }
CSharpAnalysisAPI >> detect: aDirectory filter: aConcatenatedDetectorTypesList [
	"create a CSharpProjectManager and run code smells filters on aDirectory"

	| cs typesCollection |
	cs := CSharpProjectManager new.
	cs parseCSharpProject: aDirectory.
	typesCollection := aConcatenatedDetectorTypesList splitOn: ','.
	typesCollection
		do:
			[ :detectorType | cs addDetector: (self makeDetector: detectorType asSymbol) ].
	cs detectCodeSmells.
	^ cs getReportsAsJson: aDirectory , '/ReporteCs.json'
]

{ #category : #accessing }
CSharpAnalysisAPI >> getDetectors [
	| detectors key1 key2 key3 key4 key5 key6 |
	detectors := OrderedCollection new.
	key1 := Dictionary new.
	key2 := Dictionary new.
	key3 := Dictionary new.
	key4 := Dictionary new.
	key5 := Dictionary new.
	key6 := Dictionary new.
	key1 at: 'title' put: 'IdentifierTooLong'.
	detectors add: key1.
	key2 at: 'title' put: 'RepeatedMethodBody'.
	detectors add: key2.
	key3 at: 'title' put: 'TooManyLinesInMethod'.
	detectors add: key3.
	key4 at: 'title' put: 'TooManyMethodParameters'.
	detectors add: key4.
	key5 at: 'title' put: 'TooManyMethods'.
	detectors add: key5.
	key6 at: 'title' put: 'Test'.
	detectors add: key6.
	^ detectors
]

{ #category : #factory }
CSharpAnalysisAPI >> makeDetector: detectorType [
	"devuelve una instancia del detector indicado"

	| detectorClass |
	detectorClass := Smalltalk
		at: (#CSDetector , detectorType) asSymbol
		ifAbsent: [ ^ nil ].
	^ detectorClass new
]

{ #category : #'server handling' }
CSharpAnalysisAPI >> startServer [
	"start ZnServer server proccess on port 1701"

	Teapot stopAll.
	Teapot on
		GET: '/detectors' -> [ :req | self getDetectors ];
		output: #json;
		POST:
			'/detect'
				->
					[ :req | self detect: (req at: #directory) filter: (req at: #filters) ];
		after:
			'/*'
				->
					[ :req :resp | resp headers at: 'Access-Control-Allow-Origin' put: '*'.
					resp headers at: 'Content-Type' put: 'application/json' ];
		start
]
