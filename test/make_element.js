function makeMusicCanvas(idx, canvas_height, canvas_width){		//태그 생성 및 추가
	dummy = $('<canvas>');
	dummy.attr("id", "wavedisplay" + idx);
	dummy.attr('height', canvas_height);
	dummy.attr('width', canvas_width);
	dummy.css('top', (idx * 100) + "px");
	dummy.css('z-index', 1);
	dummy.css('position', 'absolute');
	dummy.on({
		mousedown: function (event) {
			//console.log("mousedown dragdrop_pos : " + Player.dragdrop_pos);
			Player.dragdrop_pos = event.clientX;
			Player.currentId = this.id;
		},
		mousemove: function (event) {
			//console.log("mousemove dragdrop_pos : " + Player.dragdrop_pos);
			if( Player.dragdrop_pos != -1 && Player.currentId == this.id)
			{
				var x = AudioDataList[idx].startPos + (event.clientX - Player.dragdrop_pos);
				var width = parseInt($(this).css('width'));
				if( x < 0 ) x = 0;
				if( x + width > 1000 ) x = 1000 - width;

				//console.log("x:" + x + ", $(this).css.width:" + width);
				Player.new_pos = x;//AudioDataList[idx].startPos + (event.clientX - Player.dragdrop_pos);
				this.style.left = Player.new_pos + "px";
				
				Player.mouseover_on_canvas = false;
			}
		},
		mouseup: function (event) {
			//console.log("mouseup dragdrop_pos : " + Player.dragdrop_pos);
			AudioDataList[idx].startPos = Player.new_pos;
			Player.dragdrop_pos = -1;
			Player.new_pos = 0;
			Player.currentId = "";
		}
	});
	
	$('div#canvas_container').append(dummy);
}