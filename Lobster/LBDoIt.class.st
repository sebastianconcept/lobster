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
	^ [ OpalCompiler new
		source: self sourceCode;
		evaluate ]
		on: Error
		do: [ :x | x messageText ]
]

{ #category : #actions }
LBDoIt >> sourceCode [

	^ payload sourceCode
]
