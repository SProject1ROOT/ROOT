function makeMusicCanvas(idx, canvas_height, canvas_width){		//태그 생성 및 추가
	dummy = $('<canvas>');
	dummy.attr("id", "wavedisplay" + idx);
	dummy.attr('height', canvas_height - 1);
	dummy.attr('width', canvas_width);
	dummy.css('top', (idx * 100) + "px");
	dummy.css('z-index', 1);
	dummy.css('border', "1px solid #663399");
	dummy.css('position', 'absolute');
	dummy.on({
		mousedown: function (event) {
			console.log("mousedown offsetY : " + event.offsetY);
			if(event.offsetY < 20)
			{
				Player.dragdrop_pos = event.clientX;
				Player.currentId = this.id;
			}
			else
			{
				var playbar = document.getElementById('playbar');
				
				pos = event.offsetX;
				
				playbar.style.left = event.clientX;
				playbar.style.top = this.offsetParent.offsetTop + 20 + (idx*100);
				playbar.style.visibility="visible";
			}
		},
		mousemove: function (event) {
			//console.log("mousemove dragdrop_pos : " + Player.dragdrop_pos);
			if(event.offsetY < 20)
			{
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
			}
			else
			{
			}
		},
		mouseup: function (event) {
			//console.log("mouseup dragdrop_pos : " + Player.dragdrop_pos);
			if(event.offsetY < 20)
			{
				AudioDataList[idx].startPos = Player.new_pos;
				Player.dragdrop_pos = -1;
				Player.new_pos = 0;
				Player.currentId = "";
			}
			else
			{
			}
		}
	});
	
	$('div#canvas_container').append(dummy);
}