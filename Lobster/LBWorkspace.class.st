"
A model for the Worspace tool
"
Class {
	#name : #LBWorkspace,
	#superclass : #LBViewModel,
	#instVars : [
		'inspectees',
		'inspectors'
	],
	#category : #'Lobster-ViewModels'
}

{ #category : #initialization }
LBWorkspace >> initializeInspectees [
	^ inspectees := Dictionary new
]

{ #category : #initialization }
LBWorkspace >> initializeInspectors [
	^ inspectors := Set new
]

{ #category : #initialization }
LBWorkspace >> initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer [
	super initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer.
	aLBServer 
		when: #inspectorOpened: send: #onInspectorOpened: to: self;
		when: #inspectorClosed: send: #onInspectorClosed: to: self;
		yourself 
]

{ #category : #accessing }
LBWorkspace >> inspectees [
	^ inspectees ifNil: [ self initializeInspectees ]
]

{ #category : #accessing }
LBWorkspace >> inspectors [
	^ inspectors ifNil: [ self initializeInspectors ]
]

{ #category : #reactions }
LBWorkspace >> onInspectorClosed: aLBInspector [
	self inspectors remove: aLBInspector ifAbsent: [  ]
]

{ #category : #reactions }
LBWorkspace >> onInspectorOpened: aLBInspector [
	(self inspectees includesKey: aLBInspector inspecteeId)
		ifFalse: [ ^ self ].
	self inspectors add: aLBInspector.
	aLBInspector
		inspectee: (self inspectees removeKey: aLBInspector inspecteeId)
]
