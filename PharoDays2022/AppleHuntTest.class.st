Class {
	#name : #AppleHuntTest,
	#superclass : #TestCase,
	#category : #'PharoDays2022-Tests'
}

{ #category : #tests }
AppleHuntTest >> testHunting [

	self assert: AppleHunt letItBegin name equals: #Charlie
]
