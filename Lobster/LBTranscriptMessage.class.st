"
This should happen when you want a new LBTranscript to be shown
"
Class {
	#name : #LBTranscriptMessage,
	#superclass : #LBMessage,
	#instVars : [
		'message'
	],
	#category : #'Lobster-Protocol'
}

{ #category : #accessing }
LBTranscriptMessage class >> on: anLBTranscriptSignal [
	^ self new
		initializeOn: anLBTranscriptSignal;
		yourself
]

{ #category : #converting }
LBTranscriptMessage >> asPayload [

	^ message
]

{ #category : #accessing }
LBTranscriptMessage >> initializeOn: anLBTranscriptSignal [

	message := anLBTranscriptSignal message
]

{ #category : #accessing }
LBTranscriptMessage >> message [
	^ message
]
