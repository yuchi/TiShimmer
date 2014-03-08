# Shimmer 

Appcelerator Titanium iOS Module Project
===========================================  
Shimmer is an easy way to add a shimmering effect to any view in your app. It's useful as an unobtrusive loading indicator.

Shimmer was originally developed to show loading status in [Paper](http://facebook.com/paper).

![Shimmer](https://github.com/facebook/Shimmer/blob/master/shimmer.gif?raw=true)


## Usage
--------------
```
var Shimmer = require('it.scsoft.shimmer');

var img = Ti.UI.createImageView({
	image:'prova.jpg',
	width:Ti.UI.FILL,
	height:Ti.UI.FILL
});


var v = Shimmer.createShimmerView({
	bottom:30,
	width:180,
	height:30,
	label:{
		text:'Loading...',
		textAlign:Ti.UI.TEXT_ALIGNMENT_CENTER,
		color:'black',
		fontSize:30,
		//fontFamily:''
	}
});

img.add(v);
win.add(img);

```

you can change fade speed and opacity with:

```
v.speed = 180;
v.opacity = 0.1;
```
