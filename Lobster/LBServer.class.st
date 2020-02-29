"
The server has the http WebSocket server and knows how to delegate messages to the right models.
It keeps models of the connected views
"
Class {
	#name : #LBServer,
	#superclass : #Object,
	#instVars : [
		'zinc',
		'views'
	],
	#category : #Lobster
}

{ #category : #accessing }
LBServer class >> port [
	| value |
	value := OSEnvironment current at: 'PORT' ifAbsent: [  ].
	^ value asInteger ifNil: [ 1701 ] ifNotNil: [ value asInteger ]
]

{ #category : #accessing }
LBServer >> initializeViews [
	^ views := Dictionary new
]

{ #category : #accessing }
LBServer >> initializeZinc [
	^ zinc := (ZnServer startOn: self class port)
		delegate:
			(ZnWebSocketDelegate
				handler: [ :webSocket | self onWebSocketConnected: webSocket ]);
		yourself
]

{ #category : #reactions }
LBServer >> onMessage: aMessageString from: aWebSocket [
	"Receives aMessage from the connection with aWebSocket.
	Makess the interpretation and sends a response."

	| view message |
	message := LBMessage for: aMessageString.
	view := self views
		at: aWebSocket
		ifAbsentPut: [ LBModel fromMessage: message on: aWebSocket ].
	view respondTo: message
]

{ #category : #reactions }
LBServer >> onWebSocketConnected: aWebSocket [
	^ [ aWebSocket
		runWith: [ :message | self onMessage: message from: aWebSocket ] ]
		on: ConnectionClosed
		do: [ aWebSocket logGeneric: 'Ignoring connection close, done' ]
]

{ #category : #accessing }
LBServer >> start [
	LBLog log: 'Lobster listening on ', self class port asString.
	self zinc 
]

{ #category : #accessing }
LBServer >> stop [
	zinc
		ifNotNil: [ zinc stop.
			zinc := nil ]
]

{ #category : #accessing }
LBServer >> views [
	^ views ifNil: [ views := self initializeViews ]
]

{ #category : #accessing }
LBServer >> zinc [
	^ zinc ifNil: [ zinc := self initializeZinc ]
]
