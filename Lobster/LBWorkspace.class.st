"
A model for the Worspace tool
"
Class {
	#name : #LBWorkspace,
	#superclass : #LBViewModel,
	#instVars : [
		'inspectees'
	],
	#category : #'Lobster-ViewModels'
}

{ #category : #accessing }
LBWorkspace >> initializeInspectees [
	^ inspectees := Dictionary new
]

{ #category : #accessing }
LBWorkspace >> inspectees [
	^ inspectees ifNil: [ self initializeInspectees ]
]
