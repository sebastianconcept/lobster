"
This signal logger will send the emitted messages to the LBTranscript 
"
Class {
	#name : #LBTranscriptLogger,
	#superclass : #SignalLogger,
	#instVars : [
		'transcript'
	],
	#category : #'Lobster-Helpers'
}

{ #category : #'instance creation' }
LBTranscriptLogger class >> on: anLBTranscript [

	^ self new
		initializeOn: anLBTranscript;
		yourself
]

{ #category : #registering }
LBTranscriptLogger >> initializeOn: anLBTranscript [
	transcript := anLBTranscript
]

{ #category : #registering }
LBTranscriptLogger >> nextPut: anAnnouncement [
	transcript onNextPut: anAnnouncement
]
