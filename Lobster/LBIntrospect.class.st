"
Command to answer the representation of introspecting an instVar in a given object.
"
Class {
	#name : #LBIntrospect,
	#superclass : #LBMessage,
	#category : #'Lobster-Protocol'
}

{ #category : #actions }
LBIntrospect >> basicInterpretOn: aViewModel [
	| introspectee |
	introspectee := aViewModel references at: payload nodeSpec id.
	^ introspectee
		introspectAs: payload nodeSpec name
		id: payload nodeSpec id
		with: aViewModel references
]

{ #category : #actions }
LBIntrospect >> interpretOn: aViewModel [
	^ [ (self basicInterpretOn: aViewModel) asJsonString ]
		on: SyntaxErrorNotification
		do: [ :x | x messageText ]
]
