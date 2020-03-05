"
This is a replacement of the system transcript so we can safely install and override methods in order to adequately relate to the LBTranscript ViewModel.
"
Class {
	#name : #LBSystemTranscript,
	#superclass : #ThreadSafeTranscript,
	#category : #'Lobster-Helpers'
}

{ #category : #declare }
LBSystemTranscript class >> install [
	<script>

	Smalltalk globals at: #Transcript put: (self new)
]

{ #category : #accessing }
LBSystemTranscript >> nextPutAll: value [
	"Output string on the receiver, buffered, not yet shown"

	self
		critical: [ stream nextPutAll: value.
			LBTranscriptSignal emit: value.
			value ].
	^ value
]
