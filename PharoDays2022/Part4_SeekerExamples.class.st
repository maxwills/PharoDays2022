Class {
	#name : #'Part4_SeekerExamples',
	#superclass : #Object,
	#category : #'PharoDays2022-GuidedExamples'
}

{ #category : #initialization }
Part4_SeekerExamples class >> _clearLogger [

	<script>
	MyLoggerUtil clear
]

{ #category : #'as yet unclassified' }
Part4_SeekerExamples class >> _disableSeeker [

	<script>
	SeekerConfig default seekerEnabled: false
]

{ #category : #'as yet unclassified' }
Part4_SeekerExamples class >> _enableSeeker [

	<script>
	SeekerInstallHelpers install.
	SeekerConfig default seekerEnabled: true
]

{ #category : #'as yet unclassified' }
Part4_SeekerExamples class >> _openPlaygroundWithAppleHunt [

	<script>
	Part1_CodeInsertionExamples _openPlaygroundWithAppleHunt
]

{ #category : #'as yet unclassified' }
Part4_SeekerExamples class >> ex1_seekerScriptingConditionalStop [

"stops at the first #add: call"
	| seeker currentState |
	"Copy from here"
	seeker restartAtBytecodeOne.
seeker doAndUpdateSessionAfter: [ 
		[ seeker canStep ] whileTrue: [ 
			seeker step.
			(currentState isMessageSend and: [ currentState node selector = #add: ]) ifTrue: [ ^ self ] ] ]
]

{ #category : #'as yet unclassified' }
Part4_SeekerExamples class >> ex2_seekerScriptingLogging [

	| seeker currentState |
	"Copy from here"
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

{ #category : #'as yet unclassified' }
Part4_SeekerExamples class >> ex5_seekerTTQ: seeker [

"Transforming a Query to a TTQ.

1. Use UserTTQ instead of Query class.
2. Use Autotype for collected items.
3. Include  the #bytecodeIndex key as in this example."

	"In the scripting presenter, paste next line:
	
Part4_SeekerExamples ex5_seekerTTQ: seeker

"
	| autoResultType |
	autoResultType := AutoType new.

	(UserTTQ from: seeker newProgramStates
		 select: [ :state | state isMessageSend and: [ state node selector = #add: ] ]
		 collect: [ :state | 
			 autoResultType newWith
				 bytecodeIndex: state bytecodeIndex;
				 methodClass: state methodAboutToExecute methodClass name;
				 messageSelector: state methodAboutToExecute selector;
				 newColumnASD: 123;
				 endWith ]) showInSeeker
]
