"
A model for the Inspector tool
"
Class {
	#name : #LBInspector,
	#superclass : #LBViewModel,
	#instVars : [
		'inspecteeId',
		'inspectee',
		'instVarTree',
		'workspace'
	],
	#category : #'Lobster-ViewModels'
}

{ #category : #initialization }
LBInspector >> initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer [
	super initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer.
	inspecteeId := aHandshakeMessage payload inspecteeId.
	instVarTree := self getViewModelFrom: aHandshakeMessage payload children instVarsTree.
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
	instVarTree selfObject: anObject
]
