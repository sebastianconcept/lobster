Extension { #name : #ProtoObject }

{ #category : #'*Lobster' }
ProtoObject >> asLobsterPayload [
	"Default for everybody"
	^ self printString
]

{ #category : #'*Lobster' }
ProtoObject >> collapsedInstrospectAs: name with: references [

	^ (self class introspectionSupporFor: self) basicCollapsedIntrospectAs: name with: references
]

{ #category : #'*Lobster' }
ProtoObject >> introspectAs: name id: anId with: references for: anIntrospector [
	^ (self class introspectionSupporFor: self)
		basicIntrospectAs: name
		id: anId
		with: references
		for: anIntrospector
]

{ #category : #'*Lobster' }
ProtoObject >> introspectAs: name with: references for: anIntrospector [
	^ (self class introspectionSupporFor: self)
		basicIntrospectAs: name
		with: references
		for: anIntrospector
]

{ #category : #'*Lobster' }
ProtoObject >> introspectWith: references for: anIntrospector [
	^ (self class introspectionSupporFor: self)
		basicIntrospectWith: references
		for: anIntrospector
]

{ #category : #'*Lobster' }
ProtoObject class >> introspectionSupporFor: anInstance [
	^ (self introspectionSupports
		at: anInstance class classLayout class
		ifAbsent: [ LBObjectIntrospector ]) on: anInstance
]

{ #category : #'*Lobster' }
ProtoObject class >> introspectionSupports [
	^ Dictionary new
		at: FixedLayout put: LBObjectIntrospector;
		at: VariableLayout put: LBCollectionIntrospector;
		yourself
]

{ #category : #'*Lobster' }
ProtoObject >> printString [

	^ 'a ProtoObject'
]
