Class {
	#name : #CSIdentifier,
	#superclass : #Object,
	#instVars : [
		'idname',
		'idlocation'
	],
	#category : #CSharpASTAnalysis
}

{ #category : #'as yet unclassified' }
CSIdentifier >> idName [

	^idname.
]

{ #category : #printing }
CSIdentifier >> printMessageTooLong: anIdentifierMaxLength [
	"Prints a message that says that the identifier is too long."
	| message |
	message := WriteStream on: ''.
	message
		nextPutAll: 'The identifier ';
		nextPutAll: idname;
		nextPutAll: ' has ';
		nextPutAll: idname size printString;
		nextPutAll: ' characters. The upper-bound limit is ';
		nextPutAll: anIdentifierMaxLength printString.
	
	^message contents.
]

{ #category : #'as yet unclassified' }
CSIdentifier >> withName: aName location: aLocation [
	
	idname := aName.
	idlocation := aLocation.
]
