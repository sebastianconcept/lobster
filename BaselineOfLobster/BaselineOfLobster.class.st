Class {
	#name : #BaselineOfLobster,
	#superclass : #BaselineOf,
	#category : #BaselineOfLobster
}

{ #category : #baseline }
BaselineOfLobster >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec package: 'obster' ]
]
