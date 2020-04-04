"
Abstract command that will evaluate and answer the result in a way that is comfortable for the UI to keep manipulating it and observint it.
"
Class {
	#name : #LBDoAndObserveIt,
	#superclass : #LBDoIt,
	#category : #'Lobster-Protocol'
}

{ #category : #actions }
LBDoAndObserveIt >> interpretOn: aViewModel [
	^ [ (self basicInterpretOn: aViewModel) asJsonString ]
		on: SyntaxErrorNotification
		do: [ :x | x messageText ]
]
