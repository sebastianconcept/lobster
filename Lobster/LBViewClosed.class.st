"
Sent by clients when their view was destroyed
"
Class {
	#name : #LBViewClosed,
	#superclass : #LBMessage,
	#category : #'Lobster-Protocol'
}

{ #category : #actions }
LBViewClosed >> interpretOn: aViewModel [

	aViewModel close.
	
	^ true
]

{ #category : #actions }
LBViewClosed >> sentTo: aViewModel [

	[self interpretOn: aViewModel ]
		on: Error
		do: [ :x | Transcript crShow: x messageText ].
	
]
