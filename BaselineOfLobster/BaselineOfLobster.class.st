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
			self json: spec.
			spec package: 'Lobster' ]
]

{ #category : #baseline }
BaselineOfLobster >> json: spec [
	spec
		baseline: 'JSONExtensions'
		with: [ spec repository: 'github://sebastianconcept/JSONExtensions' ]
]

{ #category : #baseline }
BaselineOfLobster >> zinc: spec [
	spec
		baseline: 'ZincHTTPComponents'
		with: [ spec repository: 'github://svenvc/zinc/repository' ]
]
