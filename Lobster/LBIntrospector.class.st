"
This models the tree showing instVars of an object.
Typically used in inspectors
"
Class {
	#name : #LBIntrospector,
	#superclass : #LBViewModel,
	#instVars : [
		'references'
	],
	#category : #'Lobster-ViewModels'
}

{ #category : #initialization }
LBIntrospector >> initializeReferences [
	^ references := Dictionary new
]

{ #category : #accessing }
LBIntrospector >> references [
	^ references ifNil: [ self initializeReferences ]
]

{ #category : #accessing }
LBIntrospector >> references: aDictionary [
	references := aDictionary
]
