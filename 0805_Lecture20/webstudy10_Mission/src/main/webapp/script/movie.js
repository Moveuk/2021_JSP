function productCheck() {
	if (document.frm.name.value.length == 0) {
		alert("상품명을 넣어주세요.");
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
	return true;
}