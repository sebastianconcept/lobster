Extension { #name : #ThreadSafeTranscript }

{ #category : #'*Lobster' }
ThreadSafeTranscript >> nextPutAll: value [
	"Output string on the receiver, buffered, not yet shown"

	self
		critical: [ stream nextPutAll: value.
			LBTranscriptSignal emit: value.
			value ].
	^ value
]
