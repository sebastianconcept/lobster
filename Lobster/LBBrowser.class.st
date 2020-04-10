"
A model for the Class Hierarchy Browser tool
"
Class {
	#name : #LBBrowser,
	#superclass : #LBViewModel,
	#instVars : [
		'classId'
	],
	#category : #'Lobster-ViewModels'
}

{ #category : #actions }
LBBrowser >> handshake: aHandshakeMessage [
	"Receives aHandshakeMessage reacts and answer its interpretation of it."

	super handshake: aHandshakeMessage.
	"self introspector references: self references."
	classId := UUID new asString36.
"	self callbacks
		at: setSelfObjectId
		put: [ :nextSelfObject | 
			self selfObject: nextSelfObject.
			setSelfObjectId ]."
	^ Dictionary new
		at: #classId put: classId;
"		at: #roots
			put:
			(self selfObject
				introspectWith: self references
				for: self introspector);"
		yourself
]

{ #category : #actions }
LBBrowser >> initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer [
	super initializeOn: aHandshakeMessage from: aWebSocket for: aLBServer.
	classId := aHandshakeMessage payload classId.
	self children 
		at: #classesId put: aHandshakeMessage payload children classes id;
		at: #methodsId put: aHandshakeMessage payload children methods id;
		at: #categoriesAndVairablesId put: aHandshakeMessage payload children categoriesAndVairables id;
		at: #methodSourceId put: aHandshakeMessage payload children methodSource id;
		yourself.

]
