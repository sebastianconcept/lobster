"
Supports interpretation of a DoIt + browse command that will target the class to which the answer belongs.

Looks the same as DoIt on the server side but the frontend will handle differently and it uses the class name
"
Class {
	#name : #LBBrowseIt,
	#superclass : #LBDoAndObserveIt,
	#category : #'Lobster-Protocol'
}

{ #category : #actions }
LBBrowseIt >> basicInterpretOn: aViewModel [
	| id answer |
	id := UUID new asString36.
	answer := super basicInterpretOn: aViewModel.
	aViewModel references at: id put: answer class.
	aViewModel references at: #selectedClass put: answer class.
	^ {(#classPrintString -> answer class printString).
	(#id -> id)} asDictionary
]
