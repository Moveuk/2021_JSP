# Lecture01 JSP
Key Word : JSP, 톰캣 설치, Port 설정, 톰캣 서버 연동, 개발 환경 구성, 인코딩 설정, JSP 파일 생성, 기본 브라우저 설정, 자바 서블릿(Java Servlet), 파라미터(Parameter)

<hr>

## JSP를 위한 Tomcat 이클립스 연동
   
### 톰캣 설치 
   
톰캣 사이트에서 톰캣 8.5 버전을 설치하도록 한다.   
   
1. `Tomcat 8.5` 버튼 클릭   
   
![image](https://user-images.githubusercontent.com/84966961/125006998-56285000-e09a-11eb-8776-9ee10e597f18.png)   

<br>

 2. `32-bit/64-bit Windows Service Installer (pgp, sha512)` 버전을 선택하여 설치.    
   
![image](https://user-images.githubusercontent.com/84966961/125007057-6a6c4d00-e09a-11eb-97da-1678b15eb513.png)   

<br>

 3. 설치된 exe 파일 더블 클릭하여 열은 후 약관 동의까지 next 버튼을 눌러서 넘김.
   
![image](https://user-images.githubusercontent.com/84966961/125007168-a1426300-e09a-11eb-8c81-d3c72ec3b335.png)

![image](https://user-images.githubusercontent.com/84966961/125007179-a6071700-e09a-11eb-80b8-666258eb96d7.png)

<br>

 4. `example`을 선택하게 되면 회사에서 제공하는 예제들도 함께 받아볼 수 있다.

![image](https://user-images.githubusercontent.com/84966961/125007194-adc6bb80-e09a-11eb-8bce-10f5b1218efa.png)


<br>

 5. 다음 이미지와 같이 설정 하면 된다.   
    
  `HTTP/1.1 Connector Port` 8080으로 사용하게 되면 오라클과 포트가 중복되어 오류가 나게 된다.   
  User Name과 Passward는 톰캣 관리자 비밀번호로 연습용이기에 분실 방지를 위하여 admin / 1234 로 설정하였다.   
  개인 목적에 따라 다르게 하면 될 것 같다. 

<br>

![image](https://user-images.githubusercontent.com/84966961/125007332-f0889380-e09a-11eb-831f-59d9ff5ea91a.png)
   
 6. 사용자 환경마다 다른 JDK의 위치를 설정해 주면 된다.

![image](https://user-images.githubusercontent.com/84966961/125007361-fb432880-e09a-11eb-8068-ed880f9d1e47.png)

<br>

 7. 톰캣 설치 위치이므로 기억해두었다가 나중에 필요할 때 사용하자.

![image](https://user-images.githubusercontent.com/84966961/125007389-0b5b0800-e09b-11eb-963b-78c26d567ef7.png)

<br>

 8. 톰캣이 설치가 끝났다.

![image](https://user-images.githubusercontent.com/84966961/125007414-1b72e780-e09b-11eb-970b-edc1e3a55070.png)



<br><br>
<hr>

### 톰캣 설치 확인하는 방법 


1. ( 동원좌 설명 ) 웹 브라우저에서 주소창에 `http://localhost:8181/`을 입력하고 다음과 같은 창이 뜨게 되면 톰캣이 정상 설치 된 것이다.   

![image](https://user-images.githubusercontent.com/84966961/125008665-f0d65e00-e09d-11eb-8b93-27ff890021ac.png)

<br>

2. 또한, 오른쪽 아래 작업표시줄에서 톰캣을 확인할 수 있다.     
    
 만약 웹 서비스를 중단하고 싶으면 stop service 를 눌러 중단시킨다. 유지 보수 시 톰캣을 중단하여 유지보수 하게 된다.   
   
![image](https://user-images.githubusercontent.com/84966961/125008426-6ee63500-e09d-11eb-85c7-d3c1edbaff95.png)   

<br>

3. 서비스를 중단 시키면 다음과 같이 빨간 아이콘으로 변하고 웹 서버, 웹 사이트가 죽게 된다.   
   
![image](https://user-images.githubusercontent.com/84966961/125008635-dac89d80-e09d-11eb-9dba-1f96124b666b.png)   

<br>
    
4. 우리가 작업할 때는 톰캣이 정지된 상태에서 이클립스에 연동이 되므로 꺼놔야 한다. 그렇지 않으면 연동시 오류가 생기게 된다.   


<br><br>
<hr>

### 이클립스에서 톰캣 연동, 웹서버 개설

1. 서버 창을 열어보자 
   
![image](https://user-images.githubusercontent.com/84966961/125009032-b7522280-e09e-11eb-9560-7fe867101d60.png)   
   
![image](https://user-images.githubusercontent.com/84966961/125009055-c507a800-e09e-11eb-86e9-8faf93c9a736.png)   
   
 기존 로그창에 Server 창도 추가된 것을 확인 할 수 있다. 현재는 Server가 만들어지지 않아서 아무 것도 뜨지 않는다.   
    
![image](https://user-images.githubusercontent.com/84966961/125010223-16b13200-e0a1-11eb-8f02-d13d89e4125c.png)
    
 <br>   
   
 **톰캣 서버 버전 권고 사항**   
   
![image](https://user-images.githubusercontent.com/84966961/125010540-b078df00-e0a1-11eb-86fd-61570ba94f35.png)

<br>
    
2. 서버 개설을 위하여 Window > Preference 클릭한 후 다음 이미지를 따라 진행하면 된다. 

 *만약 이클립스가 enterprise 버전이 아니라면 Preference에 server가 보이지 않는다.*

![image](https://user-images.githubusercontent.com/84966961/125009120-dfda1c80-e09e-11eb-99dd-54630cd8e74f.png)

![image](https://user-images.githubusercontent.com/84966961/125009171-f4b6b000-e09e-11eb-82e8-7b5fd5f0b142.png)


<br>
    
3. 톰캣 서버를 연동해보자. add 클릭 후 톰캣 8.5 선택 후 next로 넘어가자.

![image](https://user-images.githubusercontent.com/84966961/125009218-0a2bda00-e09f-11eb-866e-2ceacded497d.png)


<br>
    
4. (1)톰캣 서버 설치 위치를 연동해준다.   
   
  만약 여러 JRE 버전이 깔려 있다면 (2)아래 부분 설정을 테스트 하고 싶은 JRE의 버전에 맞추어 설정해 주면된다.   
  
![image](https://user-images.githubusercontent.com/84966961/125011228-fe421700-e0a2-11eb-9fd9-8260dea68b6f.png)    
    

<br>
    
5. 활성화 된 Finish 버튼을 눌러 톰캣 서버를 연동하자.   
   
 Preferences 창에 톰캣 서버가 잡힌 것을 볼 수 있다. 창에 보이게 되면 이제 톰캣 서버를 사용할 수 있다.   
    
 이클립스에게 컴퓨터에 톰캣 8.5 버전의 존재를 알려주는 행동을 한 것이다.
   
![image](https://user-images.githubusercontent.com/84966961/125011382-51b46500-e0a3-11eb-8a69-94959aac3f4d.png)      
   

<br><br>
<hr>

### 이클립스에서 톰캣 연동, 웹서버 개설

1. 오른쪽 위에서 java EE, java, Debug 중에 java EE를 선택해서 웹 서버 관련 창으로 바꿀 수 있다.   
   
![image](https://user-images.githubusercontent.com/84966961/125012547-59750900-e0a5-11eb-872d-0f834842d0e4.png)   

<br>
    
2. 톰캣 서버를 등록시키자   
   
![image](https://user-images.githubusercontent.com/84966961/125012684-950fd300-e0a5-11eb-8678-86aecd94a45b.png)   

<br>
    
3. 이클립스에 서버가 등록된 것을 알 수 있다.   
    
![image](https://user-images.githubusercontent.com/84966961/125012735-a527b280-e0a5-11eb-87db-fde959a3b9c7.png)   

<br>
    
4. 초록색 플레이버튼을 누르면 서버를 실행해볼 수 있다.     
    
![image](https://user-images.githubusercontent.com/84966961/125012898-e3bd6d00-e0a5-11eb-95df-95e1db1d31c7.png)    
   
 서버 실행 후 작동 시간이 뜬 것을 콘솔에서 볼 수 있다. 또한 서버창에서 톰캣 서버가 `started` 상태인 것을 볼 수 있다.      
    
![image](https://user-images.githubusercontent.com/84966961/125012918-ecae3e80-e0a5-11eb-9029-55dec394af20.png)    

![image](https://user-images.githubusercontent.com/84966961/125013039-1d8e7380-e0a6-11eb-9e89-b3dee070a5a3.png)


<br><br>
<hr>

### 각종 세팅 및 새로운 환경 열기

 1. 인코딩 세팅.   
   
![image](https://user-images.githubusercontent.com/84966961/125015592-c17a1e00-e0aa-11eb-8c05-bb90cf0dfa2a.png)
   
![image](https://user-images.githubusercontent.com/84966961/125015671-e9698180-e0aa-11eb-8801-ad89a45b8bc9.png)
   
<br>
    
 2. 새로운 워크 스페이스 열기.   
   
![image](https://user-images.githubusercontent.com/84966961/125015767-1ae24d00-e0ab-11eb-8e03-58cffd028fed.png)
   
![image](https://user-images.githubusercontent.com/84966961/125015788-259ce200-e0ab-11eb-9a5d-7542390b7982.png)
   
<br>
    
 3. 저장을 원하는 위치를 정하고 launch하게 되면 리부팅 후 깔끔해진 워크 스페이스를 볼 수 있다.   
    
![image](https://user-images.githubusercontent.com/84966961/125015911-64cb3300-e0ab-11eb-987f-f2d854cbaa34.png)
    
<br>
    
 4. 짜잔~!   
   
![image](https://user-images.githubusercontent.com/84966961/125015955-78769980-e0ab-11eb-9573-223e616c158c.png)



<br><br>
<hr>

### 새로운 환경 구성.
   
1. 풀린 서버를 다시 설정 해주자! 기억이 안난다면 다음 이미지를 힌트삼아 해보자.   

**서버 연동**

![image](https://user-images.githubusercontent.com/84966961/125016057-a52ab100-e0ab-11eb-9a35-6db6492a8083.png)   
   
![image](https://user-images.githubusercontent.com/84966961/125016125-c390ac80-e0ab-11eb-9260-fb2f2ddf0c71.png)   

![image](https://user-images.githubusercontent.com/84966961/125016169-d4d9b900-e0ab-11eb-84fe-58d69613d1d5.png)   
   
<br>
  
**인코딩 설정**

![image](https://user-images.githubusercontent.com/84966961/125016464-60534a00-e0ac-11eb-8a97-df1fab01b560.png)   

![image](https://user-images.githubusercontent.com/84966961/125016520-74974700-e0ac-11eb-9aab-e83e3d28340c.png)   



<br><br>
<hr>

### 첫 Web Project 생성 및 환경 구성

1. 프로젝트를 생성해보자.

![image](https://user-images.githubusercontent.com/84966961/125017330-dd32f380-e0ad-11eb-91ed-3a234ac6b1a7.png)

![image](https://user-images.githubusercontent.com/84966961/125017431-1703fa00-e0ae-11eb-8ef1-413e593abd30.png)

   
<br>
  
 우리가 앞으로 사용할 영역은 src 폴더들이다.    

![image](https://user-images.githubusercontent.com/84966961/125017488-36028c00-e0ae-11eb-8f63-801c61b1ea09.png)

   
<br>
  
2. 새로운 jsp 파일을 만들어 보자.   

![image](https://user-images.githubusercontent.com/84966961/125017558-592d3b80-e0ae-11eb-8eed-041d48e55de0.png)

 확장자와 이름을 작성해주자. jsp 확장자이다.   
 
![image](https://user-images.githubusercontent.com/84966961/125017665-91cd1500-e0ae-11eb-8cab-e6b87ea568e1.png)

 HTML 골격에 JSP를 이용하여 구조를 만들어주는 것이다.     

![image](https://user-images.githubusercontent.com/84966961/125017698-a01b3100-e0ae-11eb-9c0c-0742691694c5.png)

건드릴 필요는 없지만 HTML 버전을 바꿀 수 있고 바꾸게 되면 아래처럼 DOCTYPE도 바뀌는 것을 볼 수 있다.      

![image](https://user-images.githubusercontent.com/84966961/125017716-a90c0280-e0ae-11eb-93c9-74f4c4c7a4c0.png)

생성하면 다음과 같은 익숙한 화면을 볼 수 있다.   

![image](https://user-images.githubusercontent.com/84966961/125017788-ce990c00-e0ae-11eb-95a6-bd438c64dd06.png)
    
![image](https://user-images.githubusercontent.com/84966961/125018242-afe74500-e0af-11eb-8449-e29f781eed7b.png)


우리가 이 페이지를 사용하려면 톰캣 서버에 올려줘야 한다.   

![image](https://user-images.githubusercontent.com/84966961/125017899-ff794100-e0ae-11eb-8955-9fae1fc00549.png)

 지금은 직접 올려줄 필요 없지만 지난 프로젝트를 사용하다보면 오류가 생기고 그 때마다 확인해야 할 경우가 생긴다. 그럴 때 사용할 수 있다. 보통은 톰캣이 알아서 올라가 있지 않은 페이지들을 올려주기 때문에 이 과정을 거칠 필요가 없다.   

![image](https://user-images.githubusercontent.com/84966961/125017981-23d51d80-e0af-11eb-9e53-3520a34a5314.png)

![image](https://user-images.githubusercontent.com/84966961/125018009-33ecfd00-e0af-11eb-82cf-09a400e070f2.png)

그 다음 run버튼(f11)을 눌러 실행시켜보자.   

![image](https://user-images.githubusercontent.com/84966961/125018122-71518a80-e0af-11eb-80b2-a496a8b5cb29.png)

실행 시키게 되면 다음과 같이 이클립스 내부 브라우저에서 작성했던 내용이 출력되는 것을 볼 수 있다.   

![image](https://user-images.githubusercontent.com/84966961/125018156-7e6e7980-e0af-11eb-9d5e-73e747da47de.png)

우리는 크롬 브라우저를 기본으로 쓸 것이므로 디폴트 브라우저를 변경해보자.   

`Window > Web Browser > 4 Chrome` 을 눌러 설정한 후 F11을 눌러 run 하면 크롬에서 창이 뜨는 것을 확인할 수 있다.

![image](https://user-images.githubusercontent.com/84966961/125018416-02c0fc80-e0b0-11eb-8b4b-a2c235f19e2f.png)

![image](https://user-images.githubusercontent.com/84966961/125018499-300daa80-e0b0-11eb-9663-0da92b446a29.png)


### 자바 서블릿(Java Servlet)

 자바를 사용하여 웹페이지를 동적으로 생성하는 서버측 프로그램 혹은 그 사양을 말하며, 흔히 "서블릿"이라 불린다. 

 서블릿이라는 개념을 사용하여 코딩을 한다. 자바 서블릿. JSP와 서블릿이 융합이 되어 어떻게 구성되는지를 이해해보자.

 서블릿은 보안 측면에서 좋기 때문에 앞에서 서블릿을 통해 구현되고 뒷단에서 JSP를 통해 유저(Client)가 원하는 페이지 구조를 구현해준다.

 java


1. 새로운 서블릿 생성. 서블릿을 만들때는 `src/main/java` 폴더를 우클릭하여 만들어야 한다. 이와 달리 JSP 파일은 위에서 다루었던 것처럼 `src` 폴더를 우클릭하여 생성한다.   
   
![image](https://user-images.githubusercontent.com/84966961/125019140-6992e580-e0b1-11eb-84ab-9111f353c2bc.png)    
   
   
<br>
  
2. 패키지 명과 클래스 명을 정해준 후 서블릿을 생성한다.   
    
![image](https://user-images.githubusercontent.com/84966961/125019316-bf678d80-e0b1-11eb-9b8e-ac6dd05eeef3.png)   
   
![image](https://user-images.githubusercontent.com/84966961/125019379-e625c400-e0b1-11eb-8bb0-1d274cfbc03c.png)   


<br>
  
 3. doGet 내부의 코드를 삭제한 후 코드를 작성한다. 실제 doGet에 들어가는 코드가 웹 페이지 상에서 구현되는 코드이다.      

![image](https://user-images.githubusercontent.com/84966961/125019416-fb025780-e0b1-11eb-8b94-c3a06c59ba80.png)
   
![image](https://user-images.githubusercontent.com/84966961/125019699-72d08200-e0b2-11eb-96d3-d0244f2bd49b.png)


<br>
  
 4. 작성한 코드를 바로 상용하는 것이 아니라 서블릿에서 HTML 코드를 만들어서 웹서비스로 구현될 수 있도록 만들어준 다음 웹브라우저로 넘겨서 출력하는 개념이다. 따라서 add를 띄우기 위해서는 다음과 같은 코드가 준비되어야 한다.    

```java
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int num1 = 10;
		int num2 = 20;
		int add = num1 + num2;
		
		PrintWriter out = response.getWriter();
	}
```

 작성 후 임포트 해주자.   

![image](https://user-images.githubusercontent.com/84966961/125019779-8e3b8d00-e0b2-11eb-8eed-8912612f7dee.png)


<br>
 
5. 이 후 출력하고 싶은 내용을 PrintWriter의 메소드인 print()를 통해 작성하고 HTML 구조의 내용으로 작성해주면 된다. 여기서 사용되는 print 가 system.out.println를 통해 사용하는 것과 같은 것이다.   

```java
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int num1 = 10;
		int num2 = 20;
		int add = num1 + num2;
		
		PrintWriter out = response.getWriter();
		out.print("<html><head><titie></title></head>");
		out.print("<body>");
		out.print(num1 +"+"+ num2 +"="+ add);
		out.print("</body></html>");
	}
```

<br>
 
 6. 하지만 이 클래스에는 main 이 없으므로 이 자체로는 실행하지 못한다. 따라서 본래는 이 코드를 사용하기 위해서는 url 호출을 통해 실행되어야 하지만 이클립스에서 run 버튼은 자동으로 실행시켜준다. 실행 후 `주소`도 한 번 확인해보자.   
   
_본인의 경우에는 수업 진행하는 동안 서버가 갑자기 오류가 나서 다음과 같은 오류가 났다. 서버를 리스타트 후 다시 run했더니 정상 작동 되었다._   
   
![image](https://user-images.githubusercontent.com/84966961/125020330-a069fb00-e0b3-11eb-9afc-d1fe77c58540.png)
   
![image](https://user-images.githubusercontent.com/84966961/125020505-ecb53b00-e0b3-11eb-9e65-fe3a68f67850.png)

서블릿을 활용하여 웹페이지를 구현하게 되면 이렇게 많은 코드가 필요하고 피로도가 누적되기 때문에 JSP로 이를 보완하여 사용한다.

<br>
 
#### 서블릿 설명

 doGet과 doPost의 역할은 동일하게 할 수 있다. 다만, 요청의 방식에 따라 사용도가 달라지게 된다.    
   
 각 메소드는 예외 처리를 throws로 던진다.     

![image](https://user-images.githubusercontent.com/84966961/125026921-6bb07080-e0c0-11eb-8d6f-b89423781e09.png)    

 이런 방식으로 웹 사이트의 화면을 구성하는 것은 옛 방식이며 현재는 동적인 웹 페이지를 구성하는데 쓰인다.    
     
 JSP의 도입으로 


<br>
 
### JSP 예제

 1. 앞의 add 예제를 JSP를 통해 만들어 보자. 새로운 JSP 파일 `Addition02`를 만들어 보자.   
   
![image](https://user-images.githubusercontent.com/84966961/125027160-c8ac2680-e0c0-11eb-8013-995daaeac5b2.png)   
   
![image](https://user-images.githubusercontent.com/84966961/125027229-e24d6e00-e0c0-11eb-9074-4835f11042ae.png)    

   

 2. HTML 구조에 JSP 양식을 끼워 사용한다고 하였다. 그렇기 때문에 다음과 같은 기호를 통해 태그에 끼워 사용한다. 또한 `<% %>` 사이에는 자바코드를 넣을 수 있다.   
   
![image](https://user-images.githubusercontent.com/84966961/125027573-6142a680-e0c1-11eb-9b50-5a3c8f2a8976.png)
   
**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/125027713-a1098e00-e0c1-11eb-9daf-2f9eb8cb29dc.png)




<br>
 
### 서블릿과 JSP의 비교

 서블릿과 JSP의 페이지 소스를 비교해보자. 실제 코드와 비교해보면 복잡한 코드와 달리 페이지 소스, 즉, 웹브라우저에서 인식하는 것은 HTML 밖에 인식 못하고 그것을 표현해주기 때문에 실제 코드가 어떻게 작성되었는지는 알 수 없다.

![image](https://user-images.githubusercontent.com/84966961/125027841-e62dc000-e0c1-11eb-90a4-8bf4a0e78c7b.png)

**서블릿 페이지 소스와 코드 화면**   
![image](https://user-images.githubusercontent.com/84966961/125027855-f180eb80-e0c1-11eb-97f3-1b12ef439f5d.png)

<img src="https://user-images.githubusercontent.com/84966961/125027979-2c831f00-e0c2-11eb-81bd-2e23f0ab3094.png" width="60%">



**JSP 페이지 소스와 코드 화면**    
![image](https://user-images.githubusercontent.com/84966961/125027873-fe054400-e0c1-11eb-933d-e4b1c7d46684.png)
<img src="https://user-images.githubusercontent.com/84966961/125027991-32790000-e0c2-11eb-8070-c5dad00ee6d9.png" width="50%">


<br><br>
 <hr>
 
### 서블릿과 JSP의 사용
    
 서블릿에서는 데이터를 가공하고 JSP에는 데이터를 넣어줄 양식을 만들어 데이터를 넣어 HTML 을 만들어 웹브라우저로 보내는 방식으로 Addtion03을 크롬에 띄워보자.    
   
먼저 서블릿 파일을 새로 만들어 코드를 작성하자.     

```java
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int num1 = 10;
		int num2 = 20;
		int add = num1 + num2;

		request.setAttribute("num1", num1);
		request.setAttribute("num2", num2);
		request.setAttribute("add", add);

		RequestDispatcher dispatcher = request.getRequestDispatcher("Addition03.jsp");
		dispatcher.forward(request, response);
	}
```

 서블릿에 `request.setAttribute("num1", num1);`로 데이터값을 저장하고 `RequestDispatcher dispatcher = request.getRequestDispatcher("Addition03.jsp");` jsp 양식을 이용하여 `dispatcher.forward(request, response);` 웹브라우저로 뿌리는 방식이다.   
   
![image](https://user-images.githubusercontent.com/84966961/125031030-fbf1b400-e0c6-11eb-952b-9f4f4e861d00.png)   

 서블릿의 데이터들이 jsp 파일의 `${ }`양식으로 들어가 HTML 파일을 구현하게 된다.
   
<br>
 
**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/125031106-1a57af80-e0c7-11eb-97c7-e141a298f587.png)   
   
주소값을 보면 jsp 파일이 아니라 서블릿이므로 실제 실행되는 파일을 알 수 없으므로 보안을 유지하는 데 도움이 된다. 만약 서블릿을 사용하지 않는다면 유료 페이지이지만 단순히 주소를 치고 들어가는 것으로 무료 회원이 유료 회원의 사이트를 들어가볼 수 있을 것이다.



<br><br>
 <hr>
 
### 서블릿 생성시 URL 주소 Mapping

 새로운 HelloServlet 이라는 서블렛을 만들 때 next 버튼을 눌러 다양한 속성값을 지정해줄 수 있다.

![image](https://user-images.githubusercontent.com/84966961/125031582-d0bb9480-e0c7-11eb-981c-c3375304ae3f.png)

 두번째 창에서는 실제 홈페이지 상에서 표기되는 URL 주소 값을 지정해줄 수 있다.

![image](https://user-images.githubusercontent.com/84966961/125031661-e466fb00-e0c7-11eb-9ff4-bb4eeb4902d4.png)

또한 3번째 창에서는 필요한 메소드 선택하고 받아 사용할 수 있다.

![image](https://user-images.githubusercontent.com/84966961/125031923-30b23b00-e0c8-11eb-9a4b-f4820daa8aed.png)

<br>

#### Hello Servlet 구현

1. 새로 만든 doGet에 코드를 구현해준다.   

```java
	// 우리가 이런 타입을 구성하고 사용할 것이라는 것을 명시적으로 알려준다.
	response.setContentType("text/html");
	// html 형태로 웹브라우저를 실행하겠다.

	PrintWriter out = response.getWriter();
	out.print("<html><head><titie></title></head>");
	out.print("<body>");
	out.print("Hello Servelet");
	out.print("</body></html>");
```

![image](https://user-images.githubusercontent.com/84966961/125033565-6b1cd780-e0ca-11eb-84ce-e94460280de0.png)

<br>

2. Server.xml 파일 내부에서 context를 보게되면 path 부분의 값이 주소의 path를 보여주고 있다.

![image](https://user-images.githubusercontent.com/84966961/125033335-2729d280-e0ca-11eb-8cdd-9d36c9648651.png)

<br>

3. 웹브라우저에서 띄울 때 간혹 한글이 깨지는 경우가 발생하는데 그럴 때는 `charset=UTF-8` 속성을 넣어 처리해주면 문제가 해결된다.

**문제 화면**    
![image](https://user-images.githubusercontent.com/84966961/125033963-fdbd7680-e0ca-11eb-9afd-365cff9d1e59.png)    
    
```java
	// 우리가 이런 타입을 구성하고 사용할 것이라는 것을 명시적으로 알려준다.
	response.setContentType("text/html;charset=UTF-8");
	// html 형태로 웹브라우저를 실행하겠다.
	// charset=UTF-8를 통해 웹브라우저가 한글을 인식하여 깨짐을 방지하게 해준다.

	PrintWriter out = response.getWriter();
	out.print("<html><head><titie></title></head>");
	out.print("<body>");
	out.print("Hello Servelet 안녕하세요");
	out.print("</body></html>");
```

**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/125034098-2ba2bb00-e0cb-11eb-9eae-0cd7db375461.png)    
   



<br><br>
 <hr>
 
### form 태그와 서블릿의 데이터 두 가지 처리 방식

 HTML에서 form 태그는 데이터를 서버로 보내 처리하는 용도의 태그이다. get방식은 주소창에 주소값이 그대로 노출되고 post방식은 주소창에 path값이 나오지 않는다.   

<br>

1. 새로운 `method.jsp`를 만든 후 다음과 같이 작성한다.   

 method에는 원하는 방식을 넣어주고(설정하지 않으면 get으로 된다.) action에는 URL 매핑 정보를 넣어준다.

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

	<form method="get" action="MethodServelet">
		<input type="submit" value="get방식의 호출">
	</form>
	
	<form method="post" action="MethodServelet">
		<input type="submit" value="post방식의 호출">
	</form>
	
</body>
</html>
```

 <br>

2. 새로운 서블릿을 doGet, doPost 모두 존재하게 생성한 후 작성한다.

```java
public class MethodServelet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print("<h1>get방식으로 처리됨</h1>");
		out.close();
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print("<h1>post방식으로 처리됨</h1>");
		out.close();
	}

}
```

<br>

#### 결과와 흐름

![image](https://user-images.githubusercontent.com/84966961/125038182-167c5b00-e0d0-11eb-8cd8-1adb06965826.png)   

 주소값을 직접 넣는 방식은 get 방식으로 페이지에 접속하는 방법이다. jsp를 통해 get방식을 누르게 되면 `http://localhost:8181/webstudy01/MethodServelet?` 라는 주소값이 뜨게 된다.     
 
![image](https://user-images.githubusercontent.com/84966961/125038011-d9b06400-e0cf-11eb-8b28-59ce4d7a087d.png)   

하지만 post방식 호출 버튼을 누르면 post 방식을 처리된 페이지가 보이게 된다. 하지만 이 화면에서 다시 주소를 입력해서 직접 들어가게 되면 get방식으로 처리된 페이지가 로드된다.   

![image](https://user-images.githubusercontent.com/84966961/125038241-272cd100-e0d0-11eb-8c45-e9ccf89c4ccb.png)   
![image](https://user-images.githubusercontent.com/84966961/125038366-4c214400-e0d0-11eb-8248-fc92f5c39725.png)   



<br><br>
 <hr>
 
### a버튼과 get방식의 호출   
 
a 버튼 또한 get방식의 호출이다. 따로 method를 정해주지 않았지만 주소값을 이용해서 들어가기 때문에 get방식으로 처리되는 것이다.
 
```html
	<form method="get" action="MethodServelet">
		<input type="submit" value="get방식의 호출">
	</form>
	<br>
	
	<a href="http://localhost:8181/webstudy01/MethodServelet">get방식 호출</a>
	
	<br>
	<form method="post" action="MethodServelet">
		<input type="submit" value="post방식의 호출">
	</form>
```

![image](https://user-images.githubusercontent.com/84966961/125038627-97d3ed80-e0d0-11eb-8b08-b6bdc6e144b3.png)




<br><br>
 <hr>
 
### 파라미터(parameter)
   
1. 파라미터를 위한 jsp 생성.    
    
 다음 코드에서 input을 통해 작성된 데이터가 submit 버튼을 클릭하는 순간 form 태그의 action값인 `ParamServlet`로 자료를 보내고 우리는 해당 서블릿에서 데이터를 받아 처리를 하는 코드를 작성하여 데이터를 받아 사용할 것이다. name 이라는 파라미터에 작성된 데이터가 저장된 상태로 서블릿에서는 파라미터를 사용하여 데이터를 구체적으로 받게 된다.   
    
 get 방식을 이용하게 되면 주소창에 파라미터와 데이터들이 함께 보내지고 이는 종종 보안에 좋지 않을 수 도 있다. 그럴 때는 주소창에 매핑 정보만 나오는 post 방식을 사용하는 것이 좋을 것으로 생각된다.

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
	<form method="get" action="ParamServlet">
		아이디 : <input type="text" name="id"><br>
		나 이 : <input type="text" name="age"><br>
		<input type="submit" name="전송"><br>
		
	</form>
</body>
</html>
```
    
<br>
    
2. 서블릿 작성

 `request.getParameter`에 파라미터를 매개 변수로 넣어 jsp에서 보낸 데이터를 받고 처리하는 과정(데이터를 다시 출력하는 과정)을 거쳐 실행되게 된다.

```java
@WebServlet("/ParamServlet")
public class ParamServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String id = request.getParameter("id"); // name이(파라미터가) id인 것의 데이터값을 String 상태로 받아온다.
		String age = request.getParameter("age"); // name이(파라미터가) age인 것의 데이터값을 String 상태로 받아온다.

//		getParameter 양식
//		String getParameter(String name)

		// 화면 출력.
		out.print("<html><head><titie></title></head>");
		out.print("<body>");
		out.print("당신이 입력한 정보입니다.<br>");
		out.print("<br>id : " + id);
		out.print("<br>age : " + age);
		// 뒤로가기(history.go(-1)) a 태그 버튼 생성.
		out.print("<br><a href= 'javascript:history.go(-1)'>다시</a>");		
		out.print("</body></html>");

	}

}
```

**결과 화면**   
   
![image](https://user-images.githubusercontent.com/84966961/125041735-0d8d8880-e0d4-11eb-810e-b1bdc710fa62.png)   
   
제출 버튼 클릭 후    
   
![image](https://user-images.githubusercontent.com/84966961/125041932-462d6200-e0d4-11eb-88ef-bd10cafbd2e6.png)   
   
결과 화면을 보면 우리가 넣었던 데이터와 파라미터가 함께 주소창에 출력되는 것을 볼 수 있다.    
   
`다시` 버튼을 누르면 자바스크립트 코드에 의해 history에서 한단계 전으로 이동한다.   
   
![image](https://user-images.githubusercontent.com/84966961/125042346-af14da00-e0d4-11eb-9f6e-b988e2593f5a.png)    
   






<br><br>
 <hr>
 







