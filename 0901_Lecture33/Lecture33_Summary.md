# Lecture33 Nonage shop continue..

Key Word : 장바구니 기능 구현    

<hr>

## 장바구니 CART 이어서..    
 
 테이블 구조 확인

![image](https://user-images.githubusercontent.com/84966961/131459115-fc861220-628c-49a9-af4e-95df25a28be7.png)


<br>

### 컨트롤러

Factory 마지막에 장바구니를 위한 Action을 만들어 붙여준다.

```java
      else if(command.equals("cart_list")) {
	    	action = new CartInsertAction();
	    }
```



<br><br><hr>

### CartDAO insertCart() 메소드 작성

```java
	public void insertCart(CartVO cartVO) {
	    String sql = "insert into cart(cseq,id,pseq,quantity) values(cart_seq.nextval, ?, ?, ?)";

	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    
	    try {
	      conn = DBManager.getConnection();
	      pstmt = conn.prepareStatement(sql);
	      pstmt.setString(1, cartVO.getId());      
	      pstmt.setInt(2, cartVO.getPseq());
	      pstmt.setInt(3, cartVO.getQuantity());
	      pstmt.executeUpdate();
	    } catch (Exception e) {
	      e.printStackTrace();
	    } finally {
	      DBManager.close(conn, pstmt);
	    }
	}
```


<br><br><hr>

### insert 컨트롤러 구성

```java
public class CartInsertAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String url = "NonageServlet?command=cart_list";
		
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		if(loginUser == null) {
			url = "NonageServlet?command=login_form";
		} else {
			CartVO cartVO = new CartVO();
			cartVO.setId(loginUser.getId());
			cartVO.setPseq(Integer.parseInt(request.getParameter("pseq")));
			cartVO.setQuantity(Integer.parseInt(request.getParameter("quantity")));
			
			CartDAO cartDAO = CartDAO.getInstance();
			cartDAO.insertCart(cartVO);
		}
		
		response.sendRedirect(url);
	}

}
```


<br><br><hr>

### CartDAO insertCart() 메소드 작성

```java
	public ArrayList<CartVO> listCart(String userId){
		
		ArrayList<CartVO> cartList = new ArrayList<>();
		String sql = "select * from cart_view where id=? order by cseq desc";
		
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	      conn = DBManager.getConnection();
	      pstmt = conn.prepareStatement(sql);
	      pstmt.setString(1, userId);
	      rs = pstmt.executeQuery();
	      while (rs.next()) {
			CartVO cartVO = new CartVO();
			
			cartVO.setCseq(rs.getInt(1));
			cartVO.setId(rs.getString(2));
			cartVO.setPseq(rs.getInt(3));
			cartVO.setMname(rs.getString(4));
			cartVO.setPname(rs.getString(5));
			cartVO.setQuantity(rs.getInt(6));
			cartVO.setIndate(rs.getTimestamp(7));
			cartVO.setPrice2(rs.getInt(8));
			
			cartList.add(cartVO);
		}
	    
	    
	    } catch (Exception e) {
	      e.printStackTrace();
	    } finally {
	      DBManager.close(conn, pstmt);
	    }
		
		return cartList;
	}
```



<br><br><hr>

### List 컨트롤러 구성

```java
public class CartListAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String url = "mypage/cartList.jsp";
		
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		
		if(loginUser == null) {
			url = "NonageServlet?command=login_form";
		} else {
			CartDAO cartDAO = CartDAO.getInstance();
			ArrayList<CartVO> cartList = cartDAO.listCart(loginUser.getId());
			
			// 총가격 표시
			int totalPrice = 0;
			for (CartVO cartVO : cartList) {
				totalPrice += cartVO.getPrice2() * cartVO.getQuantity();
			}
			
			request.setAttribute("cartList", cartList);
			request.setAttribute("totalPrice", totalPrice);
		}
		
		request.getRequestDispatcher(url).forward(request, response);
		
	}

}
```





<br><br><hr>
