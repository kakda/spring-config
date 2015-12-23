$(document).ready(function () {
    $(".integer").autoNumeric({
        aNum: "0123456789",
        aSep: "",
        dGroup: "3",
        aDec: ".",
        altDec: null,
        aSign: "",
        pSign: "p",
        vMax: "999999999999999999999999999999",
        vMin: "0",
        mDec: null,
        mRound: "S",
        aPad: false,
        wEmpty: "zero",
        aForm: false
    });
    $(".letter").autoNumeric({
        aNum: "abcdefghijklmnopqrstuvwxyz"
    });
    $(".decimal").autoNumeric({
        aNum: "0123456789",
        aSep: "",
        dGroup: "3",
        aDec: ".",
        altDec: null,
        aSign: "",
        pSign: "p",
        vMax: "999999999999999999999999999999.99",
        vMin: "0.00",
        mDec: null,
        mRound: "S",
        aPad: true,
        wEmpty: "zero",
        aForm: false
    });
    $(".save").button({
        icons: {
            primary: "ui-icon-disk"
        }
    });
    $(".cancel").button({
        icons: {
            primary: "ui-icon-cancel"
        }
    });
    $(".next").button({
        icons: {
            primary: "ui-icon-seek-next"
        }
    });
    $(".add").button({
        icons: {
            primary: "ui-icon-circle-plus"
        }
    });
    $(".list").button({
        icons: {
            primary: "ui-icon-triangle-1-w"
        }
    });
    $(".delete").button({
        icons: {
            primary: "ui-icon-trash"
        }
    });
    $(".search").button({
        icons: {
            primary: "ui-icon-search"
        }
    });
    $(".right").button({
        icons: {
            primary: "ui-icon-circle-check"
        }
    });
    $(".add").button({
        icons: {
            primary: "ui-icon-plusthick"
        }
    });
    $(".copy").button({
        icons: {
            primary: "ui-icon-copy"
        }
    });
    $(".prev").button({
        icons: {
            primary: "ui-icon-triangle-1-w",
            text: false
        }
    });
    $(".next").button({
        icons: {
            secondary: "ui-icon-triangle-1-e",
            text: false
        }
    });
    $(".down").button({
    	icons: {
            primary: "ui-icon-arrowthick-1-s"
    	}
    });
    $(".edit").button({
    	icons: {
            primary: "ui-icon-pencil"
    	}
    });
    $(".select-single").chosen();
    $(".date").datepicker();
});
var deleteSelctedRow = function (a, b, c) {
        var d = ".html";
        var e = $(a).getGridParam("selarrrow");
        if (e.length) {
            $("#dialog").html("តើអ្នកអ្នកពិតជាចង់លុបទិន្នន័យដែលបានជ្រើសរើសមែនរឺ?");
            $("#dialog").dialog({
                resizable: false,
                height: "auto",
                modal: true,
                title: "ព្រមាន",
                position: "center",
                buttons: {
                	"យល់ព្រម": function () {
                		$("#dialog").dialog("close")
                        $("#loading").slideToggle(100, function () {
                            for (var f = 0; f < e.length;) {
                            	var res;
                                var g = $(a).jqGrid("getCell", e[f], c);
                                $.ajax({
                                    url: b + g + d,
                                    type: "post",
                                    async: false,
                                    success: function (b) {
                                    	res=$.trim(b);
                                        if ($.trim(b) == "true") {
                                            $(a).jqGrid("delRowData", e[f])
                                        }
                                    }
                                });
                                if(res!="true")
                                { 	
                                	$("#dialog").html("កម្មវិធីមិនអាចលុបទិន្ន័យនេះបានទេ <br/>វាកំពុងត្រូវបានប្រើប្រាស់នៅក្នុងមុខងារផ្សេងទៀត។");
	                                $("#dialog").dialog({
	                                    resizable: false,
	                                    height: 140,
	                                    modal: true,
	                                    title: "Error",
	                                    position: "center",
	                                    buttons: {
	                                        OK: function () {
	                                            $(this).dialog("close")
	                                        }
	                                    }
	                                });
                                	break;
                                }
                            }
                            $("#loading").slideToggle(300)
                        });
                        
                    },
                    "ចាកចេញ": function () {
                        $("#dialog").dialog("close")
                    }
                }
            })
        } else {
            $("#dialog").html("សូមជ្រើសរើសទិន្នន័យជាមុន.");
            $("#dialog").dialog({
                resizable: false,
                modal: true,
                height: "auto",
                title: "Error",
                position: "center",
                buttons: {
                	"យល់ព្រម": function () {
                        $(this).dialog("close")
                    }
                }
            })
        }
    };
var gridAction = function (grid, prefixUrl, fieldId, isEdit, isView, isDelete) {
        var d = jQuery(grid).jqGrid("getDataIDs");
        for (var e = 0; e < d.length; e++) {
            var f = d[e];
            var row = "";
            if(isEdit)
                row += "<button class='btnEdit' value='" + f + "' >កែប្រែ</button>"; 
            if(isView)
            	row += "<button class='btnView' value='" + f + "' >ពិនិត្យ</button>";	
            if(isDelete){
            	row += "<button class='btnDelete' value='" + f + "' >លុប</button>";
            jQuery(grid).jqGrid("setRowData", d[e], {
                act: row
            })
        }
        if(isEdit){
            $(".btnEdit").button({
                text: false,
                icons: {
                    primary: "ui-icon-pencil"
                }
            }).click(function (a) {
                a.preventDefault();
                var b = $(grid).jqGrid("getCell", $(this).val(), fieldId);
                window.location = prefixUrl+"update/" + b + ".html"
            });
        }
        if(isView){
            $(".btnView").button({
                text: false,
                icons: {
                    primary: "ui-icon-newwin"
                }
            });
            $(".btnView").click(function (a) {
                a.preventDefault();
                var b = $(grid).jqGrid("getCell", $(this).val(), fieldId);
                window.location = prefixUrl+"view/" + b + ".html"
            });	
        }
        if(isDelete){
	        $(".btnDelete").button({
	            text: false,
	            icons: {
	                primary: "ui-icon-trash"
	            }
	        });
	        $(".btnDelete").click(function (a) {
	            a.preventDefault();
	            var b = $(this).val();
	            var c = $(grid).jqGrid("getCell", b, fieldId);
	            $("#dialog").html("តើអ្នកពិតជាចង់លុប [" + c + "] មែនរឺ?");
	            $("#dialog").dialog({
	                resizable: false,
	                height: "auto",
	                modal: true,
	                title: "ព្រមាន",
	                position: "center",
	                buttons: {
	                    "យល់ព្រម": function () {
	                    	$("#dialog").dialog("close");
	                        $.ajax({
	                            url: prefixUrl + "doDelete/" + c + ".html",
	                            type: "post",
	                            beforeSend: function () {
	                                $("#loading").slideToggle(100)
	                            },
	                            success: function (a) {
	                                if ($.trim(a) == "true") {
	                                    $(grid).jqGrid("delRowData", b)
	                                }
	                                else{
	                                	$("#dialog").html("កម្មវិធីមិនអាចលុបទិន្ន័យនេះបានទេ <br/>វាកំពុងត្រូវបានប្រើប្រាស់នៅក្នុងមុខងារផ្សេងទៀត។");
		                                $("#dialog").dialog({
		                                    resizable: false,
		                                    height: 140,
		                                    modal: true,
		                                    title: "Error",
		                                    position: "center",
		                                    buttons: {
		                                        OK: function () {
		                                            $(this).dialog("close")
		                                        }
		                                    }
		                                });
	                                }
	                                $("#loading").slideToggle(300);
	                                
	                            }
	                        })
	                    },
	                    "ចាកចេញ": function () {
	                        $(this).dialog("close")
	                    }
	                }
	            })
	        })
        }
    }
}

Date.prototype.getWeek = function() {
	var onejan = new Date(this.getFullYear(),0,1);
	return Math.ceil((((this - onejan) / 86400000) + onejan.getDay()-1)/7);
} ;

Array.prototype.add=function(object){
	this[this.length]=object;
};
Array.prototype.each=function(callback){
	for(var i=0;i<this.length;i++){
		if(callback(this[i],i)==0) return;
	}
};
Array.prototype.exist=function(findObject){
	var res=-1;
	this.each(function(value,idx){
		if(value==findObject)
		{	res=idx;
			return 0;
		}
	});
	return res;
};
Array.prototype.removeAt=function(idx){
	if(idx>=0 && idx<this.length)
	{	this.splice(idx,1);
		return true;
	}
	return false;
};
Array.prototype.remove=function(removeObject){
	return this.removeAt(this.exist(removeObject));
};

String.prototype.toNumber = function(){
	var val = parseFloat(this) || 0;
	val = parseInt(Math.round(val*100))/100;
	return val;
}
Number.prototype.toNumber = function(){
	var val = this;
	val = parseInt(Math.round(val*100))/100;
	return val;
}
Boolean.prototype.toNumber = function(){
	return 0;
}