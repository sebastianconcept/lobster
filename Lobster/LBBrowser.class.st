"
A model for the Class Hierarchy Browser tool
"
Class {
	#name : #LBBrowser,
	#superclass : #LBViewModel,
	#category : #'Lobster-ViewModels'
}

{ #category : #actions }
LBBrowser >> handshake: aHandshakeMessage [
	"Receives aHandshakeMessage reacts and answer its interpretation of it."

	| targetClass targetClassId |
	super handshake: aHandshakeMessage.
	"self introspector references: self references."
	targetClassId := UUID new asString36.
"	self callbacks
		at: setSelfObjectId
		put: [ :nextSelfObject | 
			self selfObject: nextSelfObject.
			setSelfObjectId ]."
	^ Dictionary new
		at: #targetClassId put: targetClassId;
"		at: #roots
			put:
			(self selfObject
				introspectWith: self references
				for: self introspector);"
		yourself
]
