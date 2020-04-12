Extension { #name : #Symbol }

{ #category : #'*Lobster' }
Symbol >> asLobsterPayload [
	"Default for everybody (except ProtoObject)"
	^ self printString asJsonString
]
