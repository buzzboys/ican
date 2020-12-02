package trashRecord;

public class RNclass implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	private String time;
	private String RN_class;
	private String type;
	
	
	public String getTime() {return time;}
	public String getRN_class() {return RN_class;}
	public String getType() {return type;}
	
	
	public void setTime(String time) {	this.time = time;	}
	public void setRN_class(String rn_class) {	RN_class = rn_class;	}
	public void setType(String type) {this.type = type;}
}

