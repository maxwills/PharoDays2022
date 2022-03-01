Class {
	#name : #MyLoggerUtil,
	#superclass : #Object,
	#classInstVars : [
		'counter',
		'enabled'
	],
	#category : #'PharoDays2022-Utils'
}

{ #category : #logging }
MyLoggerUtil class >> clear [

	<script>
	enabled ifFalse: [ ^ self ].
	[ 
	UIManager default defer: [ 
		Transcript clear.
		counter := 0 ] ] fork
]

{ #category : #initialization }
MyLoggerUtil class >> initialize [

	counter := 0.
	enabled := true
]

{ #category : #logging }
MyLoggerUtil class >> log: aString [

	enabled ifFalse: [ ^ self ].
	[ 
	UIManager default defer: [ "loggedMessages add: aString."
		(Transcript containingWindow isNil or: [ Transcript containingWindow isDisplayed not ]) ifTrue: [ 
			Transcript open ].
		counter := counter + 1.
		Transcript
			show: counter asString , '. ' , aString;
			cr ] ] fork
]

{ #category : #'as yet unclassified' }
MyLoggerUtil class >> logTop3CallsInStack [

	self log: (MyReflectionUtils getStringOfContextMethodFor: thisContext sender andSenders: 3)
]

{ #category : #'as yet unclassified' }
MyLoggerUtil class >> logTopNCallsInStack: aNumber [

	self log: (MyReflectionUtils getStringOfContextMethodFor: thisContext sender andSenders: aNumber)
]

{ #category : #'as yet unclassified' }
MyLoggerUtil class >> makeDisabled [

	<script>
	enabled := false.
	self inform: 'Logger disabled'
]

{ #category : #'as yet unclassified' }
MyLoggerUtil class >> makeEnabled [

	<script>
	enabled := true.
	self inform: 'Logger enabled'
]
