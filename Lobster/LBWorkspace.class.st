"
A model for a Worspace area.

It will temporarily keep track of the inspected objects in its #inspectees instVar so it can pass the inspectee to the inspectors that get opened out of it.
"
Class {
	#name : #LBWorkspace,
	#superclass : #LBViewModel,
	#instVars : [
		'inspectees'
	],
	#category : #'Lobster-ViewModels'
}

{ #category : #initialization }
LBWorkspace >> initializeInspectees [
	^ inspectees := Dictionary new
]

{ #category : #initialization }
LBWorkspace >> initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer [
	super initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer.
	aLBServer observeWorkspace: self.
	aLBServer 
		when: #inspectorOpened: send: #onInspectorOpened: to: self;
		when: #inspectorClosed: send: #onInspectorClosed: to: self;
		yourself 
]

{ #category : #initialization }
LBWorkspace >> inspectees [
	^ inspectees ifNil: [ self initializeInspectees ]
]

{ #category : #reactions }
LBWorkspace >> onInspectorClosed: aLBInspector [

]

{ #category : #reactions }
LBWorkspace >> onInspectorOpened: aLBInspector [
	(self inspectees includesKey: aLBInspector inspecteeId)
		ifFalse: [ ^ self ].
	aLBInspector
		selfObject: (self inspectees removeKey: aLBInspector inspecteeId)
]
