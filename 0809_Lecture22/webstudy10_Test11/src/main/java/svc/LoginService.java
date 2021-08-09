package svc;


import dao.LoginDAO;
import vo.MemberVO;

public class LoginService {
	String id = null;
	String password = null;
	public boolean result = false;
	
	
	public LoginService(String id, String password) {
		this.id = id;
		this.password = password;
		
		MemberVO mVo =  getLoginMember(id);
		
		// 로그인 비번 다름 == null.
		if (mVo == null) {
			result = false;
			return;
		}
		// 로그인 비번 같음.
		if (id.equals(mVo.getId()) && password.equals(mVo.getPassword())) {
			result = true;
		}
	}



	public static MemberVO getLoginMember(String id) {		
		MemberVO mVo = new MemberVO();
		
		LoginDAO lDao = LoginDAO.getInstance();
		
		mVo = lDao.selectLoginMember(id);
		
		return mVo;
	}
	
	// Master
	public MemberVO getLoginMemberMaster(String id, String password) {		
		LoginDAO lDao = LoginDAO.getInstance();
		MemberVO loginMember = lDao.selectLoginMemberMaster(id, password);
		
		return loginMember;
	}
	
}
