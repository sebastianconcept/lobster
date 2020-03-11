"
A model for the Inspector tool
"
Class {
	#name : #LBInspector,
	#superclass : #LBViewModel,
	#instVars : [
		'inspecteeId',
		'inspectee',
		'workspace',
		'introspector'
	],
	#category : #'Lobster-ViewModels'
}

{ #category : #initialization }
LBInspector >> initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer [
	super initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer.
	inspecteeId := aHandshakeMessage payload inspecteeId.
	introspector := self getViewModelFrom: aHandshakeMessage payload children introspector.
	workspace := self getViewModelFrom: aHandshakeMessage payload children workspace.
	aLBServer observeInspector: self
]

{ #category : #accessing }
LBInspector >> inspecteeId [
	^ inspecteeId
]

{ #category : #accessing }
LBInspector >> selfObject: anObject [
	super selfObject: anObject.
	workspace selfObject: anObject.
	introspector selfObject: anObject
]
