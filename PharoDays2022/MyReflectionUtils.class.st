Class {
	#name : #MyReflectionUtils,
	#superclass : #Object,
	#category : #'PharoDays2022-Utils'
}

{ #category : #'as yet unclassified' }
MyReflectionUtils class >> findArgumentsOfContextWithSelector: aSelector startingAt: startingContext [

	| context found arguments |
	context := startingContext.
	arguments := nil.
	found := false.
	[ found not and: [ context isNotNil ] ] whileTrue: [ 
		context isBlockContext ifFalse: [ 
			context method selector = aSelector ifTrue: [ 
				found := true.
				arguments := context arguments ] ].
		context := context sender ].
	^ arguments
]

{ #category : #'as yet unclassified' }
MyReflectionUtils class >> findContextSatisfying: aBlock startingAt: context [

	| iterationContext found |
	iterationContext := context.
	found := false.
	[ found not and: [ iterationContext isNotNil ] ] whileTrue: [ 
		found := aBlock value: iterationContext.
		found ifFalse: [ iterationContext := iterationContext sender ] ].
	^ iterationContext
]

{ #category : #'as yet unclassified' }
MyReflectionUtils class >> findContextWithSelector: aSelector startingAt: context [

	| iterationContext found |
	iterationContext := context.
	found := false.
	[ found not and: [ iterationContext isNotNil ] ] whileTrue: [ 
		iterationContext isBlockContext ifFalse: [ 
			iterationContext method selector = aSelector ifTrue: [ found := true ] ].
		found ifFalse: [ iterationContext := iterationContext sender ] ].
	^ iterationContext
]

{ #category : #'as yet unclassified' }
MyReflectionUtils class >> getStringOfContextMethodFor: aContext andSenders: aNumber [

	aContext ifNil: [ ^ '' ].
	aNumber <= 0 ifTrue: [ ^ '' ].
	^   (self 
		  getStringOfContextMethodFor: aContext sender
		  andSenders: aNumber - 1), ' / ' , aContext method methodClass name , '>>#' , aContext method selector
]
