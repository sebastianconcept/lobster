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
	#category : #'Lobster-Helpers'
}

{ #category : #'instance creation' }
LBAbstractIntrospector class >> on: anObject [
	^ self new
		initializeOn: anObject;
		yourself
]

{ #category : #action }
LBAbstractIntrospector >> basicIntrospectWith: references [

	^ self basicIntrospectOn: Dictionary new with: references
]

{ #category : #initialization }
LBAbstractIntrospector >> initializeOn: anObject [

	introspectee := anObject 
]
