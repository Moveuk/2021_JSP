function movieCheck() {
	if (document.frm.title.value.length == 0) {
		alert("제목을 넣어주세요.");
		document.frm.name.focus();
		return false;
	}
	if (document.frm.price.value.length == 0) {
		alert("가격을 넣어주세요.");
		document.frm.price.focus();
		return false;
	}
	if (isNaN(document.frm.price.value)) {
		alert("가격은 숫자이어야만 합니다.");
		document.frm.price.focus();
		return false;
	}
		if (document.frm.director.value.length == 0) {
		alert("감독을 넣어주세요.");
		document.frm.name.focus();
		return false;
	}
		if (document.frm.actor.value.length == 0) {
		alert("배우를 넣어주세요.");
		document.frm.name.focus();
		return false;
	}
		if (document.frm.synopsis.value.length == 0) {
		alert("설명을 넣어주세요.");
		document.frm.name.focus();
		return false;
	}
	
	return true;
}