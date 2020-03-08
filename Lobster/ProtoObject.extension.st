Extension { #name : #ProtoObject }

{ #category : #'*Lobster' }
ProtoObject >> asLobsterPayload [
	"Default for everybody"
	^ self printString
]

{ #category : #'*Lobster' }
ProtoObject >> printString [

	^ 'a ProtoObject'
]
