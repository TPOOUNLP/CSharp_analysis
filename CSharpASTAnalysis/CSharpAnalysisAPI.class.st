Class {
	#name : #CSharpAnalysisAPI,
	#superclass : #Object,
	#category : #CSharpASTAnalysis
}

{ #category : #'api actions' }
CSharpAnalysisAPI >> detect: aDirectory filter: aOrderCollection [
	"create a CSharpProjectManager and run code smells filters on aDirectory"

	| cs |
	cs := CSharpProjectManager new.
	cs parseCSharpProject: aDirectory.
	cs addDetector: CSDetectorRepeatedMethodBody new.
	cs addDetector: CSDetectorIdentifierTooLong new.
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
	key1 at: 'title' put: 'CSDetectorIdentifierTooLong'.
	detectors add: key1.
	key2 at: 'title' put: 'CSDetectorRepeatedMethodBody'.
	detectors add: key2.
	key3 at: 'title' put: 'CSDetectorTooManyLinesInMethod'.
	detectors add: key3.
	key4 at: 'title' put: 'CSDetectorTooManyMethodParameters'.
	detectors add: key4.
	key5 at: 'title' put: 'CSDetectorTooManyMethods'.
	detectors add: key5.
	key6 at: 'title' put: 'CSDetectorTest'.
	detectors add: key6.
	^ detectors
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
		output: #json;
		after:
			'/*'
				->
					[ :req :resp | resp headers at: 'Access-Control-Allow-Origin' put: '*' ];
		start
]
