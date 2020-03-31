"
The collection introspector will visit instances creating representations that can show the collection's elements
"
Class {
	#name : #LBCollectionIntrospector,
	#superclass : #LBAbstractIntrospector,
	#instVars : [
		'batch'
	],
	#category : #'Lobster-Introspection'
}

{ #category : #'as yet unclassified' }
LBCollectionIntrospector class >> batchSize [
	"Answers the maximum quantity of elements to include when building an introspection answer."

	^ 200
]

{ #category : #initialization }
LBCollectionIntrospector >> basicIntrospectAs: name id: referenceId with: references for: anIntrospector [
	| answer children end loadMoreId start |
	references at: referenceId put: introspectee.
	answer := Dictionary new
		at: #id put: referenceId;
		at: #name put: name;
		at: #printString put: introspectee printString;
		yourself.
	^ introspectee size isZero
		ifTrue: [ answer ]
		ifFalse: [ start := 1 + ((self batch - 1) * self class batchSize).
			end := introspectee size min: start + self class batchSize.
			children := (self
				basicIntrospectFrom: start
				to: end
				with: references) asOrderedCollection.
			introspectee size > end
				ifTrue: [ loadMoreId := UUID new asString36.
					anIntrospector callbacks
						at: loadMoreId
						put: [ self nextBatchWith: references as: loadMoreId].
					children
						addLast:
							{(#loadMoreId -> loadMoreId).
							(#name -> (end + 1) asString).
							(#printString -> 'more...')} asDictionary ].
			answer
				at: #isExpanded put: true;
				at: #nodes put: children;
				yourself ]
]

{ #category : #initialization }
LBCollectionIntrospector >> basicIntrospectFrom: start to: end with: references [
	^ (introspectee copyFrom: start to: end)
		withIndexCollect: [ :element :index | 
			element
				collapsedInstrospectAs: index asString
				with: references ]
]

{ #category : #initialization }
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

{ #category : #initialization }
LBCollectionIntrospector >> initializeBatch [
	^ batch := 1
]

{ #category : #actions }
LBCollectionIntrospector >> nextBatchWith: references as: loadMoreId [
	| start end |
	batch := batch + 1.
	start := 1 + ((batch - 1) * self class batchSize).
	end := introspectee size min: start + self class batchSize - 1.
	^ Dictionary new
		at: #elements
			put:
			(self basicIntrospectFrom: start to: end with: references)
				asOrderedCollection;
		at: #loadMoreId put: loadMoreId;
		yourself
]
