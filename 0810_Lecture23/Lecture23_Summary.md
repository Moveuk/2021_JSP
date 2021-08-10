# Lecture23 MVC2 Model

Key Word : MVC2 model, Factory Pattern, 게시판

<hr>

## command를 이용한 페이지 이동 처리(FrontController)

**BoardServlet.java**
```java
package com.saeyan.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saeyan.controller.action.Action;

@WebServlet("/BoardServlet")
public class BoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String command = request.getParameter("command");
		System.out.println("BoardServlet 요청받은 명령어는 : "+ command);
		
		ActionFactory af = ActionFactory.getInstance();
		Action action = af.getAction(command);
		
		if(action != null) {
			action.execute(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
```


<br><br><hr>

## Factory Pattern

  이동할 페이지를 파라미터로 받아서 실행할 Controller의 객체를 만들어 호출함.

**ActionFactory.java**
```java
package com.saeyan.controller;

import com.saeyan.controller.action.Action;
import com.saeyan.controller.action.BoardListAction;

public class ActionFactory {
	private static ActionFactory instance = new ActionFactory();

	private ActionFactory() {
	}

	public static ActionFactory getInstance() {
		return instance;
	}

	public Action getAction(String command) {

		Action action = null;
		System.out.println("ActionFactory요청받은 명령어는 : " + command);
		if (command.equals("board_list")) {
			// 객체 생성
			action = new BoardListAction();
		} else if (command.equals("board_write_form")) {
			// 객체 생성
			action = new BoardWriteFormAction();
		} else if (command.equals("board_write")) {
			// 객체 생성
			action = new BoardWriteAction();
		} else if (command.equals("board_view")) {
			// 객체 생성
			action = new BoardViewAction();
		} else if (command.equals("board_check_pass_form")) {
			// 객체 생성
			action = new BoardCheckPassFormAction();
		} else if (command.equals("board_check_pass")) {
			// 객체 생성
			action = new BoardCheckPassAction();
		} else if (command.equals("board_update_form")) {
			// 객체 생성
			action = new BoardUpdateFormAction();
		} else if (command.equals("board_update")) {
			// 객체 생성
			action = new BoardUpdateAction();
		} else if (command.equals("board_delete")) {
			// 객체 생성
			action = new BoardDeleteAction();
		}
		return action;
	}
}

```


<br><br><hr>

## hidden 사용 용도

  hidden을 사용함으로써 url 노출을 적게하여 보안상 유리하게 할 수 있다.    
     
  form 태그에 함께 보냄으로서 BoardServlet에서 command 값을 받아 페이지 이동을 자동적으로 할 수 있도록 도와준다.   

```html
		<input type="hidden" name="command" value="board_write">
```




<br><br><hr>

## window.open

  새 창 띄우기 위한 준비
  - script
    
 부모창에서 페이지 변경
  - window.opener.parent.location.href 
 
 
 
**board.js**
```js
function boardCheck() {
	if (document.frm.name.value.length == 0) {
		alert("작성자를 입력하세요.");
		return false;
	}
	if (document.frm.pass.value.length == 0) {
		alert("비밀번호를 입력하세요.");
		return false;
	}
	if (document.frm.title.value.length == 0) {
		alert("제목을 입력하세요.");
		return false;
	}
	return true;
}

function open_win(url, name) {
	window.open(url, name, "width=500, height=230");
}

function passCheck() {
	if (document.frm.pass.value.length == 0) {
		alert("비밀번호를 입력하세요.");
		return false;
	}
	return true;
}
```

**checkSuccess.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
	if (window.name == "update") {
		window.opener.parent.location.href = "BoardServlet?command=board_update_form&num=${param.num}";
	} else if (window.name == "delete") {
		alert('삭제되었습니다.')
		window.opener.parent.location.href = "BoardServlet?command=board_delete&num=${param.num}";
	}
	window.close();
</script>
</body>
</html>
```

<br><br><hr>
