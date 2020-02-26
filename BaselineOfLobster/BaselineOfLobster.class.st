Class {
	#name : #BaselineOfLobster,
	#superclass : #BaselineOf,
	#category : #BaselineOfLobster
}

{ #category : #baseline }
BaselineOfLobster >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self zinc: spec.
			spec package: 'Lobster' ]
]

{ #category : #baseline }
BaselineOfLobster >> zinc: spec [
	spec
		baseline: 'ZincHTTPComponents'
		with: [ spec repository: 'github://svenvc/zinc/repository' ]
]
