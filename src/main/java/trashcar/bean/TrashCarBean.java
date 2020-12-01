package trashcar.bean;

public class TrashCarBean implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	private String Region;
	private String Li;
	private String DepName;
	private String CarNo;
	private String CarNumber;
	private String CarTimeStart;
	private String CarTimeEnd;
	private String Address;
	private String Lng;
	private String Lat;
	
	
	

	public String getRegion() {  return Region;  }
	public String getLi() {  return Li;  }
	public String getDepName() {  return DepName;  }
	public String getCarNo() {  return CarNo;  }
	public String getCarNumber() {  return CarNumber;  }
	public String getCarTimeStart() {  return CarTimeStart;  }
	public String getCarTimeEnd() {  return CarTimeEnd;  }
	public String getAddress() {  return Address;  }
	public String getLng() {  return Lng;  }
	public String getLat() {  return Lat;  }
	
	

	public void setRegion(String Region) {  this.Region = Region;  }
	public void setLi(String Li) {  this.Li = Li;  }
	public void setDepName(String DepName) {  this.DepName= DepName;  }
	public void setCarNo(String CarNo) {  this.CarNo = CarNo;  }
	public void setCarNumber(String CarNumber) {  this.CarNumber= CarNumber;	}
	public void setCarTimeStart(String CarTimeStart) {  this.CarTimeStart= CarTimeStart;	}
	public void setCarTimeEnd(String CarTimeEnd) {  this.CarTimeEnd= CarTimeEnd;	}
	public void setAddress(String Address) {  this.Address= Address;	}
	public void setLng(String Lng) {  this.Lng= Lng;	}
	public void setLat(String Lat) {  this.Lat= Lat;	}
	
	public String toString() {
		return this.Lng + ", " + this.Lat;
	}
	
	public double getDistance(double lat, double lng) {
			double Distance;
			double Lng=Math.pow((Double.parseDouble(this.Lng)-lng), 2);
			double Lat=Math.pow((Double.parseDouble(this.Lat)-lat), 2);
			Distance=Lng+Lat;	
			return Distance;
	}
	
	
}