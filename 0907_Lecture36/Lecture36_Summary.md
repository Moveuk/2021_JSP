# Lecture36 Nonage shop continue..

Key Word : 결제 전 주문 오더 리스트 확인   

<hr>

##  Order 기능   
 
 ![image](https://user-images.githubusercontent.com/84966961/132301962-29374b09-43bd-42f5-b3b6-e1d080977c12.png)


<br><hr>

### OrderListAction

 ```java
public class OrderListAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String url = "/mypage/orderList.jsp";

		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		
		if(loginUser == null) {
			url = "NonageServlet?command=login_form";
		} else {
			OrderDAO orderDAO = OrderDAO.getInstance();
			int oseq = Integer.parseInt(request.getParameter("oseq"));
			ArrayList<OrderVO> orderList = orderDAO.listOrderById(loginUser.getId(),"1",oseq);
			
			int totalPrice = 0;
			
			for (OrderVO orderVO : orderList) {
				totalPrice += orderVO.getPrice2()*orderVO.getQuantity();
			}
			
			request.setAttribute("orderList", orderList);
			request.setAttribute("totalPrice", totalPrice);
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
		
	}

}
```
 
 
<br><hr>

### OrderDAO  listOrderById 메소드

 ```java
		public ArrayList<OrderVO> listOrderById(String id, String result, int oseq) {
			ArrayList<OrderVO> orderList = new ArrayList<>();
			String sql = "select * from order_view where id = ? and result like '%'||?||'%' and oseq = ?";
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				conn = DBManager.getConnection();

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, result);
				pstmt.setInt(3, oseq);

				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					OrderVO orderVO = new OrderVO();
					
					orderVO.setOdseq(rs.getInt("ODSEQ"));
					orderVO.setOseq(rs.getInt("OSEQ"));
					orderVO.setId(rs.getString("ID"));
					orderVO.setIndate(rs.getTimestamp("INDATE"));
					orderVO.setMname(rs.getString("MNAME"));
					orderVO.setZipNum(rs.getString("ZIP_NUM"));
					orderVO.setAddress(rs.getString("ADDRESS"));
					orderVO.setPhone(rs.getString("PHONE"));
					orderVO.setPseq(rs.getInt("PSEQ"));
					orderVO.setQuantity(rs.getInt("QUANTITY"));
					orderVO.setPname(rs.getString("PNAME"));
					orderVO.setPrice2(rs.getInt("PRICE2"));
					orderVO.setResult(rs.getString("RESULT"));
					
					orderList.add(orderVO);
				}
				
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				DBManager.close(conn, pstmt);
			}
			
			
			return orderList;
		}
```
<br><hr>

### orderList.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>  
<%@ include file="../header.jsp" %>  
<%@ include file="sub_img.html"%> 
<%@ include file="sub_menu.jsp" %>       
  <article>
      <h2> Order List </h2>
      <form name="formm" method="post">
        <table id="cartList">
       <tr>
        <th>상품명</th> <th>수 량</th><th>가 격</th> <th>주문일</th> <th> 진행 상태 </th>    
       </tr>
       <c:forEach items="${orderList}"  var="orderVO">
       <tr>      
        <td>
            <a href="NonageServlet?command=product_detail&pseq=${cartVO.pseq}">
              <h3> ${orderVO.pname} </h3>              
          </a>    
        </td>
        <td> ${orderVO.quantity} </td>
        <td> <fmt:formatNumber value="${orderVO.price2*orderVO.quantity}" type="currency"/> </td>      
        <td> <fmt:formatDate value="${orderVO.indate}" type="date"/></td>
        <td> 처리 진행 중 </td>
       </tr>
       </c:forEach>
       <tr>
         <th colspan="2"> 총 액 </th>
         <th colspan="2"> <fmt:formatNumber value="${totalPrice}" type="currency"/><br>     </th> 
         <th> 주문 처리가 완료되었습니다. </th>                
       </tr> 
      </table>   
          
      <div class="clear"></div>
      <div id="buttons" style="float: right">
       <input type="button"    value="쇼핑 계속하기"  class="cancel"  onclick="location.href='NonageServlet?command=index'">     
      </div>
    </form>  
  </article>
<%@ include file="../footer.jsp" %>
```


<br><hr>

### ActionFactory 서비스 분할

```java
else if(command.equals("order_list")) {
	    	action = new OrderListAction();
	    }
```
 
 
 
 
 
 
<br><hr>

 
 
 
 
 
 
 
 
