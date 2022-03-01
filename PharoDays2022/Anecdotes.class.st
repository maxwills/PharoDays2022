Class {
	#name : #Anecdotes,
	#superclass : #Object,
	#category : #'PharoDays2022-GuidedExamples'
}

{ #category : #'as yet unclassified' }
Anecdotes class >> browseTestForCountingInstantiations [
	"
	Question. How many objects of the Package Hiedra are instantiated during the execution of the following test? Answer by delivering a Dictionary where the key is a class of the Hiedra package, and the values are the number of object instantiated of such class.
	"
	<script>
	(HiRulerBuilderTest >> #testThreeMergedForks) browse
]

{ #category : #'as yet unclassified' }
Anecdotes class >> solutionForCountingInstantiations [

	"Execute the script by clicking or in playground"

	<script>
	| initialCount endingCount packageClasses result |
	initialCount := IdentityDictionary new.
	endingCount := IdentityDictionary new.
	
	packageClasses := (RPackageOrganizer default packageNamed: 'Hiedra') definedClasses.
	
	"Counting initial instances"
	packageClasses do: [ :p | initialCount at: p name put: p allInstances size ].

	"Programmatically run the test"
	HiRulerBuilderTest run: #testThreeMergedForks.

	"Counting ending instances"
	packageClasses do: [ :p | endingCount at: p name put: p allInstances size ].

	result := (packageClasses collect: [ :c | 
		           | clsName |
		           clsName := c name.
		           clsName -> ((endingCount at: clsName) - (initialCount at: clsName)) ]) asDictionary.
	result inspect
]
