"
A logging helper
"
Class {
	#name : #LBLog,
	#superclass : #Object,
	#category : #'Lobster-Helpers'
}

{ #category : #'instance creation' }
LBLog class >> log: aString [
	Stdio stdout
		lf;
		<< ('[ ' , DateAndTime now asString , ']');
		<< aString;
		flush
]
