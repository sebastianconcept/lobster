"
This command evaluates the compiled code in the payload
"
Class {
	#name : #LBDoIt,
	#superclass : #LBMessage,
	#category : #'Lobster-Protocol'
}

{ #category : #actions }
LBDoIt >> basicInterpretOn: aViewModel [
	^ OpalCompiler new
		source: self sourceCode readStream;
		context: nil;
		receiver: aViewModel selfObject;
		requestor: aViewModel;
		failBlock: [ ^ nil ];
		options: aViewModel compilerOptions;
		evaluate
]

{ #category : #actions }
LBDoIt >> interpretOn: aViewModel [
	| answer |
	^ [ answer := self basicInterpretOn: aViewModel.
	answer printString ]
		on: SyntaxErrorNotification
		do: [ :x | x messageText ]
]

{ #category : #actions }
LBDoIt >> sourceCode [

	^ payload sourceCode
]
