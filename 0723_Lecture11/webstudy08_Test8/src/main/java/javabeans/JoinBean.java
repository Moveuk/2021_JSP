package javabeans;

public class JoinBean {
	private String usrid = "";
	private String usrpwd = "";
	private String usrName = "";
	private String usrGender = "";
	private String usrAge = "";
	private String usrEmail = "";
	public JoinBean() {
		super();
	}
	public JoinBean(String usrid, String usrpwd, String usrName, String usrGender, String usrEmail, String usrAge) {
		super();
		this.usrid = usrid;
		this.usrpwd = usrpwd;
		this.usrName = usrName;
		this.usrGender = usrGender;
		this.usrEmail = usrEmail;
		this.usrAge = usrAge;
	}
	public String getUsrid() {
		return usrid;
	}
	public void setUsrid(String usrid) {
		this.usrid = usrid;
	}
	public String getUsrpwd() {
		return usrpwd;
	}
	public void setUsrpwd(String usrpwd) {
		this.usrpwd = usrpwd;
	}
	public String getUsrName() {
		return usrName;
	}
	public void setUsrName(String usrName) {
		this.usrName = usrName;
	}
	public String getUsrGender() {
		return usrGender;
	}
	public void setUsrGender(String usrGender) {
		this.usrGender = usrGender;
	}
	public String getUsrAge() {
		return usrAge;
	}
	public void setUsrAge(String usrAge) {
		this.usrAge = usrAge;
	}
	public String getUsrEmail() {
		return usrEmail;
	}
	public void setUsrEmail(String usrEmail) {
		this.usrEmail = usrEmail;
	}
	@Override
	public String toString() {
		return "JoinBean [usrid=" + usrid + ", usrpwd=" + usrpwd + ", usrName=" + usrName + ", usrGender=" + usrGender
				 + ", usrAge=" + usrAge + ", usrEmail=" + usrEmail + "]";
	}
}
