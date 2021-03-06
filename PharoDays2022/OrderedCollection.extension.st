Extension { #name : #OrderedCollection }

{ #category : #'*PharoDays2022' }
OrderedCollection >> modifiedAdd1add: newObject [

	newObject class = Apple ifTrue: [ newObject healthy ifFalse: [ self halt ] ].
	
	^ self addLast: newObject
]

{ #category : #'*PharoDays2022' }
OrderedCollection >> modifiedAdd2add: newObject [

	"Add a new object at the end of the collection, and returns the object itself"

	"((OrderedCollection new add: 42; yourself) add: 43; yourself) asArray >>> #(42 43)"

	"Add returns the object itself"

	"(OrderedCollection new add: 42) >>> 42"

	"You may want to use yourself to return the collection itself"

	"(OrderedCollection new add: 42; yourself) class >>> OrderedCollection"

	"(OrderedCollection new add: 42; yourself) size >>> 1"

	newObject class = Apple ifTrue: [ 
		newObject healthy ifFalse: [ 
			MyLoggerUtil log:
				(MyLoggerUtil findArgumentsOfContextWithSelector: #doExchangeBetween:and:withRandom:) ] ].

	^ self addLast: newObject
]
