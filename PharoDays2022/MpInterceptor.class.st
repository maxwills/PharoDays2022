Class {
	#name : #MpInterceptor,
	#superclass : #MpHandler,
	#instVars : [
		'interceptorBlock'
	],
	#category : #'PharoDays2022-Utils'
}

{ #category : #evaluating }
MpInterceptor >> beforeExecutionWithReceiver: anObject arguments: anArrayOfObjects [

	interceptorBlock value: anObject value: anArrayOfObjects.
	^ super beforeExecutionWithReceiver: anObject arguments: anArrayOfObjects
]

{ #category : #accessing }
MpInterceptor >> interceptorBlock [

	^ interceptorBlock
]

{ #category : #accessing }
MpInterceptor >> interceptorBlock: anObject [

	interceptorBlock := anObject
]
