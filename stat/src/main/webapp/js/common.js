function adjustTable(tab) {
	var a = $("div.dataTables_wrapper").width();
    var b = $("#table").width();
    var c = tab.width();
    //console.log(a + "/" + b + "/" + c);
    
    if (c > b) {
    	//console.log("table 맞춤");
    	$("div.dataTables_wrapper").css("width", $("#table").css("width"));
    } else {
    	//console.log("tab 맞춤");
    	$("div.dataTables_wrapper").css("width", tab.css("width"));
    }
    
    $("#table").DataTable().fixedColumns().update();
}