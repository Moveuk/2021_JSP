function check() {
	// input 값이 null 인지 체크
	if (document.frm.id.value == "") {
		alert("아이디를 입력하세요");
		document.frm.id.focus()
		return false;
	} else if (document.frm.age.value == "") {
		alert("나이를 입력하세요");
		document.frm.id.focus();
		return false;
	} else if (isNaN(documetn.frm.age.value)) {
	// 나이에 숫자가 들어있는지 확인
	// is Not a Number : 숫자인지 아닌지
		alert("숫자로 입력하세요.");
		document.frm.age.focus();
		return false;
	} else {
		return true;
	}
}
