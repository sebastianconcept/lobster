"
The object introspector can visit instances of classes with FixedLayout and create the dictionary expected in the UI side as model of the node of the tree to render in an introspector component
"
Class {
	#name : #LBObjectIntrospector,
	#superclass : #LBAbstractIntrospector,
	#category : #'Lobster-Introspection'
}

{ #category : #action }
LBObjectIntrospector >> basicIntrospectAs: name id: referenceId with: references [
	|  answer instVarNames |
	references at: referenceId put: introspectee.
	answer := Dictionary new
		at: #id put: referenceId;
		at: #name put: name;
		at: #printString put: introspectee printString;
		yourself.
	instVarNames := introspectee class allInstVarNames.
	^ instVarNames size isZero
		ifTrue: [ answer ]
		ifFalse: [ answer
				at: #isExpanded put: true;
				at: #nodes
					put:
					(self introspectInstVarNames: instVarNames with: references);
				yourself ]
]

{ #category : #action }
LBObjectIntrospector >> basicIntrospectAs: name with: references [
	^ self
		basicIntrospectAs: name
		id: UUID new asString36
		with: references
]

{ #category : #action }
LBObjectIntrospector >> basicIntrospectWith: references [
	^ self
		basicIntrospectAs: 'self'
		id: UUID new asString36
		with: references
]

{ #category : #testing }
LBObjectIntrospector >> canIntrospect [
	^ introspectee class allInstVarNames isEmpty not
]

{ #category : #action }
LBObjectIntrospector >> introspectInstVarNames: instVars with: references [
	^ instVars
		withIndexCollect: [ :name :index | 
			(introspectee instVarAt: index)
				collapsedInstrospectAs: name
				with: references ]
]
