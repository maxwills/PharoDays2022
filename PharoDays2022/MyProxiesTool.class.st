Class {
	#name : #MyProxiesTool,
	#superclass : #Object,
	#category : #'PharoDays2022-Utils'
}

{ #category : #'as yet unclassified' }
MyProxiesTool class >> installInterceptorProxyIn: aMethod withBlock: aBlockWithReceiverAndArgs [

	| mp handler |
	mp := MpMethodProxy onMethod: aMethod
		      handler: (handler := MpInterceptor new interceptorBlock: aBlockWithReceiverAndArgs).
	mp install
]

{ #category : #'as yet unclassified' }
MyProxiesTool class >> installProxyInOrderedCollectionAdd [

	<script>
	self installInterceptorProxyIn: OrderedCollection >> #add: withBlock: [ :receiver :args | 
		| newObject |
		newObject := args first.
		newObject class = Apple ifTrue: [ 
			newObject healthy ifFalse: [ 
				MyLoggerUtil log:
					(MyLoggerUtil findArgumentsOfContextWithSelector: #doExchangeBetween:and:withRandom:) ] ] ]
]

{ #category : #cleanup }
MyProxiesTool class >> uninstallAll [
<script>
	MpMethodProxy allInstances copy do: [ :mp | mp uninstall ]
]

{ #category : #'as yet unclassified' }
MyProxiesTool class >> uninstallProxyFrom: method [

	method isMethodProxy ifTrue: [ method uninstall ]
]
