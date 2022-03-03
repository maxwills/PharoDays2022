Class {
	#name : #PharoDaysCommands,
	#superclass : #Object,
	#category : #'PharoDays2022-Commands'
}

{ #category : #menu }
PharoDaysCommands class >> menu00BrowseAnecdote: aBuilder [

	<worldMenu>
	(aBuilder item: #PharoDaysBrowseAnectodeItem)
		parent: #PharoDaysItem;
		action: [ Anecdotes class browse ];
		label: 'Browse Anectode Code';
		icon: (self iconNamed: 'nautilus');
		help: 'Browses the code of Part Anectode of the presentation';
		order: 0
]

{ #category : #menu }
PharoDaysCommands class >> menu00BrowsePart1Code: aBuilder [

	<worldMenu>
	(aBuilder item: #PharoDaysBrowsePart1Item)
		parent: #PharoDaysItem;
		action: [ Part1_CodeInsertionExamples class browse ];
		label: 'Browse Part 1 Code (Code Insertion)';
		icon: (self iconNamed: 'nautilus');
		help: 'Browses the code of Part 1 of the presentation';
		order: 2
]

{ #category : #menu }
PharoDaysCommands class >> menu00BrowsePart2Code: aBuilder [

	<worldMenu>
	(aBuilder item: #PharoDaysBrowsePart2Item)
		parent: #PharoDaysItem;
		action: [ Part2_InstrumentationExamples class browse ];
		label: 'Browse Part 2 Code (Instrumentation)';
		icon: (self iconNamed: 'nautilus');
		help: 'Browses the code of Part 2 of the presentation';
		order: 3
]

{ #category : #menu }
PharoDaysCommands class >> menu00BrowsePart3Code: aBuilder [

	<worldMenu>
	(aBuilder item: #PharoDaysBrowsePart3Item)
		parent: #PharoDaysItem;
		action: [ Part3_SindarinExamples  class browse ];
		label: 'Browse Part 3 Code (Sindarin)';
		icon: (self iconNamed: 'nautilus');
		help: 'Browses the code of Part 3 of the presentation';
		order: 4
]

{ #category : #menu }
PharoDaysCommands class >> menu00BrowsePart4Code: aBuilder [

	<worldMenu>
	(aBuilder item: #PharoDaysBrowsePart4Item)
		parent: #PharoDaysItem;
		action: [ Part4_SeekerExamples  class browse ];
		label: 'Browse Part 4 Code (Seeker)';
		icon: (self iconNamed: 'nautilus');
		help: 'Browses the code of Part 4 of the presentation';
		order: 5
]

{ #category : #menu }
PharoDaysCommands class >> menu00PharoDaysOn: aBuilder [

	<worldMenu>
	(aBuilder item: #PharoDaysItem)
		parent: #Tools;
		label: 'PharoDays Content';
		icon: (self iconNamed: 'pharo');
		help: 'PharoDay commands';
		order: 1
]

{ #category : #'as yet unclassified' }
PharoDaysCommands >> readme [

	"This class defines only class side methods that are used to generate the world Menu
Library >> PharoDays Content entries.
"

	
]
