"
This is to wrap any unsupported message
"
Class {
	#name : #LBUnsupported,
	#superclass : #LBMessage,
	#category : #Lobster
}

{ #category : #actions }
LBUnsupported >> interpretOn: aView [
	^ {(#error -> ('Unsupported message: "' , payload asString , '"'))}
		asDictionary asJsonString
]
