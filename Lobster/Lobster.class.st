"
Main class for the Lobster project.

From here it all starts/stops.

I holds the server which will serve and delegate comunication between the UI and the models used to do everything with what's in the image.
"
Class {
	#name : #Lobster,
	#superclass : #Object,
	#classInstVars : [
		'server'
	],
	#category : #'Lobster-Core'
}

{ #category : #accessing }
Lobster class >> initializeServer [
	^ server := LBServer new
]

{ #category : #accessing }
Lobster class >> restart [
	self
		stop;
		start
]

{ #category : #accessing }
Lobster class >> server [
	^ server ifNil: [ server := self initializeServer ]
]

{ #category : #accessing }
Lobster class >> shutDown: quiting [
	quiting
		ifTrue: [ self stop ]
]

{ #category : #accessing }
Lobster class >> start [

	LBLog log: 'Starting to lobster this...'.
	self server start
]

{ #category : #accessing }
Lobster class >> startUp: resuming [
	resuming
		ifTrue: [ self environment
				at: #SessionManager
				ifPresent: [ :manager | 
					manager default currentSession
						addDeferredStartupAction: [ self restart ] ]
				ifAbsent: [ Smalltalk addDeferredStartupAction: [ self restart ] ] ]
]

{ #category : #accessing }
Lobster class >> stop [
	LBLog log: 'Stopping lobster'.
	server ifNotNil: [ self server stop ]
]
