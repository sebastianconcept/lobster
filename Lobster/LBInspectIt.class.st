"
Supports interpretation of a DoIt that will end up answering what's needed to inspect the resulting object.

"
Class {
	#name : #LBInspectIt,
	#superclass : #LBDoIt,
	#category : #'Lobster-Protocol'
}

{ #category : #actions }
LBInspectIt >> basicInterpretOn: aViewModel [
	| id inspectee |
	id := UUID new asString36.
	inspectee := super basicInterpretOn: aViewModel.
	aViewModel inspectees at: id put: inspectee.
	^ {(#inspecteePrintString -> inspectee printString).
	(#id -> id)} asDictionary
]

{ #category : #actions }
LBInspectIt >> interpretOn: aViewModel [
	^ [ (self basicInterpretOn: aViewModel) asJsonString ]
		on: SyntaxErrorNotification
		do: [ :x | x messageText ]
]
