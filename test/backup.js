

function drawBuffer( width, height, context, data ) {	
    var step = Math.ceil( data.length / width );
    var amp = height / 2;
	
	context.fillStyle = "#333333";
	context.clearRect(0,0,width,height);
    for(var i=0; i < width; i++){
        var min = 1.0;
        var max = -1.0;
        for (j=0; j<step; j++) {
            var datum = data[(i*step)+j]; 
            if (datum < min)
                min = datum;
            if (datum > max)
                max = datum;
        }
        context.fillRect(i,(1+min)*amp,1,Math.max(1,(max-min)*amp));
		
		//alert(i + ", " + (0+min)*amp + ", " + 1 + ", " + Math.max(1,(max-min)*amp));
    }
}


function finishedLoading(bufferList) {
	// Create two sources and play them both together.
	source1 = context.createBufferSource();
	source1.buffer = bufferList[0];
	
	arrayBufferList = bufferList;
	
	/*for (var i = 0; i < bufferList.length; i++)
		AudioDataList[i] = new AudioData(bufferList[i], 0, 0)*/

	var canvas1 = document.getElementById( "wavedisplay1" );
	var bufferdata1 = source1.buffer.getChannelData(0);
	drawBuffer( canvas1.width, canvas1.height, canvas1.getContext('2d'), bufferdata1);
}