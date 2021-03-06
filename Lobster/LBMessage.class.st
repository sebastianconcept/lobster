"
LBMessage subclasses are the models of the commands sent by the UI side that are being able to be interpreted here in the server side.
"
Class {
	#name : #LBMessage,
	#superclass : #Object,
	#instVars : [
		'payload'
	],
	#category : #'Lobster-Protocol'
}

{ #category : #accessing }
LBMessage class >> for: aMessage [
	| payload |
	[ payload := Json readFrom: aMessage readStream ]
		on: Error
		do: [ :x | ^ LBUnsupported on: aMessage ].
	^ (self messageClassFor: payload type) on: payload
]

{ #category : #accessing }
LBMessage class >> messageClassFor: aMessageType [

	^ self allSubclasses
		detect: [ :messageClass | 
			messageClass isAbstract not
				and: [ messageClass selector = aMessageType ] ]
		ifNone: [ LBUnsupported ]
]

{ #category : #accessing }
LBMessage class >> on: aPayload [
	^ self new
		initializeOn: aPayload;
		yourself
]

{ #category : #accessing }
LBMessage class >> selector [
	^ [ :string | string copyFrom: 3 to: string size ]
		value: self name asString
]

{ #category : #converting }
LBMessage >> asPayload [

	self subclassResponsibility 
]

{ #category : #accessing }
LBMessage >> id [
	^ payload id
]

{ #category : #actions }
LBMessage >> initializeOn: aPayload [

	payload := aPayload
]

{ #category : #actions }
LBMessage >> interpretOn: aView [

	self subclassResponsibility 
]

{ #category : #accessing }
LBMessage >> payload [
	^ payload
]

{ #category : #actions }
LBMessage >> sentTo: aViewModel [
	| answer |
	answer := [ self interpretOn: aViewModel ]
		on: Error
		do: [ :x | x messageText ].
	"Send a response:"
	aViewModel sendMessage: (self wrappedAnswer: answer) asJsonString
]

{ #category : #accessing }
LBMessage >> wrappedAnswer: anAnswer [
	^ {(#answer -> anAnswer asJsonString).
	(#messageType -> self class selector)} asDictionary
]
