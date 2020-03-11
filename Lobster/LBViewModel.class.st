"
Views on the UI frontend will be connected to instances of ViewModels here in the server side.

As typically Smalltalk tools do, I preserve the temp variables that get created from assignations to undefined literals. These will be made WorkspaceVariable and preserved in bindings.
"
Class {
	#name : #LBViewModel,
	#superclass : #Object,
	#instVars : [
		'id',
		'name',
		'socket',
		'theme',
		'bindings',
		'selfObject'
	],
	#category : #'Lobster-ViewModels'
}

{ #category : #accesing }
LBViewModel class >> defaultTheme [

	^ #minimal
]

{ #category : #'instance creation' }
LBViewModel class >> fromMessage: aHandshakeMessage on: aWebSocket for: aLBServer [
	aHandshakeMessage class == LBHandshake
		ifFalse: [ self error: 'A handshake message was expected' ].
	^ (self modelFor: aHandshakeMessage viewType) new
		initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer;
		yourself
]

{ #category : #accesing }
LBViewModel class >> isAbstract [

	^ self == LBViewModel
]

{ #category : #accesing }
LBViewModel class >> modelFor: aViewType [
	^ self subclasses
		detect:
			[ :modelClass | modelClass isAbstract not and: [ modelClass selector = aViewType ] ]
		ifNone: [ self error: 'No model found for view: ' , aViewType asString ]
]

{ #category : #accesing }
LBViewModel class >> selector [
	^ [ :string | string copyFrom: 3 to: string size ]
		value: self name asString
]

{ #category : #accessing }
LBViewModel >> addBindings: someBindings [
	
	self flag: #toBeImplemented
]

{ #category : #accessing }
LBViewModel >> bindingOf: aString [
	(self bindings includesKey: aString)
		ifFalse: [ bindings add: (WorkspaceVariable key: aString asSymbol) ].
	^ bindings associationAt: aString
]

{ #category : #accessing }
LBViewModel >> bindings [
	^ bindings ifNil: [ self initializeBindings ]
]

{ #category : #actions }
LBViewModel >> close [
	bindings ifNotNil: [ bindings := nil ].
	selfObject := nil.
	self closeSocket.

]

{ #category : #actions }
LBViewModel >> closeSocket [
	socket
		ifNotNil: [ socket isConnected
				ifTrue: [ socket close ].
			socket := nil ]
]

{ #category : #accessing }
LBViewModel >> compilerOptions [
	^ #(+ optionParseErrors - optionSkipSemanticWarnings)
]

{ #category : #accessing }
LBViewModel >> getViewModelFrom: spec [
	^ Lobster server views values
		detect: [ :each | each id = spec id ]
		ifNone: [ self
				error: 'ViewModel not found: ' , spec id , ' (' , spec name , ')' ]
]

{ #category : #accessing }
LBViewModel >> id [
	^ id
]

{ #category : #initialization }
LBViewModel >> initializeBindings [

	^ bindings := Dictionary new
]

{ #category : #initialization }
LBViewModel >> initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer [
	id := aHandshakeMessage id.
	name := aHandshakeMessage name.
	socket := aWebSocket.
	aHandshakeMessage theme
		ifNotNil: [ theme := aHandshakeMessage theme ]
]

{ #category : #initialization }
LBViewModel >> initializeTheme [
	^ theme := self class defaultTheme
]

{ #category : #accessing }
LBViewModel >> interactive [
	"As requestor of a compilation context, 
	this tells the compiler that this isn't an interactive session."

	^ false
]

{ #category : #accessing }
LBViewModel >> name [
	^ name
]

{ #category : #reactions }
LBViewModel >> onClosed [
	self close.
	self triggerEvent: #viewClosed
]

{ #category : #reactions }
LBViewModel >> onOpened [

	self triggerEvent: #viewOpened
]

{ #category : #accessing }
LBViewModel >> replaceBindings: someBindings [
	
	self flag: #toBeImplemented
]

{ #category : #accessing }
LBViewModel >> selfObject [
	^ selfObject
]

{ #category : #accessing }
LBViewModel >> selfObject: anObject [
	selfObject := anObject 
]

{ #category : #accessing }
LBViewModel >> send: aMessage [

	socket isConnected
		ifFalse: [ self error: 'Trying to send a message over a disconnected socket' ]
		ifTrue: [ socket sendMessage: (self wrappeMessage: aMessage) asJsonString ]
]

{ #category : #accessing }
LBViewModel >> sendMessage: aJsonString [

	^ self socket sendMessage: aJsonString 
]

{ #category : #accessing }
LBViewModel >> setBindings: aDictionary [
	bindings := aDictionary
]

{ #category : #accessing }
LBViewModel >> socket [
	^ socket
]

{ #category : #accessing }
LBViewModel >> theme [
	^ theme ifNil: [ self initializeTheme ]
]

{ #category : #accessing }
LBViewModel >> theme: anObject [
	theme := anObject
]

{ #category : #accessing }
LBViewModel >> wrappeMessage: aMessage [
	^ {(#payload -> aMessage asPayload).
	(#messageType -> aMessage class selector)} asDictionary
]

{ #category : #accessing }
LBViewModel >> wrappedAnswer: anAnswer for: aMessage [
	^ {(#answer -> anAnswer asString).
	(#messageType -> aMessage class selector)} asDictionary
]

{ #category : #accessing }
LBViewModel >> wrappedAnswerOf: anAnswer [
	^ {(#answer -> anAnswer asString)} asDictionary 
]
