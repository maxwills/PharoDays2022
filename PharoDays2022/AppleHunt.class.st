Class {
	#name : #AppleHunt,
	#superclass : #Object,
	#instVars : [
		'hunters',
		'random'
	],
	#category : #PharoDays2022
}

{ #category : #'as yet unclassified' }
AppleHunt class >> letItBegin [

	| a winner |
	a := AppleHunt new.
	a giveHuntersSomeBags.
	a goHunting.
	winner := a calculateRanks first.
	winner biggestBagSize
]

{ #category : #'as yet unclassified' }
AppleHunt >> calculateRanks [
	"Returns a SortedCollection, where the first element is the hunter with the biggest bag size, and the last is the one with the smallest"
	| ranked |
	ranked := SortedCollection sortUsing: [ :h1 :h2 | h1 biggestBagSize > h2 biggestBagSize ].
	hunters valuesDo: [ :hunter | ranked add: hunter ].
	^ ranked
]

{ #category : #'as yet unclassified' }
AppleHunt >> doHuntingDay: stageNumber [

	"performs a hunting stage"

	| maxApples |
	maxApples := 10 * stageNumber.

	hunters valuesDo: [ :hunter | 
		| huntedApples |
		"get a random number of apples"
		huntedApples := random nextIntegerBetween: 1 and: maxApples.
		"add the apples in random bags of the hunter"
		huntedApples timesRepeat: [ hunter storeAnAppleInRandomBag: random ] ]
]

{ #category : #'as yet unclassified' }
AppleHunt >> giveHuntersSomeBags [

	| maxBags |
	maxBags := 5.
	"Give hunter some bags"
	hunters valuesDo: [ :hunter | hunter assignBags: (random nextIntegerBetween: 1 and: maxBags) ].
	
	
]

{ #category : #'as yet unclassified' }
AppleHunt >> goHunting [

	"performs sequentially every stage of the hunt"

	| nTimes |
	nTimes := 4.
	1 to: nTimes do: [ :i | self doHuntingDay: i ]
]

{ #category : #accessing }
AppleHunt >> hunters [

	^ hunters
]

{ #category : #accessing }
AppleHunt >> hunters: anObject [

	hunters := anObject
]

{ #category : #initialization }
AppleHunt >> initialize [

	random := self newRandom.
	hunters := Dictionary new
		           add: #Alice -> AppleHunter newAlice;
		           add: #Bob -> AppleHunter newBob;
		           add: #Charlie -> AppleHunter newCharlie;
		           yourself
]

{ #category : #initialization }
AppleHunt >> newRandom [

	^ Random new
		  seed: 1;
		  yourself
]
