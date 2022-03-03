Class {
	#name : #InstrumentationUtils,
	#superclass : #Object,
	#category : #'PharoDays2022-Utils'
}

{ #category : #'as yet unclassified' }
InstrumentationUtils class >> doLoggingOfAddedApples [

	"Find the context of the add: method activation"

	"Can only be used form inside the execution (via code insertion or instrumentation)"

	| ourClasses |
	ourClasses := { 
		              Apple.
		              AppleHunter.
		              AppleHunt }.
	(MyReflectionUtils findContextWithSelector: #add: startingAt: thisContext) ifNotNil: [ :ctx | 
		| newObject |
		newObject := ctx arguments first.
		newObject isAssociation ifTrue: [ newObject := newObject value ].
		(ourClasses includes: newObject class) ifTrue: [ 
			MyLoggerUtil log: ctx receiver class name , ' >> add: called from instrumentation' ] ]
]

{ #category : #'as yet unclassified' }
InstrumentationUtils class >> doLoggingOfAddedApplesAndDay [

	"Find the context of the add: method activation along with other conditions on the execution"

	"Can only be used form inside the execution (via code insertion or instrumentation)"
	
	"In simple terms, this does:
	if current method selector is #add: and it is called from a block in a method called doHuntingDay:, then log information about the hunter and day"

	| addContext doHuntingDayBlockContext doHuntingDayMethodContext newObject hunter day |
	addContext := MyReflectionUtils findContextWithSelector: #add: startingAt: thisContext.
	addContext ifNil: [ ^ self ].

	doHuntingDayBlockContext := MyReflectionUtils
		                            findContextSatisfying: [ :ctx | 
			                            ctx isBlockContext and: [ 
				                            ctx methodSelector = #doHuntingDay: and: [ 
					                            ctx sender methodSelector = #valuesDo: ] ] ]
		                            startingAt: addContext.
	doHuntingDayBlockContext ifNil: [ ^ self ].
	doHuntingDayMethodContext := MyReflectionUtils findContextSatisfying: [ :ctx | 
		                             ctx isBlockContext not and: [ ctx methodSelector = #doHuntingDay: ] ]
		                             startingAt: doHuntingDayBlockContext sender.


	hunter := doHuntingDayBlockContext arguments first.
	day := doHuntingDayMethodContext arguments first.
	"new object will be the argument of the add: method"
	newObject := addContext arguments first.
	newObject isAssociation ifTrue: [ newObject := newObject value ].
	newObject class = Apple ifTrue: [ 
		MyLoggerUtil log:
			addContext receiver class name , ' >> add: called. Hunter: ' , hunter name , ' day: '
			, day asString ]
]

{ #category : #'as yet unclassified' }
InstrumentationUtils class >> doLoggingOfAddedApplesAndDayFromContext: startingContext [

	"Find the context of the add: method activation along with other conditions on the execution"

	"Can only be used form inside or outside the execution, since the startingContext for the search must be specified"

	| addContext doHuntingDayBlockContext doHuntingDayMethodContext newObject hunter day |
	addContext := MyReflectionUtils findContextWithSelector: #add: startingAt: startingContext.
	addContext ifNil: [ ^ self ].

	doHuntingDayBlockContext := MyReflectionUtils
		                            findContextSatisfying: [ :ctx | 
			                            ctx isBlockContext and: [ 
				                            ctx methodSelector = #doHuntingDay: and: [ 
					                            ctx sender methodSelector = #valuesDo: ] ] ]
		                            startingAt: addContext.
	doHuntingDayBlockContext ifNil: [ ^ self ].
	doHuntingDayMethodContext := MyReflectionUtils findContextSatisfying: [ :ctx | 
		                             ctx isBlockContext not and: [ ctx methodSelector = #doHuntingDay: ] ]
		                             startingAt: doHuntingDayBlockContext sender.
	doHuntingDayMethodContext ifNil: [ ^ self ].

	hunter := doHuntingDayBlockContext arguments first.
	day := doHuntingDayMethodContext arguments first.
	"new object will be the argument of the add: method"
	newObject := addContext arguments first.
	newObject isAssociation ifTrue: [ newObject := newObject value ].
	newObject class = Apple ifTrue: [ 
		MyLoggerUtil log:
			addContext receiver class name , ' >> add: called. Hunter: ' , hunter name , ' day: '
			, day asString ]
]

{ #category : #'instance creation' }
InstrumentationUtils class >> implementorsOf: selector [

	"returns the classes that implement the add: selector"

	| implementors |
	"note: If using proxies, isInstalled might return false, so be careful"
	implementors := Set new.
	CompiledMethod allInstancesDo: [ :m | "m unproxifiedMethod" 
		(m selector = #add: and: [ m isInstalled ]) ifTrue: [ implementors add: m methodClass ] ].

	^ implementors
]

{ #category : #'as yet unclassified' }
InstrumentationUtils class >> installExtendedLoggingMetalinkInMethod: aCompiledMethod [

	<script>
	| metalink |
	metalink := MetaLink new.
	metalink selector: #doLoggingOfAddedApplesAndDay.
	metalink metaObject: self.
	metalink control: #before.
	aCompiledMethod ast link: metalink
]

{ #category : #'as yet unclassified' }
InstrumentationUtils class >> installLoggingMetalinkInMethod: aCompiledMethod [

	<script>
	| metalink |
	metalink := MetaLink new.
	metalink selector: #doLoggingOfAddedApples.
	metalink metaObject: self.
	metalink control: #before.
	aCompiledMethod ast link: metalink
]
