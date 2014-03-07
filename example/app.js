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
win.open();


v.speed = 180;
v.opacity = 0.1;

