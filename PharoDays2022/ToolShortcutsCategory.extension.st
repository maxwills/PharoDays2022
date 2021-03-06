Extension { #name : #ToolShortcutsCategory }

{ #category : #'*PharoDays2022' }
ToolShortcutsCategory >> openIdea [

	<shortcut>
	^ KMKeymap shortcut: $o meta shift action: [ 
		  [ 
		  (ZnEasy getJpeg:
			   'https://i.imgflip.com/67be6k.jpg')
			  asMorph openInWindow ] onErrorDo: [ :e | e resumeUnchecked: e ] ]
]

{ #category : #'*PharoDays2022' }
ToolShortcutsCategory >> openSad [

	<shortcut>
	^ KMKeymap shortcut: $i meta shift action: [ 
		  [ 
		  (ZnEasy getJpeg:
			   'https://memegenerator.net/img/instances/73648989.jpg')
			  asMorph openInWindow ] onErrorDo: [ :e | e resumeUnchecked: e ] ]
]

{ #category : #'*PharoDays2022' }
ToolShortcutsCategory >> openSunglasses [

	<shortcut>
	^ KMKeymap shortcut: $u meta shift action: [ 
		  [ 
		  (ZnEasy getPng:
			   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCwFtnCb2gLoVAaG90RmpLAU5irDzBL_TuRg&usqp=CAU')
			  asMorph openInWindow ] onErrorDo: [ :e | e resumeUnchecked: e ] ]
]
