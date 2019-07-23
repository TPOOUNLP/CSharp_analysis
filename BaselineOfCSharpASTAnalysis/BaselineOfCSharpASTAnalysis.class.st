"
I'm the baseline for the CSharpAnalysis project.
I show the dependencies required to use it.
"
Class {
	#name : #BaselineOfCSharpASTAnalysis,
	#superclass : #BaselineOf,
	#category : #BaselineOfCSharpASTAnalysis
}

{ #category : #baselines }
BaselineOfCSharpASTAnalysis >> baseline: spec [
    <baseline>
    spec for: #common do: [
        spec 
            baseline: 'Ston'
            with: [ spec repository: 'github://svenvc/ston/repository' ].
		  spec 
            baseline: 'SmaCC'
            with: [ spec repository: 'https://github.com/j-brant/SmaCC' ].
        spec 
			package: 'CSharpASTAnalysis';
			package: 'CSharpASTAnalysis-Tests' with: [ spec requires: #('CSharpASTAnalysis'). ]. ]. 
]
