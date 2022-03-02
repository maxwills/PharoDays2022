Class {
	#name : #'Part4_SeekerExamples',
	#superclass : #Object,
	#category : #'PharoDays2022-GuidedExamples'
}

{ #category : #'as yet unclassified' }
Part4_SeekerExamples class >> _disableSeeker [

	<script>
	SeekerConfig default seekerEnabled: false
]

{ #category : #'as yet unclassified' }
Part4_SeekerExamples class >> _enableSeeker [

	<script>
	SeekerConfig default seekerEnabled: true
]

{ #category : #'as yet unclassified' }
Part4_SeekerExamples class >> _openPlaygroundWithAppleHunt [

	<script>
	Part1_CodeInsertionExamples _openPlaygroundWithAppleHunt
]

{ #category : #'as yet unclassified' }
Part4_SeekerExamples class >> ex1_seekerScriptingConditionalStop [

	| seeker currentState |
	"Copy from here"
	MyLoggerUtil clear.
	seeker doAndUpdateSessionAfter: [ 
		seeker restartAtBytecodeOne.
		[ seeker canStep ] whileTrue: [ 
			seeker step.
			(currentState isMessageSend and: [ currentState node selector = #add: ]) ifTrue: [ ^ self ] ] ]
]

{ #category : #'as yet unclassified' }
Part4_SeekerExamples class >> ex2_seekerScriptingLogging [

	| seeker currentState |
	"Copy from here"
	MyLoggerUtil clear.
seeker doAndUpdateSessionAfter: 
[
	seeker restartAtBytecodeOne.
	[ seeker canStep ] whileTrue: [ 
		seeker step.
		(currentState isMessageSend and: [ currentState node selector = #add: ]) ifTrue: [ 
			MyLoggerUtil log: 'add: method called (seeker)' ] ]]
]

{ #category : #'as yet unclassified' }
Part4_SeekerExamples class >> ex3_seekerScriptingExecutionData: seeker [

	"This time, instead of logging, we store the data in a collection"

	"In the scripting presenter, paste next line:
	
Part4_SeekerExamples ex3_seekerScriptingExecutionData: seeker

"

	| callsToAdd |

	callsToAdd := OrderedCollection new.
	seeker doAndUpdateSessionAfter: [ 
		seeker restartAtBytecodeOne.
		[ seeker canStep ] whileTrue: [ 
			seeker step.
			(seeker currentState isMessageSend and: [ seeker currentState node selector = #add: ]) ifTrue: [ "This time, instead of logging, we store the data in a collection" 
				callsToAdd add: seeker currentState methodAboutToExecute ] ] ].
	^ callsToAdd
]

{ #category : #'as yet unclassified' }
Part4_SeekerExamples class >> ex4_seekerQuery: seeker [

	"In the scripting presenter, paste next line:
	
Part4_SeekerExamples ex4_seekerQuery: seeker

"

	^ (Query from: seeker newProgramStates
		   select: [ :state | state isMessageSend and: [ state node selector = #add: ] ]
		   collect: [ :state | state methodAboutToExecute ]) asOrderedCollection
]
