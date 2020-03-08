"
Supports interpretation of a DoIt that will end up answering what's needed to inspect the resulting object.

"
Class {
	#name : #LBInspectIt,
	#superclass : #LBDoIt,
	#category : #'Lobster-Protocol'
}

{ #category : #actions }
LBInspectIt >> basicInterpretOn: aViewModel [
	
	| subject |
	subject := super basicInterpretOn: aViewModel.
	aViewModel inspectee: subject.
	^ subject 
]
