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

{ #category : #reactions }
LBWorkspace >> initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer [
	super initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer.
	aLBServer
		when: #viewModelOpened: send: #onNewViewModelOpened: to: self;
		when: #inspectorClosed: send: #onInspectorClosed: to: self;
		yourself
]

{ #category : #reactions }
LBWorkspace >> onNewViewModelOpened: aViewModel [
	| inspectee |
	(aViewModel class == LBInspector)
		ifFalse: [ ^ self ].
	(self references includesKey: aViewModel inspecteeId)
		ifFalse: [ ^ self ].
	inspectee := self references removeKey: aViewModel inspecteeId.
	aViewModel
		inspectee: inspectee;
		selfObject: inspectee;
		yourself
]
