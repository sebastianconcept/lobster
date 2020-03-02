"
This models the view that is connected on the UI side
"
Class {
	#name : #LBModel,
	#superclass : #Object,
	#instVars : [
		'id',
		'socket',
		'theme',
		'compilationContext',
		'bindings'
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
LBModel >> bindingOf: aString [
	(self bindings includesKey: aString)
		ifFalse: [ bindings add: (WorkspaceVariable key: aString asSymbol) ].
	^ bindings associationAt: aString
]

{ #category : #accessing }
LBModel >> bindings [
	^ bindings ifNil: [ self initializeBindings ]
]

{ #category : #accessing }
LBModel >> compilationContext [
	^ compilationContext ifNil: [ self initializeCompilationContext ]
]

{ #category : #accessing }
LBModel >> compilerOptions [
	^ #(+ optionParseErrors - optionSkipSemanticWarnings)
]

{ #category : #accessing }
LBModel >> id [
	^ id
]

{ #category : #accessing }
LBModel >> initializeBindings [

	^ bindings := Dictionary new
]

{ #category : #initialization }
LBModel >> initializeCompilationContext [
	^ compilationContext := CompilationContext new
		setOptions: CompilationContext defaultOptions copy;
		yourself
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
LBModel >> interactive [
	"As requestor of a compilation context, 
	this tells the compiler that this isn't an interactive session."

	^ false
]

{ #category : #accessing }
LBModel >> notify: errorString at: location in: aStream [
	"A syntax error happened when I was trying to highlight my pc. 
	Raise a signal so that it can be ignored."

	| errorMessage |
	errorMessage := String new
		writeStreamDo: [ :stream | 
			stream
				nextPutAll: errorString;
				space;
				nextPutAll: 'at';
				space;
				nextPutAll: location asString;
				space;
				nextPutAll: 'in:';
				space;
				nextPut: $";
				nextPutAll: aStream contents;
				nextPut: $";
				yourself ].
	self error: errorMessage contents
]

{ #category : #accessing }
LBModel >> respondTo: aMessage [
	| answer |
	answer := [ aMessage interpretOn: self ]
		on: Error
		do: [ :x | x messageText ].
	socket
		sendMessage: (self wrappedAnswer: answer for: aMessage) asJsonString
]

{ #category : #accessing }
LBModel >> setBindings: aDictionary [
	bindings := aDictionary
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

{ #category : #accessing }
LBModel >> wrappedAnswer: anAnswer for: aMessage [
	^ {(#answer -> anAnswer asString).
	(#messageType -> aMessage class selector)} asDictionary
]

{ #category : #accessing }
LBModel >> wrappedAnswerOf: anAnswer [
	^ {(#answer -> anAnswer asString)} asDictionary 
]
