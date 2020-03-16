"
The object introspector can visit instances of classes with FixedLayout and create the dictionary expected in the UI side as model of the node of the tree to render in an introspector component
"
Class {
	#name : #LBObjectIntrospector,
	#superclass : #LBAbstractIntrospector,
	#category : #'Lobster-Helpers'
}

{ #category : #action }
LBObjectIntrospector >> basicCollapsedIntrospectAs: name with: references [
	| referenceId answer instVarNames |
	referenceId := UUID new asString36.
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
				at: #nodes put: '...';
				yourself ]
]

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
				at: #nodes
					put:
					(self introspectInstVarNames: instVarNames with: references);
				yourself ]
]

{ #category : #action }
LBObjectIntrospector >> basicIntrospectAs: name with: references [
	| referenceId answer instVarNames |
	referenceId := UUID new asString36.
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
				at: #nodes
					put:
					(self introspectInstVarNames: instVarNames with: references);
				yourself ]
]

{ #category : #action }
LBObjectIntrospector >> basicIntrospectOn: aDictionary with: references [
	| referenceId answer instVarNames |
	referenceId := UUID new asString36.
	references at: referenceId put: introspectee.
	answer := aDictionary
		at: #id put: referenceId;
		at: #name put: 'self';
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
LBObjectIntrospector >> introspectInstVarNames: instVars with: references [
	^ instVars
		withIndexCollect: [ :name :index | 
			(introspectee instVarAt: index)
				collapsedInstrospectAs: name
				with: references ]
]
