# Lecture34 Nonage shop continue..

Key Word : 장바구니 기능 구현 - cartlist.jsp, delete 기능 설명   

<hr>

## 장바구니 CART 이어서..    
 
 https://github.com/Moveuk/2021_JSP/tree/main/0901_Lecture33
 
 테이블 구조 확인

![image](https://user-images.githubusercontent.com/84966961/131459115-fc861220-628c-49a9-af4e-95df25a28be7.png)



<br><br><hr>

### cartList.jsp 뷰 구성

![image](https://user-images.githubusercontent.com/84966961/131808414-3ce89b3b-14c1-4da6-ab77-d32b61195c30.png)

<br>

 - checkbox에는 name속성을 지정할 수 있으며 value를 따로 넣어줄 수도 있다.
 - 또한, 체크된 내용에 대해서 **배열로 값을 전달**할 수 있다.

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<%@ include file="sub_img.html"%>
<%@ include file="sub_menu.jsp"%>

<article>
	<form name="formm" method="post">
		<h2>Cart List</h2>
		<c:choose>
			<c:when test="${cartList.size()==0 }">
				<h3 style="color: red; text-align: center;">장바구니가 비었습니다.</h3>
			</c:when>
			<c:otherwise>
				<table id="cartList">
					<tr>
						<th>상품명</th>
						<th>수 량</th>
						<th>가 격</th>
						<th>주문일</th>
						<th>삭 제</th>
					</tr>
					<c:forEach items="${cartList }" var="cartVO">
						<tr>
							<td>
								<a href="NonageServlet?command=product_detail&pseq=${cartVO.pseq}">
									<h3>${cartVO.pname }</h3>
								</a>
							</td>
							<td>${cartVO.quantity }</td>
							<td>
								<fmt:formatNumber value="${cartVO.price2 * cartVO.quantity }" type="currency"></fmt:formatNumber>
							</td>
							<td>
								<fmt:formatDate value="${cartVO.indate}" type="date" />
							</td>
							<td>
								<input type="checkbox" name="cseq" value="${cartVO.cseq }">
							</td>
						</tr>
					</c:forEach>
					<tr>
						<th colspan="2">총 액</th>
						<th colspan="2">
							<fmt:formatNumber value="${totalPrice }" type="currency"></fmt:formatNumber>
							<br>
						</th>
						<th>
							<a href="#" onclick="go_cart_delete()">삭제하기</a>
						</th>
					</tr>

				</table>
			</c:otherwise>
		</c:choose>
	</form>
</article>


<%@ include file="../footer.jsp"%>
```




<br><br><hr>

### mypage.js - delete 기능

 - 체크박스가 1개만 찍혀있을 때는 체크박스가 `undefined`로 설정되어있다. 따라서 먼저 1개일 경우를 체크하고 count를 하나 올린다.
 - 체크박스의 2개 이상일 때는 length 값이 숫자로 나오므로 카운트를 늘려 몇개가 체크되었는지 for문으로 확인하였다.
 - alert로 체크된 번호를 확인할 수 있다.

```js
function go_cart_delete() {
  var count = 0;

  if (document.formm.cseq.length == undefined) {
    if (document.formm.cseq.checked == true) {
      count++;
    }
  }

  for ( var i = 0; i < document.formm.cseq.length; i++) {
    alert("" + document.formm.cseq[i].checked);
    if (document.formm.cseq[i].checked == true) {
      count++;
      alert("" + count);
    }
  }
  if (count == 0) {
    alert("삭제할 항목을 선택해 주세요.");

  } else {
    document.formm.action = "NonageServlet?command=cart_delete";
    document.formm.submit();
  }
}
```



<br><br><hr>

### CartDeleteAction

```java
public class CartDeleteAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = "NonageServlet?command=cart_list";
		
		String[] cseqArr = request.getParameterValues("cseq");
		
		for (String cseq : cseqArr) {
			System.out.println(cseq);
			CartDAO cartDAO = CartDAO.getInstance();
			cartDAO.deleteCart(Integer.parseInt(cseq));
		}
		
		request.getRequestDispatcher(url).forward(request, response);
	}

}
```






<br><br><hr>

