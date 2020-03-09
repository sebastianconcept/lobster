"
A model for the Inspector tool
"
Class {
	#name : #LBInspector,
	#superclass : #LBViewModel,
	#instVars : [
		'inspecteeId',
		'inspectee'
	],
	#category : #'Lobster-ViewModels'
}

{ #category : #initialization }
LBInspector >> initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer [
	super initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer.
	inspecteeId := aHandshakeMessage payload inspecteeId.
	aLBServer observeInspector: self
]

{ #category : #accessing }
LBInspector >> inspectee [
	^ inspectee
]

{ #category : #accessing }
LBInspector >> inspectee: anObject [
	inspectee := anObject
]

{ #category : #accessing }
LBInspector >> inspecteeId [
	^ inspecteeId
]
