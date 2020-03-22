"
The object introspector can visit instances of classes and create JSON friendly models to use in the UI side.

It will create a dictionary modeling a node in the introspector's component tree.
"
Class {
	#name : #LBAbstractIntrospector,
	#superclass : #Object,
	#instVars : [
		'introspectee'
	],
	#category : #'Lobster-Introspection'
}

{ #category : #'instance creation' }
LBAbstractIntrospector class >> on: anObject [
	^ self new
		initializeOn: anObject;
		yourself
]

{ #category : #action }
LBAbstractIntrospector >> basicCollapsedIntrospectAs: name with: references [
	| referenceId answer |
	referenceId := UUID new asString36.
	references at: referenceId put: introspectee.
	answer := Dictionary new
		at: #id put: referenceId;
		at: #name put: name;
		at: #printString put: introspectee printString;
		yourself.
	^ self canIntrospect
		ifFalse: [ answer ]
		ifTrue: [ answer
				at: #nodes put: '...';
				yourself ]
]

{ #category : #initialization }
LBAbstractIntrospector >> basicIntrospectWith: references [

	^ self subclassResponsibility 
]

{ #category : #testing }
LBAbstractIntrospector >> canIntrospect [
	^ self subclassResponsibility
]

{ #category : #initialization }
LBAbstractIntrospector >> initializeOn: anObject [

	introspectee := anObject 
]
