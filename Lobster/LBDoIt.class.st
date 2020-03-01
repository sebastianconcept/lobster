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
	^ OpalCompiler new
		options: aView compilerOptions;
		source: self sourceCode readStream;
		requestor: aView;
		compilationContext: aView compilationContext;
		evaluate
]

{ #category : #actions }
LBDoIt >> sourceCode [

	^ payload sourceCode
]
