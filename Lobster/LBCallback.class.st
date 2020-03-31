"
The LBCallback command will take the callback selector sent in the payload and find the corresponding callback action registered in the ViewModel instance that receives it and evaluate it.


"
Class {
	#name : #LBCallback,
	#superclass : #LBMessage,
	#category : #'Lobster-Protocol'
}

{ #category : #actions }
LBCallback >> interpretOn: aViewModel [
	"TODO: 
	1. use the optional 'options' object in the payload as arguments 
	2. send the answer wrapped including the id of the executed callback"

	^ aViewModel callbacks
		at: self payload selector
		ifPresent: [ :action | action value ]
]
