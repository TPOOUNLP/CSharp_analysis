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
	| detectorsDescriptions allDetectors aDetectorDescription aDetectorInstance |
	detectorsDescriptions := OrderedCollection new.
	
	allDetectors := CodeSmellDetector allSubclasses.
	allDetectors
		do: [ :detector | 
			aDetectorInstance := detector new.
			aDetectorDescription := Dictionary new.
			aDetectorDescription at: 'title' put: aDetectorInstance title.
			aDetectorDescription at: 'name' put: aDetectorInstance label.
			aDetectorDescription
				at: 'referenceType'
				put: aDetectorInstance referenceType.
			aDetectorDescription
				at: 'referenceIndex'
				put: aDetectorInstance referenceIndex.
			detectorsDescriptions add: aDetectorDescription ].
	^ detectorsDescriptions
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
