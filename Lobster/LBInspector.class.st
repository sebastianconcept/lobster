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

{ #category : #accessing }
LBInspector >> close [

	"Release its strong reference to the inspectee"
	inspectee := nil.
	
	super close
]

{ #category : #initialization }
LBInspector >> initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer [
	super initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer.
	inspecteeId := aHandshakeMessage payload inspecteeId.
	instVarTree := self getViewModelFrom: aHandshakeMessage payload children instVarsTree.
	workspace := self getViewModelFrom: aHandshakeMessage payload children workspace.
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
