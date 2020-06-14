package board.file;

import java.sql.Timestamp;

public class FileCommentBean {

	private int num;
	private String id;
	private String content;
	private Timestamp date;
	private int board;

	public int getBoard() {
		return board;
	}
	public void setBoard(int board) {
		this.board = board;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp string) {
		this.date = string;
	}

	
	
}

