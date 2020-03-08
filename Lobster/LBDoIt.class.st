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
		receiver: nil;
		requestor: aViewModel;
		failBlock: [ ^ nil ];
		options: aViewModel compilerOptions;
		evaluate
]

{ #category : #actions }
LBDoIt >> interpretOn: aViewModel [
	^ [ self basicInterpretOn: aViewModel ]
		on: SyntaxErrorNotification
		do: [ :x | x messageText ]
]

{ #category : #actions }
LBDoIt >> sourceCode [

	^ payload sourceCode
]
