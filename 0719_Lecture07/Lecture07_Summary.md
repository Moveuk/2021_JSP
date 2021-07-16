# Lecture07 5장 JSP 내장 객체와 액션 태그

Key Word : 세션(session) 

<hr>

  
## 교재 242p : 세션(session) 

 쿠키를 설명할 때 (다른 페이지로 이동하더라도 그 전 페이지의 정보가 유지되어야 하는) 상태 유지를 위한 특별한 기법이 필요하다는 설명을 하였다. 하지만 쿠키는 클라이언트의 컴퓨터에 정보를 저장하여 사용하므로 보안에 문제가 될 수 있다. 또한 저장할 수 있는 데이터의 양도 1.2MB로 한계가 있다.   
    
 이러한 단점을 극복하기 위해서 나온 상태 유지 방법 중의 하나가 세션이다. 세션은 다음과 같은 장점이 있다.
 
 - JSP(서버)에서만 접근 가능하므로 보안 유지에 강력하다.
 - 저장할 수 있는 데이터에 한계가 없다.   
   
 세션은 서버상에 존재하는 객체로서 브라우저 단위당 한개 씩 존재하게 된다. 세션은 웹 브라우저를 닫기 전까지 페이지를 이동하더라도 사용자의 정보를 잃지 않고 서버에 보관할 수 있도록 하는 객체이다.   
    
 이러한 세션이 활용되는 대표적인 예는 로그인 페이지이다.




<br><br>
<hr>
  
### 세션(session) 사용하기

 다음은 session에서 자주 사용되는 메소드를 정리한 표이다.

메서드 | 설명
-|-
java.lang.Object getAttribute(String name) | · 세션에서 데이터를 얻습니다. <br> · 없을 경우 null을 반환한다.<br> · 반환 값은 Object 형이므로 반드시 형 변환을 하여 사용해야 한다.
java.util.Enumeration getAttributeNames() | · 세션에 저장되어 있는 모든 데이터의 이름(유니크한 키값)을 얻습니다. <br> · 반환 값이 Enumeration 형으로 얻어준다.
long getCreationTime() | · 세션이 생성된 시간을 반환합니다. <br> ·       시간은 1970년1월1일 이후 흘러간 시간을 의미합니다.  <br> ·       단위는 1/1000초 <br> ·       yyyy년 mm월 dd일 00시 00분 00초부터 <br> 해당 세션이 생성된 순간까지의 경과 시간을 밀리 초로 계산하여 long형으로 리턴함
String getId() | ·       자동 생성된 세션의 고유 ID를 반환합니다. <br> ·       해당 세션의 세션ID 문자열을 리턴합니다. <br> ·       세션 ID는 session 객체 생성시에 웹컨테이너에 의해 자동으로 할당됨
long getLastAccessedTime() | ·       웹 브라우저가 가장 마지막에 섹션에 접근한 시간을 반환합니다. <br> · 즉 세션동안 클라이언트가 마지막으로 서버에 보낸 요청시간을 반환합니다. <br> ·       시간은 1970년1월1일 이후 흘러간 시간을 의미. <br> ·       단위는 1/1000초
int getMaxinactiveInterval() | ·       설정된 세션 유효시간을 반환합니다. <br> ·       가장 최근 요청시점을 기준으로 카운트 됩니다. <br> ·       C:\CodeLab\apache-tomcat-7.0.65\conf\web.xml 참조 <br> ·       클라이언트의 요청이 없을 시 서버가 해당 세션을 유지하도록 <br> 지정된 시간을 초 단위 정수로 리턴합니다.
boolean isNew() | ·       세션이 최초 생성되었는지, 이전에 생성된 세션인지를 구분 합니다. <br> ·       새로운 세션이면 true 를 리턴하고 기존 세션이 유지되고 있으면 false 를 리턴합니다. <br> ·       웹서버가 쿠키기반의 세션을 생성했지만 클라이언트가 쿠키를 사용하지 못하도록 한 경우 <br> 세션은 아직 new상태이고 isNew()메소드는 true를 반환합니다.
removeAttribute(String name) | ·       세션에서 특정 데이터 제거 합니다.
setAttribute(String name, Object value) | ·       세션에 데이터를 저장 합니다.
void setMaxInactiveInterval(int second) | ·       세션 유효시간을 초단위로 설정합니다. <br> ·       클라이언트의 요청이 없더라도 세션을 유지할 시간을 초 단위의 정수값으로 설정합니다. <br> ·       음수로 설정할 경우 세션은 무효화되지 않습니다.
invalidate() | ·       세션을 종료시키고 연결된 객체를 해제합니다. <br> ·       세션의 모든 데이터를 삭제 합니다.(현재 세션을 종료)<br> ·       세션을 없애고 세션에 속해있는 값들을 모두 제거합니다. <br> 세션의 속성값으로 저장된 모든 객체를 반납하여 해당 세션을 종료시킵니다.


**이외의 메소드들**

메서드 | 설명
-|-
String[] getValueNames() | ·       세션에 연결된 모든 객체의 이름을 배열로 반환합니다. <br> ·       deprecated <br> ·       getAttributeNames() 사용으로 대체
HttpSession getSession() | ·       요청한 클라이언트에 지정된 HttpSession 객체 <br> ·        이전에 생성된 HttpSession 객체가 없으면 새로운 객체를 생성
HttpSession getSession(Boolean create) |·       create 가 true 일 경우 getSession() 메서드와 동일한 결과를 리턴 <br> ·        하지만 create 를 false로 지정하면 이전에 생성된 <br> HttpSession 객체가  없을 경우 null 을 리턴 한다.
boolean isRequestedSessionIdValid() | ·       요청에 포함된 클라이언트의 세션 ID가 유효하면 <br> true 를 리턴하고 유효하지 않으면 false를 반환합니다.
String getReqeustedSessionID() | ·       요청한 클라이언트에 지정된 세션의 ID를 문자열로 리턴
setAttribute() | ·       세션에 데이터를 저장 합니다.
removeAttribute() | ·       세션에서 특정 데이터 제거 합니다.
Object getValue(String name) | ·       Deprecated <br> ·       세선에서 지정한 이름으로 연결된 객체를 반환합니다. <br> ·        getAttribute(java.lang.String)로 대체
putValue(String name, Object value) | ·       Deprecated <br> ·       세션에 지정한 name(String)을 이용하여 value(Objet)를 연결합니다. <br> ·       만들 동일한 name으로 value가 이미 연결되어 있다면 새로운 value으로 변경됩니다. <br> ·       name(String)은 연결할 객체의 이름이고, value는 String과 같은 Object유형의 값으로만 설정할 수 있습니다. <br> ·       setAttribute(java.lang.String, java.lang.Object)로 대체
removeValue(String name) | ·       Deprecated <br> ·       세션으로 부터 지정한 name을 가진 객체의 연결을 제거합니다. <br> ·       removeAttribute(java.lang.String)로 대체





