Class {
	#name : #MyReflectionUtils,
	#superclass : #Object,
	#category : #'PharoDays2022-Utils'
}

{ #category : #'as yet unclassified' }
MyReflectionUtils class >> findArgumentsOfContextWithSelector: aSelector [

	| context found arguments |
	context := thisContext.
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
MyReflectionUtils class >> findContextWithSelector: aSelector [

	| context found |
	context := thisContext.
	found := false.
	[ found not and: [ context isNotNil ] ] whileTrue: [ 
		context isBlockContext ifFalse: [ context method selector = aSelector ifTrue: [ found := true ] ].
		found ifFalse: [ context := context sender ] ].
	^ context
]

{ #category : #'as yet unclassified' }
MyReflectionUtils class >> getStringOfContextMethodFor: aContext andSenders: aNumber [

	aContext ifNil: [ ^ '' ].
	aNumber <= 0 ifTrue: [ ^ '' ].
	^   (self 
		  getStringOfContextMethodFor: aContext sender
		  andSenders: aNumber - 1), ' / ' , aContext method methodClass name , '>>#' , aContext method selector
]
