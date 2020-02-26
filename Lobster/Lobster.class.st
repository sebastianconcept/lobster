Class {
	#name : #Lobster,
	#superclass : #BaselineOf,
	#category : #Lobster
}

{ #category : #accessing }
Lobster class >> start [
	Stdio stdout
		lf;
		<< 'Competent lobsters stands up straight with their shoulders back!';
		flush
]
