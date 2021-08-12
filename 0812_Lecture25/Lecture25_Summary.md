# Lecture25 Nonage Shop 만들기

Key Word : Nonage Shop 만들기

<hr>

## NonageShop 데이터 베이스 E-R 다이어그램

![image](https://user-images.githubusercontent.com/84966961/129131385-e1bfba54-7aa4-4121-96ed-9dc9d3c008f5.png)   
    <br>
    
 1. NonageShop을 위한 sql 계정을 만든다. 계정을 만들고 권한을 주는 것은 system 계정으로 해야하므로 sql developer에서 system 계정으로 로그인한다.
  - 여기에서는 nonage / tiger로 만들었다.   
```sql
CREATE USER nonage identified by tiger;
GRANT CONNECT, RESOURCE TO nonage;
GRANT CREATE VIEW TO nonage;

SELECT * FROM all_users;
```
<br><br><hr>
 2. 빠른 프로젝트 수행을 위해서 backUp.dmp 파일을 이용해 예제 db를 개인 oracle DB에 import 한다.

  - 파일을 c드라이브에 옴긴 후 cmd 창을 열어 다음과 같이 친다.   
```bash
imp system/1234 fromuser=nonage touser=nonage file=c:/backup.dmp
```

![image](https://user-images.githubusercontent.com/84966961/129131766-8e2e4e7e-657d-47cf-bb09-3bb2d5876e6d.png)    


  -> import가 완성되었다.
  - touser에 다른 계정을 넣어도 된다.    
![image](https://user-images.githubusercontent.com/84966961/129131829-1909cae9-452c-466e-92d4-556232abe97b.png)    
<br><br><hr>
 3. 오라클 sql Developer에서 우측에 ![image](https://user-images.githubusercontent.com/84966961/129131890-2087abe6-b492-43f3-9eec-6ee82d8477a7.png) 버튼을 클릭하여 nonage계정으로 접속한다.

![image](https://user-images.githubusercontent.com/84966961/129131961-68d0d28d-3a57-4e82-924f-3e52c55b0cd5.png)
<br><br><hr>
 4. 접속후 계정을 열어 view에 데이터가 잘 보이는지 확인한다.   

![image](https://user-images.githubusercontent.com/84966961/129132003-2f2027b4-b4cc-4937-b720-cf06ecf4a612.png)
    
 없다면 다음 코드를 이용해 추가한다.

```sql
  CREATE OR REPLACE FORCE VIEW "NONAGE"."BEST_PRO_VIEW" ("PSEQ", "NAME", "PRICE2", "IMAGE") AS 
  select pseq, name, price2, image
from( select rownum, pseq, name, price2, image
      from product
      where bestyn='y'
      order by indate desc)
where  rownum <=4;

=====================================

 CREATE OR REPLACE FORCE VIEW "NONAGE"."CART_VIEW" ("CSEQ", "ID", "PSEQ", "MNAME", "PNAME", "QUANTITY", "INDATE", "PRICE2", "RESULT") AS 
  select o.cseq, o.id, o.pseq, m.name mname, p.name pname,
o.quantity, o.indate, p.price2, o.result
from cart o, member m, product p
where o.id = m.id and o.pseq = p.pseq
and result='1';

=======================================

 CREATE OR REPLACE FORCE VIEW "NONAGE"."NEW_PRO_VIEW" ("PSEQ", "NAME", "PRICE2", "IMAGE") AS 
  select pseq, name, price2, image
from( select rownum, pseq, name, price2, image
      from product
      where useyn='y'
      order by indate desc)
where  rownum <=4;

===========================================


  CREATE OR REPLACE FORCE VIEW "NONAGE"."ORDER_VIEW" ("ODSEQ", "OSEQ", "ID", "INDATE", "PSEQ", "QUANTITY", "MNAME", "ZIP_NUM", "ADDRESS", "PHONE", "PNAME", "PRICE2", "RESULT") AS 
  select d.odseq, o.oseq, o.id, o.indate, d.pseq,d.quantity, m.name mname,
m.zip_num, m.address, m.phone, p.name pname, p.price2, d.result
from orders o, order_detail d, member m, product p
where o.oseq=d.oseq and o.id = m.id and d.pseq = p.pseq;
```
<br><br><hr>
 5. 이클립스에서 새로운 프로젝트를 만든 후 기본 사용할 라이브러리, jdbc 등을 설정한다.
  - db 설정
    - ![image](https://user-images.githubusercontent.com/84966961/129132210-0dea0136-51fb-408e-8616-a621de9a483c.png)   
  - 라이브러리 및 사용할 이미지 추가
    - ![image](https://user-images.githubusercontent.com/84966961/129132277-725ed455-72cf-45a7-b4b8-9a1d541d2ca7.png)   
 
 <br><br><hr>
 6. index.html 파일을 만들어서 meta정보에 `http=equiv` 속성을 이용해 자동 이동시킬 수 있다.
 ```html
<meta http-equiv="refresh" content="0;url=NonageServlet?command=index">
 ```
 -> html 
 <br><br><hr>
 7. index.jsp 파일을 만든다.   
![image](https://user-images.githubusercontent.com/84966961/129133101-6677d5e4-8f98-4b75-9f62-46be1b835add.png)
<br><br>
  - 이후 header footer를 붙인다.      <br><br>
![image](https://user-images.githubusercontent.com/84966961/129133434-ae6d1e38-d9f8-424a-a7c7-81c90a407878.png)
   <br><br>
   
  - header 부분 nav 로그인시      <br><br>
![image](https://user-images.githubusercontent.com/84966961/129134809-d4821b80-d02a-497d-b763-1396447510f9.png)
  - css가 적용 안될시 
    - 크롬 설정에서 캐시를 삭제한 후 실행 
    - `F12` 개발자 모드에서 Network > Disable cached 체크
    - ctrl + F5 를 눌러 새로고침
    - url 뒤에 ?after를 붙여 새로운 css를 받을 수 있도록 하게 한다.


<br><br><hr>
 8. ProductVO 작성
```
package com.nonage.dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductVO {
	private int pseq;
	private String name;
	private String kind;
	private int price1;
	private int price2;
	private int price3;
	private String content;
	private String image;
	private String useyn;
	private String bestyn;
	private Timestamp indate;
}
```

<br><br><hr>

 9. Action, 서블릿, ActionFactory 구성



<br><br><hr>

