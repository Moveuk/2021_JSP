package javabeans;

public class JoinBean {
	private String name = "";
	private String id = "";
	private String pwd = "";
	private String email = "";
	private String tel = "";
	private String level = "";
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public JoinBean() {
		super();
	}
	public JoinBean(String name, String id, String pwd, String email, String tel, String level) {
		super();
		this.name = name;
		this.id = id;
		this.pwd = pwd;
		this.email = email;
		this.tel = tel;
		this.level = level;
	}
	@Override
	public String toString() {
		return "<h1>회원의 정보 입력 폼</h1>name : " + name + "<br> id : " + id + "<br> pwd : " + pwd + "<br> email : " + email + "<br> tel : " + tel
				+ "<br> level : " + level + "";
	}
	
	
}
