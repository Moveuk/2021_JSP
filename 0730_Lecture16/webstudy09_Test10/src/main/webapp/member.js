	function joinCheck() {
		if (document.frm.id.value == "") {
			alert("아이디를 입력해주세요.");
			frm.id.focus();
			return false;
		}
		if (document.frm.password.value == "") {
			alert("비밀번호를 입력해주세요.");
			frm.password.focus();
			return false;
		}
		if (document.frm.name.value.length == 0) {
			alert("이름을 입력해주세요.");
			frm.name.focus();
			return false;
		}
		if (document.frm.age.value.length == 0) {
			alert("나이를 입력해주세요.");
			frm.age.focus();
			return false;
		}
		if (document.frm.gender.value.length == 0) {
			alert("성별을 체크해주세요.");
			frm.age.focus();
			return false;
		}
		if (document.frm.email.value.length == 0) {
			alert("이메일을 입력해주세요.");
			frm.email.focus();
			return false;
		}
		return submitForm();
	}
	function submitForm() {
		var frm = document.frm;
	    frm.setAttribute("id", frm.id.value);
	    frm.setAttribute("password", frm.password.value);
	    frm.setAttribute("name", frm.name.value);
	    frm.setAttribute("age", frm.age.value);
	    frm.setAttribute("gender", frm.gender.value);
	    frm.setAttribute("email", frm.email.value);
		frm.setAttribute("action", "joinProcess.jsp");
		frm.setAttribute("method", "Post");
		frm.submit();
	}