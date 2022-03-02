Class {
	#name : #InstrumentationUtils,
	#superclass : #Object,
	#category : #'PharoDays2022-Utils'
}

{ #category : #'as yet unclassified' }
InstrumentationUtils class >> doLoggingOfAddedApples [

	"Find the context of the add: method activation"

	| ourClasses |
	ourClasses := {  Apple.
		              AppleHunter.
		              AppleHunt }.
	(MyReflectionUtils findContextWithSelector: #add:) ifNotNil: [ :ctx | 
		| newObject |
		newObject := ctx arguments first.
		newObject isAssociation ifTrue: [ newObject := newObject value ].
		(ourClasses includes: newObject class) ifTrue: [ 
			MyLoggerUtil log: ctx receiver class name , ' >> add: called from instrumentation' ] ]
]

{ #category : #'as yet unclassified' }
InstrumentationUtils class >> ex1_installLoggingMetalinkInCollectionAdd [

	<script>
	| metalink |
	metalink := MetaLink new.
	metalink selector: #doLoggingOfAddedApples.
	metalink metaObject: self.
	metalink control: #after.
	(SortedCollection >> #add:) ast link: metalink
]

{ #category : #'as yet unclassified' }
InstrumentationUtils class >> ex2_installLoggingMetalinkInEveryMethodAdd [

	<script>
	| implementorsOfAdd |
	implementorsOfAdd := self implementorsOf: #add:.
	implementorsOfAdd do: [ :cls | self installLoggingMetalinkInMethod: cls >> #add: ]
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
InstrumentationUtils class >> installLoggingMetalinkInMethod: aCompiledMethod [

	<script>
	| metalink |
	metalink := MetaLink new.
	metalink selector: #doLoggingOfAddedApples.
	metalink metaObject: self.
	metalink control: #before.
	aCompiledMethod ast link: metalink
]
