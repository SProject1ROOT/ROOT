function makeMusicCanvas(idx, canvas_height, canvas_width){		//태그 생성 및 추가
	dummy = $('<canvas>');
	dummy.attr("id", "wavedisplay" + idx)
	dummy.css('height', canvas_height);
	dummy.css('width', canvas_width);
	dummy.css('top', (idx * 100) + "px");
	dummy.css('z-index', 1);
	dummy.css('position', 'absolute');
		
	var dragdrop_pos = -1;
	var new_pos = 0;
	
	dummy.on({
		mousedown: function (event) {
			console.log("mousedown dragdrop_pos : " + dragdrop_pos);
			dragdrop_pos = event.x;
		},
		mousemove: function (event) {
			console.log("mousemove dragdrop_pos : " + dragdrop_pos);
			if( dragdrop_pos != -1 )
			{
				if( new_pos >= 0 && AudioDataList[0].startPos + (event.x - dragdrop_pos) + this.width < 1000 )
				{
					new_pos = AudioDataList[0].startPos + (event.x - dragdrop_pos);
					this.style.left = new_pos + "px";
				}
			}
		},
		mouseup: function (event) {
			console.log("mouseup dragdrop_pos : " + dragdrop_pos);
			AudioDataList[0].startPos = new_pos;
			dragdrop_pos = -1;
		}
	});
	
	$('div#canvas_container').append(dummy);
}