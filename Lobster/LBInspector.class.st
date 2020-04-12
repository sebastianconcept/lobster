"
A model for the Inspector tool.

inspecteeId is where is userd as reference to match the inspectee in the ViewModel requesting the inspectIt.
inspectee is the object being inspected
references a dictionary with the objects (by id) which are referenced from the instrospection navigation in the UI
workspace is a convenience workspace contextualized on what's being inspected
introspector is the ViewModel that will help to display the parts of the inspectee
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

{ #category : #actions }
LBInspector >> handshake: aHandshakeMessage [
	"Receives aHandshakeMessage reacts and answer its interpretation of it."

	| setSelfObjectId |
	super handshake: aHandshakeMessage.
	self introspector references: self references.
	setSelfObjectId := UUID new asString36.
	self callbacks
		at: setSelfObjectId
		put: [ :nextSelfObject | 
			self selfObject: nextSelfObject.
			setSelfObjectId ].
	^ Dictionary new
		at: #setSelfObjectId put: setSelfObjectId;
		at: #roots
			put:
			(self selfObject
				introspectWith: self references
				for: self introspector);
		yourself
]

{ #category : #initialization }
LBInspector >> initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer [
	super initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer.
	inspecteeId := aHandshakeMessage payload inspecteeId.
	self children 
		at: #introspectorId put: aHandshakeMessage payload children introspector id;
		at: #workspaceId put: aHandshakeMessage payload children workspace id;
		yourself.

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

{ #category : #accessing }
LBInspector >> introspector [
	^ self getViewModelAt: (self children at: #introspectorId)
]

{ #category : #accessing }
LBInspector >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: inspectee asString;
		nextPut: $)
]

{ #category : #accessing }
LBInspector >> selfObject: anObject [
	super selfObject: anObject.
	self workspace selfObject: anObject.
	self introspector selfObject: anObject
]

{ #category : #accessing }
LBInspector >> workspace [
	^ self getViewModelAt: (self children at: #workspaceId)
]
