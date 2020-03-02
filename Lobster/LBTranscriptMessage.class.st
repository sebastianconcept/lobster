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
LBTranscriptMessage class >> on: aString [
	^ self new
		message: aString;
		yourself
]

{ #category : #converting }
LBTranscriptMessage >> asPayload [

	^ message
]

{ #category : #accessing }
LBTranscriptMessage >> message [
	^ message
]

{ #category : #accessing }
LBTranscriptMessage >> message: anObject [
	message := anObject
]
