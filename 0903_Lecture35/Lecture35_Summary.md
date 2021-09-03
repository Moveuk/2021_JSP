# Lecture33 Nonage shop continue..

Key Word : 주문하기 기능 구현   

<hr>

##  Order 기능   
 
 페이지 예시
 
 ![image](https://user-images.githubusercontent.com/84966961/131971718-eb2f2ce0-9efd-49be-9e5c-4b6b4fd21b22.png)

 <br>

 테이블 구조 확인

![image](https://user-images.githubusercontent.com/84966961/131459115-fc861220-628c-49a9-af4e-95df25a28be7.png)


<br><br><hr>

### 주문 order controller

```java
package com.nonage.controller.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.nonage.dao.CartDAO;
import com.nonage.dao.OrderDAO;
import com.nonage.dto.CartVO;
import com.nonage.dto.MemberVO;

public class OrderInsertAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String url = "NonageServlet?comman=order_list";
		
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		
		if(loginUser == null) {
			url = "NonageServlet?command=login.jsp";
		} else {
			CartDAO cartDAO = CartDAO.getInstance();
			ArrayList<CartVO> cartList = cartDAO.listCart(loginUser.getId());

			OrderDAO orderDAO = OrderDAO.getInstance();
			
			int maxOseq = orderDAO.insertOrder(cartList, loginUser.getId());
			url = "NonageServlet?command=order_list&oseq="+maxOseq;
			
		}
		
	}

}

```



<br><br><hr>

### 주문 orderDAO 구성

 주문 목록에 넣어주는 `insertOrder()` 메소드와 주문 목록의 상세를 바꿔주며 결제 처리 되었음을 알리는 `insertOrderDetail()` 메소드를 구성하여 주문 처리를 실행한다.    

```java
package com.nonage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.nonage.dto.CartVO;

import util.DBManager;

public class OrderDAO {

	private OrderDAO() {
		// TODO Auto-generated constructor stub
	}
	
	private static OrderDAO instance = new OrderDAO();

	public static OrderDAO getInstance() {
		return instance;
	}
	
	// 사용자가 주문
		public int insertOrder(ArrayList<CartVO> cartList, String id) {
			int maxOseq = 0;

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs;

			try {
				conn = DBManager.getConnection();

				String insertOrder = "insert into orders(oseq, id) values("
						+ "orders_seq.nextval, ?)";
				pstmt = conn.prepareStatement(insertOrder);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
				
				pstmt.close();

				String selectMaxOseq = "select max(oseq) from orders";
				pstmt = conn.prepareStatement(selectMaxOseq);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					maxOseq = rs.getInt(1);
				}

				for (CartVO cartVO : cartList) {
					insertOrderDetail(cartVO, maxOseq);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				DBManager.close(conn, pstmt);
			}
			return maxOseq;
		}

		public void insertOrderDetail(CartVO cartVO, int maxOseq) {
			Connection conn = null;
			PreparedStatement pstmt = null;

			try {
				conn = DBManager.getConnection();

				String insertOrderDetail = "insert into order_detail(odseq, oseq, "
						+ "pseq, quantity) values(order_detail_seq.nextval, ?, ?, ?)";
				pstmt = conn.prepareStatement(insertOrderDetail);
				pstmt.setInt(1, maxOseq);
				pstmt.setInt(2, cartVO.getPseq());
				pstmt.setInt(3, cartVO.getQuantity());
				pstmt.executeUpdate();
				pstmt.close();

				String updateCartResult = "update cart set result=2 where cseq=?";
				pstmt = conn.prepareStatement(updateCartResult);
				pstmt.setInt(1, cartVO.getCseq());
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				DBManager.close(conn, pstmt);
			}
		}
}

```

<br><br><hr>

### 주문 order 삽입 db 결과 확인


![image](https://user-images.githubusercontent.com/84966961/131977212-8526e589-27b6-4994-a85f-5ef1d4e81437.png)
![image](https://user-images.githubusercontent.com/84966961/131977225-283fd454-a9ad-479a-a0f9-086e4da9b327.png)








<br><br><hr>

