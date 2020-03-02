"
This should happen when you want a new message to be shown in LBTranscript
"
Class {
	#name : #LBTranscriptEntry,
	#superclass : #Announcement,
	#instVars : [
		'message'
	],
	#category : #'Lobster-Announcements'
}

{ #category : #'instance creation' }
LBTranscriptEntry class >> on: aString [
	^ self new
		message: aString;
		yourself
]

{ #category : #accessing }
LBTranscriptEntry >> message [
	^ message
]

{ #category : #accessing }
LBTranscriptEntry >> message: anObject [
	message := anObject
]
