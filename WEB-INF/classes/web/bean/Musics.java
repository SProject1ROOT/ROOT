package web.bean;

import java.util.Date;

public class Musics {

	private int id;
	private String name;
	private String user_id;
	private Date date;
	private String music_path;
	private String description;
	private int recording;
	private int play_cnt;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getMusic_path() {
		return music_path;
	}
	public void setMusic_path(String music_path) {
		this.music_path = music_path;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getRecording() {
		return recording;
	}
	public void setRecording(int recording) {
		this.recording = recording;
	}
	public int getPlay_cnt() {
		return play_cnt;
	}
	public void setPlay_cnt(int play_cnt) {
		this.play_cnt = play_cnt;
	}
}
