"
The server has the http WebSocket server and knows how to delegate messages to the right models.
It keeps models of the connected views
"
Class {
	#name : #LBServer,
	#superclass : #Object,
	#instVars : [
		'zinc',
		'views',
		'announcer'
	],
	#category : #'Lobster-Core'
}

{ #category : #accessing }
LBServer class >> port [
	| value |
	value := OSEnvironment current at: 'PORT' ifAbsent: [  ].
	^ value asInteger ifNil: [ 1701 ] ifNotNil: [ value asInteger ]
]

{ #category : #actions }
LBServer >> announce: anAnnouncement [ 

	^ self announcer announce: anAnnouncement 
]

{ #category : #accessing }
LBServer >> announcer [
	^ announcer ifNil: [ self initializeAnnouncer ]
]

{ #category : #initialization }
LBServer >> initializeAnnouncer [
	^ announcer := Announcer new
]

{ #category : #initialization }
LBServer >> initializeViews [
	^ views := Dictionary new
]

{ #category : #initialization }
LBServer >> initializeZinc [
	^ zinc := (ZnServer startOn: self class port)
		delegate:
			(ZnWebSocketDelegate
				handler: [ :webSocket | self onWebSocketConnected: webSocket ]);
		yourself
]

{ #category : #actions }
LBServer >> observeViewModel: aViewModel with: aWebSocket [
	aViewModel
		when: #viewModelClosed
		send: #onViewModelClosed:socket:
		to: self
		withArguments:
			{aViewModel.
			aWebSocket}
]

{ #category : #reactions }
LBServer >> onMessage: aMessageString from: aWebSocket [
	"Receives aMessage from the connection with aWebSocket.
	Makess the interpretation and sends a response."

	| view message newViewModel |
	message := LBMessage for: aMessageString.
	view := self views
		at: aWebSocket
		ifAbsentPut: [ newViewModel := LBViewModel
				fromMessage: message
				on: aWebSocket
				for: self.
			self triggerEvent: #viewModelOpened: with: newViewModel.
			newViewModel ].
	message sentTo: view
]

{ #category : #reactions }
LBServer >> onSocketClosed: aWebSocket [
	views ifNotNil: [ views removeKey: aWebSocket ifAbsent: [ nil ] ]
]

{ #category : #reactions }
LBServer >> onViewModelClosed: aViewModel socket: aWebSocket [
	views ifNotNil: [ views removeKey: aWebSocket ifAbsent: [ nil ] ].
	self triggerEvent: #onViewModelClosed: with: aViewModel.
	aViewModel removeDependent: self
]

{ #category : #reactions }
LBServer >> onWebSocketConnected: aWebSocket [
	^ self
		run: aWebSocket
		with: [ :message | self onMessage: message from: aWebSocket ]
]

{ #category : #reactions }
LBServer >> run: aWebSocket with: aBlock [
	^ [ [ | message |
	message := nil.
	[ aWebSocket isConnected
		ifTrue: [ message := aWebSocket readMessage ]
		ifFalse: [ ConnectionClosed signal ] ]
		on: ConnectionTimedOut
		do: [ "Ignore & continue" aWebSocket ping ].
	message ifNotNil: [ aBlock value: message ] ] repeat ]
		on: ConnectionClosed
		do: [ :x | self onSocketClosed: aWebSocket ]
]

{ #category : #actions }
LBServer >> start [
	LBLog log: 'Lobster listening on ', self class port asString.
	self zinc 
]

{ #category : #actions }
LBServer >> stop [
	zinc
		ifNotNil: [ zinc stop.
			announcer := nil.
			zinc := nil ].
	views ifNotNil: [ views valuesDo: [ :view | view close ] ].
	views := nil
]

{ #category : #accessing }
LBServer >> views [
	^ views ifNil: [ views := self initializeViews ]
]

{ #category : #accessing }
LBServer >> zinc [
	^ zinc ifNil: [ zinc := self initializeZinc ]
]
