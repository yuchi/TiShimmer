var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
var Shimmer = require('it.scsoft.shimmer');
var img = Ti.UI.createImageView({
	image:'prova.jpg',
	width:Ti.UI.FILL,
	height:Ti.UI.FILL
});


var v = Shimmer.createShimmerView({
	bottom:30,
	width:200,
	height:200,
	opacity:0.5,
	/*label:{
		text:'Loading...',
		textAlign:Ti.UI.TEXT_ALIGNMENT_CENTER,
		color:'white',
		fontSize:30,
		//fontFamily:''
	}*/
	// OR
	subview:Ti.UI.createView({
		width:Ti.UI.FILL,
		height:Ti.UI.FILL,
		backgroundColor:'red'
	})
});

img.add(v);
win.add(img);
win.open();

v.speed = 80;
/*
 In this version speed change only after mainWindow is open...
v.speed = 180;
v.opacity = 0.1;

*/
