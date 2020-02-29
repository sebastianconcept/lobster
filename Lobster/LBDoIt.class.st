"
This command evaluates the compiled code in the payload
"
Class {
	#name : #LBDoIt,
	#superclass : #LBMessage,
	#category : #Lobster
}

{ #category : #actions }
LBDoIt >> interpretOn: aView [

	self halt
]

{ #category : #actions }
LBDoIt >> sourceCode [

	^ payload sourceCode
]
