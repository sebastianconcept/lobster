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
	| id inspectee  |
	id := UUID new asString36.
	inspectee := super basicInterpretOn: aViewModel.
	aViewModel inspectees at: id put: inspectee.
	^ {(#inspectee -> inspectee printString).
	(#id -> id)} asDictionary asJsonString
]

{ #category : #actions }
LBInspectIt >> wrappedAnswer: anAnswer [
	^ {(#answer -> anAnswer).
	(#messageType -> self class selector)} asDictionary

]
