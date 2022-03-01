Class {
	#name : #AppleHuntScriptableExamples,
	#superclass : #Object,
	#category : #PharoDays2022
}

{ #category : #'as yet unclassified' }
AppleHuntScriptableExamples class >> seekerExample: programStates [

	| autoType |
	autoType := AutoType new.

	^ UserTTQ from: programStates
		  select: [ :state | state isMessageSend and: [ state messageSelector = #add: ] ]
		  collect: [ :state | 
			  autoType newWith
				  bytecodeIndex: state bytecodeIndex;
				  callerMethodClass: state method methodClass;
				  callerMethodSelector: state  method selector;
				  endWith ]
]

{ #category : #'as yet unclassified' }
AppleHuntScriptableExamples class >> sindarinExample [

	| s |
	s := SindarinDebugger debug: [ AppleHunt letItBegin ].
	[ s isExecutionFinished ] whileFalse: [ 
		s step.
		(s message: #add:) ifTrue: [ 
			s currentProcess debug.
			^ self "Transcript show: '#add: called'; cr" ] ]
	
"Headless and within the UI? "
]
