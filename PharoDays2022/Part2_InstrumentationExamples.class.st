Class {
	#name : #'Part2_InstrumentationExamples',
	#superclass : #Object,
	#category : #'PharoDays2022-GuidedExamples'
}

{ #category : #initialization }
Part2_InstrumentationExamples class >> _clearLogger [

	<script>
	MyLoggerUtil clear
]

{ #category : #'as yet unclassified' }
Part2_InstrumentationExamples class >> _openPlaygroundWithAppleHunt [

	<script>
	Part1_CodeInsertionExamples _openPlaygroundWithAppleHunt
]

{ #category : #adding }
Part2_InstrumentationExamples class >> _restoreOrderedCollectionAdd [

	"Programmatically recompiles the original code of OrderedCollection>>add:"

	"Click the script icon in the method list to restore the method OrderedCollection>>add:"

	<script>
	Part1_CodeInsertionExamples _restoreOrderedCollectionAdd
]

{ #category : #'as yet unclassified' }
Part2_InstrumentationExamples class >> _uninstallAllLinks [

	<script>
	MetaLink uninstallAll
]

{ #category : #'as yet unclassified' }
Part2_InstrumentationExamples class >> _uninstallAllMethodProxies [

	<script>
	MpMethodProxy allInstances copy do: [ :mp | mp uninstall ]
]

{ #category : #'as yet unclassified' }
Part2_InstrumentationExamples class >> ex1_installLoggingMetalinkInCollectionAdd [

	"The metalink will execute the method 
	(InstrumentationUtils class)>>#doLoggingOfAddedApples) on activation"
	
	"(InstrumentationUtils class>>#doLoggingOfAddedApples) browse"

	<script>
	| metalink |
	metalink := MetaLink new.
	metalink selector: #doLoggingOfAddedApplesSimple.
	metalink metaObject: InstrumentationUtils.
	metalink control: #after.
	
	(OrderedCollection >> #add:) ast link: metalink
]

{ #category : #'as yet unclassified' }
Part2_InstrumentationExamples class >> ex2_installLoggingMetalinkInEveryMethodAdd [

	<script>
	| implementorsOfAdd |
	implementorsOfAdd := InstrumentationUtils implementorsOf: #add:.
	implementorsOfAdd do: [ :cls | 
		|metalink|
		metalink := MetaLink new.
		metalink selector: #doLoggingOfAddedApples.
		metalink metaObject: InstrumentationUtils.
		metalink control: #before.
		(cls >> #add:) ast link: metalink ]
]

{ #category : #'as yet unclassified' }
Part2_InstrumentationExamples class >> ex3_installLoggingWithMethodProxies [

	<script>
	MyProxiesTool installInterceptorProxyIn: OrderedCollection >> #add:
		withBlock: [ :receiver :args | 
			| newObject |
			newObject := args first.
			newObject class = Apple ifTrue: [ 
				MyLoggerUtil log: 'OrderedColleciton >> add: called from instrumentation (MethodProxy)' ] ]
]

{ #category : #'as yet unclassified' }
Part2_InstrumentationExamples class >> ex4_installLoggingWithMethodProxiesInAllAddMethods [

	<script>
	| implementorsOfAdd ourClasses |
	ourClasses := { 
		              Apple.
		              AppleHunter.
		              AppleHunt }.

	implementorsOfAdd := InstrumentationUtils implementorsOf: #add:.
	implementorsOfAdd do: [ :cls | 
		MyProxiesTool installInterceptorProxyIn: cls >> #add: withBlock: [ :receiver :args | 
			| newObject |
			newObject := args first.
			newObject isAssociation ifTrue: [ newObject := newObject value ].
			(ourClasses includes: newObject class) ifTrue: [ 
				MyLoggerUtil log: cls name , ' >> add: called from instrumentation (MethodProxy)' ] ] ]
]

{ #category : #'as yet unclassified' }
Part2_InstrumentationExamples class >> ex5_installLoggingAndMoreReflection [

	"Same as example 2, but calls a different logging method"

	<script>
	| implementorsOfAdd |
	implementorsOfAdd := InstrumentationUtils implementorsOf: #add:.
	implementorsOfAdd do: [ :cls | 
		| metalink |
		metalink := MetaLink new.
		metalink selector: #doLoggingOfAddedApplesAndDay.
		metalink metaObject: InstrumentationUtils.
		metalink control: #before.
		(cls >>#add:) ast link: metalink ]
]

{ #category : #'as yet unclassified' }
Part2_InstrumentationExamples class >> installLoggingMetalinkInMethod: aCompiledMethod [

	<script>
	| metalink |
	metalink := MetaLink new.
	metalink selector: #doLoggingOfAddedApples.
	metalink metaObject: self.
	metalink control: #before.
	aCompiledMethod ast link: metalink
]
