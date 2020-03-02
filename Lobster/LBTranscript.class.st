"
A model for the Transcript
"
Class {
	#name : #LBTranscript,
	#superclass : #LBModel,
	#category : #'Lobster-Models'
}

{ #category : #initialization }
LBTranscript >> setObservationsOn: aLBServer [
	aLBServer announcer
		when: LBTranscriptEntry
		do: [ :ann | self send: (LBTranscriptMessage on: ann message) ]
]
