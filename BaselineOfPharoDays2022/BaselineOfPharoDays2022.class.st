Class {
	#name : #BaselineOfPharoDays2022,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoDays2022
}

{ #category : #baselines }
BaselineOfPharoDays2022 >> baseline: spec [

	<baseline>
	spec for: #common do: [ spec package: 'PharoDays2022' ].
	spec postLoadDoIt: #postload:package:
]

{ #category : #actions }
BaselineOfPharoDays2022 >> postload: loader package: packageSpec [

	Metacello new
		baseline: 'Seeker';
		repository: 'github://maxwills/SeekerDebugger:main';
		load.
		(self class environment at: #SeekerInstallHelper) uninstall
]
