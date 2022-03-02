Class {
	#name : #'Part1_CodeInsertionExamples',
	#superclass : #Object,
	#category : #'PharoDays2022-GuidedExamples'
}

{ #category : #adding }
Part1_CodeInsertionExamples class >> _browseOrderedCollectionAdd [

	<script>
	(OrderedCollection >> #add:) browse
]

{ #category : #initialization }
Part1_CodeInsertionExamples class >> _clearLogger [

	<script>
	MyLoggerUtil clear
]

{ #category : #'as yet unclassified' }
Part1_CodeInsertionExamples class >> _openPlaygroundWithAppleHunt [

	<script>
	| code removeSubstrings |
	removeSubstrings := [ :str :substr | str copyReplaceAll: substr with: '' ].

	code := (self class >> #appleHunt) sourceCode.
	code := removeSubstrings value: code value: String tab.
	code := removeSubstrings value: code value: 'appleHunt'.
	StPlayground openContents: code trim
]

{ #category : #adding }
Part1_CodeInsertionExamples class >> _restoreOrderedCollectionAdd [
	"Programmatically recompiles the original code of OrderedCollection>>add:"
	"Click the script icon in the method list to restore the method OrderedCollection>>add:"
	<script>
	OrderedCollection compile: 'add: newObject
	
	"Add a new object at the end of the collection, and returns the object itself"

	"((OrderedCollection new add: 42; yourself) add: 43; yourself) asArray >>> #(42 43)"

	"Add returns the object itself"

	"(OrderedCollection new add: 42) >>> 42"

	"You may want to use yourself to return the collection itself"

	"(OrderedCollection new add: 42; yourself) class >>> OrderedCollection"

	"(OrderedCollection new add: 42; yourself) size >>> 1"

	
	^ self addLast: newObject'.
	self inform: '(OrderedCollection >> add:) has been restored'
]

{ #category : #'as yet unclassified' }
Part1_CodeInsertionExamples class >> appleHunt [

	"This is the execution we must explore"

	| huntEvent winner |
	huntEvent := AppleHunt new.
	huntEvent giveHuntersSomeBags.
	huntEvent goHunting.
	winner := huntEvent calculateRanks first.
	^ winner
	
"Q1. How many times OrderedCollection>>#add: is called? (with apples?)"
"Q2. How many times any method with selector add: is called? (which method?)"
"Q3. How many times OrderedCollection>>#add: is called? (with apples?)"
]

{ #category : #adding }
Part1_CodeInsertionExamples class >> ex1_OrderedCollectionAddLogging: newObject [

	MyLoggerUtil log: 'OrderedCollection >> add: called'.

	^ self addLast: newObject
]

{ #category : #adding }
Part1_CodeInsertionExamples class >> ex2_OrderedCollectionAddWithConditionalHalting: newObject [

	newObject class = Apple ifTrue: [ self halt ].

	^ self addLast: newObject
]

{ #category : #adding }
Part1_CodeInsertionExamples class >> ex3_OrderedCollectionAddWithConditionalLogging: newObject [

	newObject class = Apple ifTrue: [ MyLoggerUtil log: 'OrderedCollection >> add: called' ].

	^ self addLast: newObject
]

{ #category : #adding }
Part1_CodeInsertionExamples class >> ex4_showImplementorsOfAdd [

	<script>
	self systemNavigation browseAllImplementorsOf: #add:
]
