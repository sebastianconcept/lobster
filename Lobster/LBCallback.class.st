"
The LBCallback command will take the callback selector sent in the payload and find the corresponding callback action registered in the ViewModel instance that receives it and evaluate it.


"
Class {
	#name : #LBCallback,
	#superclass : #LBMessage,
	#category : #'Lobster-Protocol'
}

{ #category : #actions }
LBCallback >> getReferencesFrom: aViewModel [
	^ self payload options references
		collect: [ :key | aViewModel references at: key ]
]

{ #category : #actions }
LBCallback >> interpretOn: aViewModel [
	"TODO: 
	1. use the optional 'options' object in the payload as arguments 
	2. send the answer wrapped including the id of the executed callback"

	^ aViewModel callbacks
		at: self payload selector
		ifPresent: [ :action | 
			(self payload options references isNil or: [ self payload options references isEmpty ])
				ifTrue: [ action value ]
				ifFalse: [ action valueWithArguments: (self getReferencesFrom: aViewModel) ] ]
]
