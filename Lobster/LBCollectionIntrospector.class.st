"
The collection introspector will visit instances creating representations that can show the collection's elements
"
Class {
	#name : #LBCollectionIntrospector,
	#superclass : #LBAbstractIntrospector,
	#instVars : [
		'batch',
		'loadMoreId'
	],
	#category : #'Lobster-Introspection'
}

{ #category : #'as yet unclassified' }
LBCollectionIntrospector class >> batchSize [
	"Answers the maximum quantity of elements to include when building an introspection answer."

	^ 200
]

{ #category : #actions }
LBCollectionIntrospector >> basicIntrospectAs: name id: referenceId with: references for: anIntrospector [
	| answer end elements |
	references at: referenceId put: introspectee.
	answer := Dictionary new
		at: #id put: referenceId;
		at: #name put: name;
		at: #printString put: introspectee printString;
		yourself.
	^ introspectee size isZero
		ifTrue: [ answer ]
		ifFalse: [ end := self end.
			elements := (self
				basicIntrospectFrom: self start
				to: end
				with: references) asOrderedCollection.
			introspectee size > end
				ifTrue: [ loadMoreId := UUID new asString36.
					anIntrospector callbacks
						at: loadMoreId
						put: [ self nextBatchWith: references ].
					elements
						addLast:
							{(#loadMoreId -> loadMoreId).
							(#name -> '').
							(#printString -> 'load more...')} asDictionary ].
			answer
				at: #isExpanded put: true;
				at: #nodes put: elements;
				yourself ]
]

{ #category : #actions }
LBCollectionIntrospector >> basicIntrospectFrom: start to: end with: references [
	^ (introspectee copyFrom: start to: end)
		withIndexCollect: [ :element :index | 
			element
				collapsedInstrospectAs: (start + index - 1) asString
				with: references ]
]

{ #category : #actions }
LBCollectionIntrospector >> basicIntrospectWith: references for: anIntrospector [
	^ self
		basicIntrospectAs: 'self'
		id: UUID new asString36
		with: references
		for: anIntrospector
]

{ #category : #accessing }
LBCollectionIntrospector >> batch [
	^ batch ifNil: [ self initializeBatch ]
]

{ #category : #testing }
LBCollectionIntrospector >> canIntrospect [
	^ introspectee size > 0
]

{ #category : #accessing }
LBCollectionIntrospector >> end [
	^ introspectee size min: self start + self class batchSize - 1
]

{ #category : #initialization }
LBCollectionIntrospector >> initializeBatch [
	^ batch := 1
]

{ #category : #actions }
LBCollectionIntrospector >> nextBatchWith: references [
	| end elements |
	batch := batch + 1.
	end := self end.
	elements := (self
		basicIntrospectFrom: self start
		to: end
		with: references) asOrderedCollection.
	introspectee size > end
		ifTrue: [ elements
				addLast:
					{(#loadMoreId -> loadMoreId).
					(#name -> '').
					(#printString -> 'load more...')} asDictionary ].
	^ Dictionary new
		at: #elements put: elements;
		at: #loadMoreId put: loadMoreId;
		yourself
]

{ #category : #accessing }
LBCollectionIntrospector >> start [
	^ 1 + ((self batch - 1) * self class batchSize)
]
