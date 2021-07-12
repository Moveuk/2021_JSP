<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <style>
            table {
                text-align: left;
            }
            
            .col1 {
                width: 250px;
            }

            .col2 {
                width: 700px;
            }

            input {
                width: 250px;
            }

            .left input {
                display: inline-block;
                text-align: left;

            }

            .btns {
                margin: 0 auto;
            }

            .btn {
                margin: 0 auto;
                display: inline-block;
                margin: 1px;
            }
        </style>
    </head>

    <body>
        <div class="contents">
            <form action="QuizServlet">
                <table>
                    <thead>
                        <colgroup>
                            <col class="col1">
                            <col class="col2">
                        </colgroup>
                    </thead>
                    <tbody>
                        <tr>
                            <td>이름</td>
                            <td><input type="text" id="name" size="4" value="이동욱" autofocus required></td>
                        </tr>
                        <tr>
                            <td>주민등록번호</td>
                            <td><input type="text" id="psno1" size="7" value="920525" required> - <input type="text" id="psno2" size="7" value="1548644" required></td>
                        </tr>
                        <tr>
                            <td>아이디</td>
                            <td><input type="text" id="id" size="30" value="moveuk" required></td>
                        </tr>
                        <tr>
                            <td>비밀번호</td>
                            <td><input type="password" id="password" size="20" value="1234" required></td>
                        </tr>
                        <tr>
                            <td>비밀번호 확인</td>
                            <td><input type="password" id="pass_chk" size="20" value="1234" required></td>
                        </tr>
                        <tr>
                            <td>이메일</td>
                            <td><input type="text" id="email_id" size="20" value="moveuk"> @ <input type="text" id="email_site" size="20"> <select name="site"
                                    id="email_select">
                                    <option value="naver.com">naver.com</option>
                                    <option value="nate.com">nate.com</option>
                                    <option value="gmail.com">gamil.com</option>
                                    <option value="yahoo.com">yahoo.com</option>
                                    <option value="etc">etx</option>
                                </select></td>
                        </tr>
                        <tr>
                            <td>우편번호</td>
                            <td><input type="text" id="post" size="7" value="150-797"></td>
                        </tr>
                        <tr>
                            <td>주소</td>
                            <td><input type="text" id="addr1" size="100" value="서울시 영등포구"> <input type="text" id="addr2" size="100" value="영등포본동"></td>
                        </tr>
                        <tr>
                            <td>핸드폰번호</td>
                            <td><input type="tel" id="mobile" size="13" value="010-1000-1000"></td>
                        </tr>
                        <tr>
                            <td><label for="job">직업</label></td>
                            <td>
                                <label for="job"></label> 
                                <select id="job" name="job">
                                    <option value="">선택하세요</option>
                                    <option value="학생">학생</option>
                                    <option value="컴퓨터/인터넷">컴퓨터/인터넷</option>
                                    <option value="언론">언론</option>
                                    <option value="공무원">공무원</option>
                                    <option value="군인">군인</option>
                                    <option value="서비스업">서비스업</option>
                                    <option value="교육">교육</option>
                                    <option value="기타">기타</option>
                                </select>
                            </td>
                        </tr>
                        <tr class="left">
                            <td><label for="chk_mail">메일/SMS 정보 수신</label></td>
                            <td><input type="radio" name="chk_mail" id="chk_mail" value="yes" checked>수신 <input type="radio" name="chk_mail" id="chk_mail" value="no">수신거부</td>
                        </tr>
                        <tr class="left">
                            <td>관심분야</td>
                            <td>
                                <input type="checkbox" name="interest" value="생두" checked> 생두 
                                <input type="checkbox" name="interest" value="원두"> 원두 
                                <input type="checkbox" name="interest" value="로스팅" checked> 로스팅  
                                <input type="checkbox" name="interest" value="핸드드립" checked> 핸드드립 
                                <input type="checkbox" name="interest" value="에스프레소"> 에스프레소 
                                <input type="checkbox" name="interest" value="창업"> 창업 
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="btns">
                    <button type="submit" class="btn">회원가입</button>
                    <button type="reset" class="btn">취소</button>
                </div>
            </form>
        </div>
    </body>

    </html>