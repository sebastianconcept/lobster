"
A model for the Transcript
"
Class {
	#name : #LBTranscript,
	#superclass : #LBViewModel,
	#instVars : [
		'logger'
	],
	#category : #'Lobster-ViewModels'
}

{ #category : #reactions }
LBTranscript >> close [

	logger ifNotNil: [ logger stop ].
	logger := nil.
	
	super close.

]

{ #category : #initialization }
LBTranscript >> initializeLogger [
	^ logger := LBTranscriptLogger on: self
]

{ #category : #initialization }
LBTranscript >> initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer [
	super initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer.

	aLBServer announcer
		when: LBTranscriptSignal
		do: [ :ann | self send: (LBTranscriptMessage on: ann message) ]
]

{ #category : #accessing }
LBTranscript >> logger [
	^ logger ifNil: [ self initializeLogger ]
]

{ #category : #reactions }
LBTranscript >> onNextPut: anLBTranscriptSignal [

	self send: (LBTranscriptMessage on: anLBTranscriptSignal)
]

{ #category : #reactions }
LBTranscript >> onViewModelOpened [

	super onViewModelOpened.
	
	self logger start
]

{ #category : #action }
LBTranscript >> send: aMessage [
	socket isConnected
		ifTrue: [ socket sendMessage: (self wrappeMessage: aMessage) asJsonString ]
]
