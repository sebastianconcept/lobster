"
This is to wrap any unsupported message
"
Class {
	#name : #LBUnsupported,
	#superclass : #LBMessage,
	#category : #'Lobster-Protocol'
}

{ #category : #actions }
LBUnsupported >> interpretOn: aView [
	^ {(#error -> ('Unsupported message: "' , payload asString , '"'))}
		asDictionary asJsonString
]
