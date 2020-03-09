"
The handshake is expected to be the first command.
It should have the information that we need in order to create the right type of model for the view that was connected in the UI side.
"
Class {
	#name : #LBHandshake,
	#superclass : #LBMessage,
	#category : #'Lobster-Protocol'
}

{ #category : #actions }
LBHandshake >> interpretOn: aViewModel [

	aViewModel onOpened.

	^ true
]

{ #category : #accessing }
LBHandshake >> payload [

	^ payload 
]

{ #category : #accessing }
LBHandshake >> theme [
	^ payload theme
]

{ #category : #accessing }
LBHandshake >> viewType [
	"Answers the symbol of the view type expected in a handshake message."

	^ payload viewType
]
