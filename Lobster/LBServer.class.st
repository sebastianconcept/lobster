Class {
	#name : #LBServer,
	#superclass : #Object,
	#instVars : [
		'zinc'
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
LBServer >> initializeZinc [
	^ zinc := (ZnServer startOn: self class port)
		delegate: (ZnWebSocketDelegate handler: self);
		yourself
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
LBServer >> value: aWebSocket [
	^ [ :webSocket | 
	[ webSocket
		runWith: [ :message | 
			webSocket
				logGeneric: 'Received message: ' , message printString , ', echoing'.
			LBLog log: 'Received message: ' , message printString.
			webSocket sendMessage: 'Lobster says:' , message ] ]
		on: ConnectionClosed
		do: [ webSocket logGeneric: 'Ignoring connection close, done' ] ]
		value: aWebSocket
]

{ #category : #accessing }
LBServer >> zinc [
	^ zinc ifNil: [ zinc := self initializeZinc ]
]
