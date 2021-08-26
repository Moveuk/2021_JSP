# Lecture30 Nonage shop continue..

Key Word : 회원가입 폼 - 주소찾기 기능 추가

<hr>

## 회원가입 폼 생성    

<br>

### 주소찾기 기능 추가   

1. 주소를 위한 DAO 생성

```java
public class AddressDAO {

	private AddressDAO() {
	}
	
	private static AddressDAO instance = new AddressDAO();
	
	public static AddressDAO getInstance() {
		return instance;
	}

	public List<AddressVO> selectAddressByDong(String dong) {
		List<AddressVO> list = new ArrayList<AddressVO>();
		String sql = "SELECT * FROM address WHERE dong like '%'||?||'%'";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dong);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				AddressVO aVo = new AddressVO();
				aVo.setZip_num(rs.getString("zip_num"));
				aVo.setSido(rs.getString("sido"));
				aVo.setGugun(rs.getString("gugun"));
				aVo.setDong(rs.getString("dong"));
				aVo.setZip_code(rs.getString("zip_code"));
				aVo.setBunji(rs.getString("bunji"));
				list.add(aVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(conn, pstmt, rs);
		}
		
		return list;		
	}
}
```

<br><br>

2. FindZipNumAction 구성

```java
public class FindZipNumAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "member/findZipNum.jsp";
				
		String dong = request.getParameter("dong");
		
		if(dong != null && dong.trim().equals("") == false) {
			AddressDAO addressDAO = AddressDAO.getInstance();
			List<AddressVO> addressList = addressDAO.selectAddressByDong(dong.trim());
			request.setAttribute("addressList", addressList);
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

}
```

<br><br>

3. 주소찾기 새창 폼 구성

  - js function에 매개변수를 JSTL을 이용하여 넣을수도 있다. 단, 문자값으로 인식하도록 '' 을 붙이자.
```jsp
<a href="#"onclick="return result('${addressVO.zip_num }', '${addressVO.sido }', '${addressVO.gugun }', '${addressVO.dong }')">${addressVO.sido } ${addressVO.gugun } ${addressVO.dong }</a></td>
```		

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="CSS/subpage.css" rel="stylesheet">
<style type="text/css">
body{   
   background-color:#B96DB5;
   font-family: Verdana;
}
#popup{   
   padding: 0 10px;
}
#popup h1 {
   font-family: "Times New Roman", Times, serif;
   font-size: 45px;
   color: #CCC;
   font-weight: normal;
}

table#zipcode {
    border-collapse:collapse;    /* border 사이의 간격 없앰 */   
    border-top: 3px solid  #fff;  
    border-bottom: 3px solid  #fff;
    width: 100%;  
    margin-top: 15px; 
}
table#zipcode th, table#zipcode td{   
   text-align: center;
   border-bottom: 1px dotted  #fff;  
   color:#FFF;   
}
table th, td{
  padding: 10px;
}
table#zipcode  a{
   display:block; 
    height:20px;
    text-decoration:none;
    color:#fff;
    padding: 10px;
}
table#zipcode a:hover{
    color: #F90;
    font-weight: bold;
}
</style>
<script type="text/javascript">
function result(zipNum,sido,gugun,dong) {
   opener.document.formm.zipNum.value=zipNum;
   opener.document.formm.addr1.value=sido+" "+gugun+" "+dong;
   self.close();
};
</script>
</head>
<body>
	<div id="popup">
		<form action="NonageServlet?command=find_zip_num" method="post" name="formm">
			동 이름 : <input name="dong" type="text">
					<input type="submit" value="찾기" class="submit">
		</form>
		<table id="zipcode">
			<tr>
				<th>우편번호</th>
				<th>주소</th>
			</tr>
			<c:forEach items="${addressList }" var="addressVO">
				<tr>
					<td>${addressVO.zip_num }</td>
					<td><a href="#"onclick="return result('${addressVO.zip_num }', '${addressVO.sido }', '${addressVO.gugun }', '${addressVO.dong }')">${addressVO.sido } ${addressVO.gugun } ${addressVO.dong }</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>
```

<br><br>

4. **결과화면**   
![image](https://user-images.githubusercontent.com/84966961/130912951-512df1ff-026a-4aaa-93c4-8ae171f92cb0.png)


<br><br><hr>

### 회원가입 - 회원 DB 추가 







