"
Sent by clients when their view was destroyed
"
Class {
	#name : #LBViewClosed,
	#superclass : #LBMessage,
	#category : #'Lobster-Protocol'
}

{ #category : #actions }
LBViewClosed >> interpretOn: aView [

	aView onClosed.
	
	^ true
]
