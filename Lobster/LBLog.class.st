Class {
	#name : #LBLog,
	#superclass : #Object,
	#category : #Lobster
}

{ #category : #'instance creation' }
LBLog class >> log: aString [
	Stdio stdout
		lf;
		<< aString;
		flush
]
