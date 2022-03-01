Class {
	#name : #'Part2_NonInvasiveInstrumentationExamples',
	#superclass : #Object,
	#category : #'PharoDays2022-GuidedExamples'
}

{ #category : #'as yet unclassified' }
Part2_NonInvasiveInstrumentationExamples class >> ex1_installLoggingMetalinkInCollectionAdd [

	<script>
	| metalink |
	metalink := MetaLink new.
	metalink selector: #doLoggingOfAddedApples.
	metalink metaObject: InstrumentationUtils .
	metalink control: #after.
	(OrderedCollection >> #add:) ast link: metalink
]

{ #category : #'as yet unclassified' }
Part2_NonInvasiveInstrumentationExamples class >> ex2_installLoggingMetalinkInEveryMethodAdd [

	<script>
	| implementorsOfAdd |
	implementorsOfAdd := InstrumentationUtils implementorsOf: #add:.
	implementorsOfAdd do: [ :cls | InstrumentationUtils installLoggingMetalinkInMethod: cls >> #add: ]
]

{ #category : #'as yet unclassified' }
Part2_NonInvasiveInstrumentationExamples class >> ex3_installLoggingWithMethodProxies [

	<script>
	MyProxiesTool installInterceptorProxyIn: OrderedCollection >> #add:
		withBlock: [ :receiver :args | 
			| newObject |
			newObject := args first.
			newObject class = Apple ifTrue: [ 
				MyLoggerUtil log: 'OrderedColleciton >> add: called from instrumentation' ] ]
]

{ #category : #'as yet unclassified' }
Part2_NonInvasiveInstrumentationExamples class >> ex4_installLoggingWithMethodProxiesInAllAddMethods [

	<script>
	| implementorsOfAdd |
	implementorsOfAdd := InstrumentationUtils implementorsOf: #add:.
	implementorsOfAdd do: [ :cls | 
		MyProxiesTool installInterceptorProxyIn: cls >> #add: withBlock: [ :receiver :args | 
			| newObject |
			newObject := args first.
			newObject class = Apple ifTrue: [ 
				MyLoggerUtil log: cls name , ' >> add: called from instrumentation (MethodProxy)' ] ] ]
]

{ #category : #'as yet unclassified' }
Part2_NonInvasiveInstrumentationExamples class >> installLoggingMetalinkInMethod: aCompiledMethod [

	<script>
	| metalink |
	metalink := MetaLink new.
	metalink selector: #doLoggingOfAddedApples.
	metalink metaObject: self.
	metalink control: #before.
	aCompiledMethod ast link: metalink
]

{ #category : #'as yet unclassified' }
Part2_NonInvasiveInstrumentationExamples class >> uninstallAllLinks [

	<script>
	MetaLink uninstallAll
]

{ #category : #'as yet unclassified' }
Part2_NonInvasiveInstrumentationExamples class >> uninstallAllMethodProxies [

	<script>
	MpMethodProxy allInstances copy do: [ :mp | mp uninstall ]
]
