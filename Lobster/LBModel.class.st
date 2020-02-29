"
This models the view that is connected on the UI side
"
Class {
	#name : #LBModel,
	#superclass : #Object,
	#instVars : [
		'id',
		'socket',
		'theme'
	],
	#category : #Lobster
}

{ #category : #accesing }
LBModel class >> defaultTheme [

	^ #minimal
]

{ #category : #'instance creation' }
LBModel class >> fromMessage: aHandshakeMessage on: aWebSocket [
	aHandshakeMessage class == LBHandshake
		ifFalse: [ self error: 'A handshake message was expected' ].
	^ (self modelFor: aHandshakeMessage viewType) new
		initializeOn: aHandshakeMessage from: aWebSocket;
		yourself
]

{ #category : #accesing }
LBModel class >> isAbstract [

	^ self == LBModel
]

{ #category : #accesing }
LBModel class >> modelFor: aViewType [
	^ self subclasses
		detect:
			[ :modelClass | modelClass isAbstract not and: [ modelClass selector = aViewType ] ]
		ifNone: [ self error: 'No model found for view: ' , aViewType asString ]
]

{ #category : #accesing }
LBModel class >> selector [
	^ [ :string | string copyFrom: 3 to: string size ]
		value: self name asString
]

{ #category : #accessing }
LBModel >> id [
	^ id
]

{ #category : #initialization }
LBModel >> initializeOn: aHandshakeMessage from: aWebSocket [
	id := aHandshakeMessage id.
	socket := aWebSocket.
	aHandshakeMessage theme
		ifNotNil: [ theme := aHandshakeMessage theme ]
]

{ #category : #accessing }
LBModel >> initializeTheme [
	^ theme := self class defaultTheme
]

{ #category : #accessing }
LBModel >> respondTo: aMessage [

	| answer |
	answer := aMessage interpretOn: self.
	self halt.
	socket sendMailMessage: answer asString
]

{ #category : #accessing }
LBModel >> socket [
	^ socket
]

{ #category : #accessing }
LBModel >> theme [
	^ theme ifNil: [ self initializeTheme ]
]

{ #category : #accessing }
LBModel >> theme: anObject [
	theme := anObject
]
