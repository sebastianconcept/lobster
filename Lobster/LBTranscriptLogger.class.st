"
This signal logger will send the emitted messages to the LBTranscript 
"
Class {
	#name : #LBTranscriptLogger,
	#superclass : #TranscriptLogger,
	#category : #'Lobster-Helpers'
}

{ #category : #registering }
LBTranscriptLogger >> nextPut: anAnnouncement [
	Transcript crShow: anAnnouncement
]
