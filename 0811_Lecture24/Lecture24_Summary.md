# Lecture24 MVC2 Mission

Key Word : MVC2 Mission 사원 관리 프로그램

<hr>

## MVC2 모델 게시판 마무리.

 - 삭제 기능 등 추가.


<br><br><hr>

## MVC2 Mission 사원 관리 프로그램

### 오류들

1. 멀티 바인딩한 URL Pattern을 프론트컨트롤러가 받을 때 잘못하면 무한 재귀로 빠질 수 있음.
  -> `/WEB-INF/+URL` 의 방식으로 보안성을 겸비하며 불러오도록 처리. 오류 회피

2. JSTL forEach 사용시 var와 items 조심해서 사용해야함.
  -> var는 우리가 JSP에서 사용할 변수 이름 items는 request를 통해 날아오는 변수의 이름이므로 EL식으로 사용해야함
```
  <c:forEach var="변수이름" items="${request의 변수이름}/>
```











