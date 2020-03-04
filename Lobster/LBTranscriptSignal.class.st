"
This should happen when you want a new message to be shown in LBTranscript
"
Class {
	#name : #LBTranscriptSignal,
	#superclass : #StringSignal,
	#category : #'Lobster-Announcements'
}

{ #category : #'instance creation' }
LBTranscriptSignal class >> on: aString [
	^ self new
		message: aString;
		yourself
]
