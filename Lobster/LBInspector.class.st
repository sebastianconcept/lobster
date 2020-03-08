"
A model for the Inspector tool
"
Class {
	#name : #LBInspector,
	#superclass : #LBViewModel,
	#instVars : [
		'inspectee'
	],
	#category : #'Lobster-ViewModels'
}

{ #category : #accessing }
LBInspector >> inspectee [
	^ inspectee
]

{ #category : #accessing }
LBInspector >> inspectee: anObject [
	inspectee := anObject
]
