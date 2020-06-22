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
	key1 at: 'name' put: 'Identifier Too Long'.
	key1 at: 'referenceType' put: 'identifier'.
	key1 at: 'referenceIndex' put: 2.
	detectors add: key1.
	key2 at: 'title' put: 'RepeatedMethodBody'.
	key2 at: 'name' put: 'Repeated Method Body'.
	key2 at: 'referenceType' put: 'method'.
	key2 at: 'referenceIndex' put: 0.
	detectors add: key2.
	key3 at: 'title' put: 'TooManyLinesInMethod'.
	key3 at: 'name' put: 'Too Many Lines In Method'.
	key3 at: 'referenceType' put: 'method'.
	key3 at: 'referenceIndex' put: 0.
	detectors add: key3.
	key4 at: 'title' put: 'TooManyMethodParameters'.
	key4 at: 'name' put: 'Too Many Method Parameters'.
	key4 at: 'referenceType' put: 'method'.
	key4 at: 'referenceIndex' put: 1.
	detectors add: key4.
	key5 at: 'title' put: 'TooManyMethods'.
	key5 at: 'name' put: 'Too Many Methods'.
	key5 at: 'referenceType' put: 'method'.
	key5 at: 'referenceIndex' put: 0.
	detectors add: key5.
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
