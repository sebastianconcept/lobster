Class {
	#name : #Lobster,
	#superclass : #Object,
	#classInstVars : [
		'server'
	],
	#category : #Lobster
}

{ #category : #accessing }
Lobster class >> initializeServer [
	^ server := LBServer new
]

{ #category : #accessing }
Lobster class >> server [
	^ server ifNil: [ server := self initializeServer ]
]

{ #category : #accessing }
Lobster class >> start [

	LBLog log: 'Competent lobsters stands up straight with their shoulders back!'.
	self server start
]

{ #category : #accessing }
Lobster class >> stop [
	LBLog log: 'A good lobster like you always keep your room clean'.
	self server stop
]
