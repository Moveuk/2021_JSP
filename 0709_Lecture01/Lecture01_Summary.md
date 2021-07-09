# Lecture1 JSP
Key Word : JSP, 톰캣 설치, Port 설정, 톰캣 서버 연동, 개발 환경 구성, 인코딩 설정, 

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





