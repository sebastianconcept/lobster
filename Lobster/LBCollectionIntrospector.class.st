"
The collection introspector will visit instances creating representations that can show the collection's elements
"
Class {
	#name : #LBCollectionIntrospector,
	#superclass : #LBAbstractIntrospector,
	#category : #'Lobster-Introspection'
}

{ #category : #'as yet unclassified' }
LBCollectionIntrospector class >> batchSize [
	"Answers the maximum quantity of elements to include when building an introspection answer."

	^ 200
]

{ #category : #initialization }
LBCollectionIntrospector >> basicIntrospectAs: name id: referenceId with: references [
	|  answer |
	references at: referenceId put: introspectee.
	answer := Dictionary new
		at: #id put: referenceId;
		at: #name put: name;
		at: #printString put: introspectee printString;
		yourself.
	^ introspectee size isZero
		ifTrue: [ answer ]
		ifFalse: [ answer
				at: #isExpanded put: true;
				at: #nodes
					put:
					(self
						basicIntrospectFrom: 1
						to: (introspectee size min: self class batchSize)
						with: references);
				yourself ]
]

{ #category : #initialization }
LBCollectionIntrospector >> basicIntrospectFrom: start to: end with: references [
	^ (introspectee copyFrom: start to: end)
		withIndexCollect:
			[ :element :index | element collapsedInstrospectAs: index asString with: references ]
]

{ #category : #initialization }
LBCollectionIntrospector >> basicIntrospectWith: references [
	^ self
		basicIntrospectAs: 'self'
		id: UUID new asString36
		with: references
]

{ #category : #testing }
LBCollectionIntrospector >> canIntrospect [
	^ introspectee size > 0
]
