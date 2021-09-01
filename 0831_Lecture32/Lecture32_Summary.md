# Lecture32 Nonage shop continue..

Key Word : 장바구니 기능 구현    

<hr>

## 장바구니 CART    
 
 테이블 구조 확인

![image](https://user-images.githubusercontent.com/84966961/131459115-fc861220-628c-49a9-af4e-95df25a28be7.png)


<br>

### 시퀀스 구성

최대 지정 갯수는 2의 1028승까지 가능하다

![image](https://user-images.githubusercontent.com/84966961/131456465-6364c285-4ed8-499c-ba22-dfcab3c379c8.png)


<br><br><hr>

### VIEW 를 이용한 CartVO 구성

```java
@Getter
@Setter
public class CartVO {
	private int cseq;
	private String id;
	private int pseq;
	private String mname;
	private String pname;
	private int quantity;
	private int price2;
	private Timestamp indate;
}
```


<br><br><hr>


### 장바구니 화면 sub_img, sub_menu 구성

```jsp
<div id="sub_img">
	<img src="images/mypage/sub_img.jpg" alt="" />
</div>
<div class="clear"></div>
```

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
	<nav id="sub_menu">
		<ul>
			<li><a href="NonageServlet?command=cart_list">장바구니(cart)내역</a></li>
			<li><a href="NonageServlet?command=mypage">진행중인 주문내역</a></li>
			<li><a href="NonageServlet?command=order_all">총 주문내역</a></li>
		</ul>
	</nav>
```

<br><br><hr>



### 장바구니 JS 구성

 action을 위한 JS 구성

```js
function go_cart(){
   if(document.formm.quantity.value==""){
      alert("수량을 입력하여 주세요");
      document.formm.quantity.focus();
   }else{
      document.formm.action = "NonageServlet?command=cart_insert";
      document.formm.submit();
   }
}

function go_cart_delete(){
   var count = 0;
   
   if(document.formm.cseq.length == undefined){
      if(document.formm.cseq.checked == true){
         count++;
      }
   }
   
   for(var i=0; i<document.formm.cseq.length; i++){
      alert("" + document.formm.cseq[i].checked);
      if(document.formm.cseq[i].checked == true){
         count++;
         alert("" + count);
      }
   }
   if(count == 0){
      alert("삭제할 항목을 선택해 주세요.");
   }else{
      document.formm.action = "NonageServlet?command=cart_delete";
      document.formm.submit();
   }
}

function go_order_insert(){
    document.formm.action = "NonageServlet?command=order_insert";
	document.formm.submit();	
}

function go_order_delete() {
	var count = 0;
	
	if (document.formm.oseq.length == undefined) {
		if(document.formm.oseq.checked == true) {
			count++;
		}
	}	
	for (var i = 0; i < document.formm.oseq.length; i++) {
		if(document.formm.oseq[i].checked == ture){
			count++;
		}
	}
	if (count == 0) {
		alert("삭제할 항목을 선택해 주세요.");
	} else {
		document.formm.action = "NonageServlet?command=order_delete";
		document.formm.submit();
	}
}

function go_order() {
	document.formm.action = "NonagetServlet?command=mypage";
	document.formm.submit();
}
```







<br><br><hr>












