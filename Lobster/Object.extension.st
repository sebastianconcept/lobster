Extension { #name : #Object }

{ #category : #'*Lobster' }
Object >> asLobsterPayload [
	"Default for everybody (except ProtoObject)"
	^ self asJsonString
]
