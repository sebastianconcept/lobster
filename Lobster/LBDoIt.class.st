"
This command evaluates the compiled code in the payload
"
Class {
	#name : #LBDoIt,
	#superclass : #LBMessage,
	#category : #'Lobster-Protocol'
}

{ #category : #actions }
LBDoIt >> interpretOn: aView [
	^ OpalCompiler new
		source: self sourceCode readStream;
		context: nil;
		receiver: nil;
		requestor: aView;
		failBlock: [ Transcript cr; show: 'LBDoIt fail!';flush. ^nil ];
		options: aView compilerOptions;
		evaluate
]

{ #category : #actions }
LBDoIt >> sourceCode [

	^ payload sourceCode
]
