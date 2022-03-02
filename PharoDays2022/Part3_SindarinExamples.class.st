Class {
	#name : #'Part3_SindarinExamples',
	#superclass : #Object,
	#category : #'PharoDays2022-GuidedExamples'
}

{ #category : #initialization }
Part3_SindarinExamples class >> _clearLogger [

	<script>
	MyLoggerUtil clear
]

{ #category : #'as yet unclassified' }
Part3_SindarinExamples class >> _disableSindarinUI [

	<script>
	StSindarinDebuggerScriptingPresenter showInDebugger: false
]

{ #category : #'as yet unclassified' }
Part3_SindarinExamples class >> _enableSindarinUI [

	<script>
	StSindarinDebuggerScriptingPresenter showInDebugger: true
]

{ #category : #'as yet unclassified' }
Part3_SindarinExamples class >> _openPlaygroundWithAppleHunt [

	<script>
	Part1_CodeInsertionExamples _openPlaygroundWithAppleHunt
]

{ #category : #'as yet unclassified' }
Part3_SindarinExamples class >> ex1_SindarinInUI [

	"Scripted breaks"

	| sindarin |
	"--- Copy from here and paste in the Sindarin Scripting presenter -----------"
	[ sindarin isExecutionFinished ] whileFalse: [ 
		sindarin step.
		(sindarin message: #add:) ifTrue: [ ^ self ] ]
]

{ #category : #'as yet unclassified' }
Part3_SindarinExamples class >> ex2_SindarinInUI [

	"Scripted querying through reflection"

	| sindarin |
	"--- Copy from here and paste in the Sindarin Scripting presenter -----------"
	[ sindarin isExecutionFinished ] whileFalse: [ 
		sindarin step.
		(sindarin message: #add:) ifTrue: [ 
			"At this point, the execution is at the moment just before executing the add: method"
			"We step once, because our reflective function expects the execution to be inside the add: method"
			sindarin step.
			InstrumentationUtils doLoggingOfAddedApplesAndDayFromContext: sindarin context ] ]
]

{ #category : #'as yet unclassified' }
Part3_SindarinExamples class >> ex2_SindarinInUIReflectiveLogging [

	"Scripted querying through reflection"

	| sindarin |
	"--- Copy from here and paste in the Sindarin Scripting presenter -----------"
	[ sindarin isExecutionFinished ] whileFalse: [ 
		sindarin step.
		(sindarin message: #add:) ifTrue: [ 
			"At this point, the execution is at the moment just before executing the add: method"
			"We step once, because our reflective function expects the execution to be inside the add: method"
			sindarin step.
			InstrumentationUtils doLoggingOfAddedApplesAndDayFromContext: sindarin context ] ]
]

{ #category : #'as yet unclassified' }
Part3_SindarinExamples class >> ex3_SindarinHeadless [

	"Breaking execution example"

	<script>
	| s |
	s := SindarinDebugger debug: [ 
		     | huntEvent winner |
		     huntEvent := AppleHunt new.
		     huntEvent giveHuntersSomeBags.
		     huntEvent goHunting.
		     winner := huntEvent calculateRanks first.
		     winner ].
	[ s isExecutionFinished ] whileFalse: [
		s step.
		(s message: #add:) ifTrue: [ 
			s currentProcess debug. 
			"can only do this once though"
			^ self ] ]
]

{ #category : #'as yet unclassified' }
Part3_SindarinExamples class >> ex4_SindarinHeadlessReflectiveLogging [

	"Querying execution data using reflection example"

	<script>
	| s |
	s := SindarinDebugger debug: [ 
		     | huntEvent winner |
		     huntEvent := AppleHunt new.
		     huntEvent giveHuntersSomeBags.
		     huntEvent goHunting.
		     winner := huntEvent calculateRanks first.
		     winner ].
	[ s isExecutionFinished ] whileFalse: [ 
		s step.
		(s message: #add:) ifTrue: [ 
			s step.
			InstrumentationUtils doLoggingOfAddedApplesAndDayFromContext: s context ] ]
]

{ #category : #removing }
Part3_SindarinExamples class >> removeAllInstrumentation [

	<script>
	Part2_InstrumentationExamples uninstallAllLinks.
	Part2_InstrumentationExamples uninstallAllMethodProxies
]
