



#### 교재 199p : forward 방식 - 성년만 입장 가능한 사이트 만들기











<br><br><hr>

### application 내장 객체

 application 내장 객체는 하나의 웹 애플리케이션을 관리하고 웹 애플리케이션 안에서의 자원을 공유한다. 하나의 웹 애플리케이션이란 하나의 웹 프로젝트를 의미한다. 지금까지 만든 모든 프로젝트를 의미하는 것이다.    
   
 지금까지는 이번 페이지에서 사용한 정보(자원)를 다음 페이지에서까지 사용하도록 하기 위해서 속성을 새로 생성해서 request 객체에 저장하여 사용했다.   
 
 ```
 				request.setAttribute("name","request man");
 ```

 application 객체도 정보(자원)를 속성에 저장할 수 있다.


 ```
 				application.setAttribute("name","application man");
 ```

 application 객체에 저장된 내용은 하나의 프로젝트 내의 모든 JSP 페이지에서 공통적으로 사용할 수 있게 된다.













  <br><br> 
 


