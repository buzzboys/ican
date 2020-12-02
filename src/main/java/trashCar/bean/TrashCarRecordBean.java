package trashCar.bean;

public class TrashCarRecordBean implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	
	private String Name;
	private String Userlng;
	private String Userlat;
	private String Relng1;
	private String Relat1;
	private String Time1;
	private String Relng2;
	private String Relat2;
	private String Time2;
	private String Relng3;
	private String Relat3;
	private String Time3;
	private String Choice;

	public String getName() {	return Name;	}
	public String getUserlng() {	return Userlng;	}
	public String getUserlat() {	return Userlat;	}
	public String getRelng1() {	return Relng1;	}
	public String getRelat1() {	return Relat1;	}
	public String getTime1() {	return Time1;	}
	public String getRelng2() {	return Relng2;	}
	public String getRelat2() {	return Relat2;	}
	public String getTime2() {	return Time2;	}
	public String getRelng3() {	return Relng3;	}
	public String getRelat3() {	return Relat3;	}
	public String getTime3() {	return Time3;	}
	public String getChoice() {	return Choice;	}
	

	
	public void setName(String Name) {	this.Name = Name;	}
	public void setUserlng(String Userlng) {	this.Userlng = Userlng;	}
	public void setUserlat(String Userlat) {	this.Userlat = Userlat;	}
	public void setRelng1(String Relng1) {	this.Relng1 = Relng1;	}
	public void setRelat1(String Relat1) {	this.Relat1 = Relat1;	}
	public void setTime1(String Time1) {	this.Time1 = Time1;	}
	public void setRelng2(String Relng2) {	this.Relng2 = Relng2;	}
	public void setRelat2(String Relat2) {	this.Relat2 = Relat2;	}
	public void setTime2(String Time2) {	this.Time2 = Time2;	}
	public void setRelng3(String Relng3) {	this.Relng3 = Relng3;	}
	public void setRelat3(String Relat3) {	this.Relat3 = Relat3;	}
	public void setTime3(String Time3) {	this.Time3 = Time3;	}
	public void setChoice(String Choice) {	this.Choice = Choice;	}
	
	public String toString() {
		return this.Name + ", " + this.Userlat+","+this.Userlng;
	}
	
	
	
}