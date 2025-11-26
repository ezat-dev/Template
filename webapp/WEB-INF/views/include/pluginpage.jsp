<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 제이쿼리홈페이지 js -->
<script type="text/javascript" src="/ezPublic/js/jquery-3.7.1.min.js"></script>

<!-- Tabulator 테이블 -->
<script type="text/javascript" src="/ezPublic/js/tabulator/tabulator.js"></script>
<link rel="stylesheet" href="/ezPublic/css/tabulator/tabulator_simple.css">

<!-- moment -->
<script type="text/javascript" src="/ezPublic/js/moment/moment.min.js"></script>

<!-- 화면캡쳐용 -->
<script type="text/javascript" src="/ezPublic/js/html2canvas.js"></script>


<!-- 하이차트 -->
<script type="text/javascript" src="/ezPublic/js/highchart/highcharts.js"></script>
<script type="text/javascript" src="/ezPublic/js/highchart/exporting.js"></script>
<script type="text/javascript" src="/ezPublic/js/highchart/export-data.js"></script>
<script type="text/javascript" src="/ezPublic/js/highchart/data.js"></script>


<!-- Air Datepicker -->
<script type="text/javascript" src="/ezPublic/js/airdatepicker/datepicker.min.js"></script>
<script type="text/javascript" src="/ezPublic/js/airdatepicker/datepicker.ko.js"></script>
<link rel="stylesheet" href="/ezPublic/css/airdatepicker/datepicker.min.css"> 

<style>
	
</style>
<script>

$(function(){
	rpImagePopup();
	
	//airDatePicker 설정
	//날짜 : 일
	 $(".daySet").datepicker({
    	language: 'ko',
    	autoClose: true,
    }); 
	    
	//날짜 : 월
   $(".monthSet").datepicker({
	    language: 'ko',           // 한국어 설정
	    view: 'months',           // 월만 표시
	    minView: 'months',        // 월만 선택 가능
	    dateFormat: 'yyyy-mm',    // 연도-월 형식 지정
	    autoClose: true,          // 월 선택 후 자동 닫힘
	});
   

    //날짜 : 년
	 $(".yearSet").datepicker({
	  language: 'ko',
      view: 'years',          // 연도만 표시
      minView: 'years',       // 연도만 표시하여 날짜 선택 비활성화
      dateFormat: 'yyyy',     // 연도 형식 지정
      autoClose: true,        // 연도 선택 후 자동 닫힘
      language: 'ko'          // 한국어 설정
  });
	
	
});

//오늘날짜 년-월-일
function todayDate(){
	var now = new Date();
	var y = now.getFullYear();
	var m = paddingZero(now.getMonth()+1);
	var d = paddingZero(now.getDate());
		
	return y+"-"+m+"-"+d; 
}

//어제날짜 년-월-일
function yesterDate(){
	var now = new Date();
	var y = now.getFullYear();
	var m = paddingZero(now.getMonth()+1);
	var d = paddingZero(now.getDate()-1);
		
	return y+"-"+m+"-"+d; 	
}

//현재시간
function nowTime(){
	var now = new Date();
	var h = paddingZero(now.getHours());
	var m = paddingZero(now.getMinutes());
	var s = paddingZero(now.getSeconds());
		
	return h+":"+m+":"+s; 
}

//현재시간 +1
function nowTimeAfterOne(){
	var now = new Date();
	var h = paddingZero(now.getHours()+1);
	var m = paddingZero(now.getMinutes());
	var s = paddingZero(now.getSeconds());
		
	return h+":"+m+":"+s; 
}

//왼쪽 0채우기
function paddingZero(value){
	var rtn = "";

	if(value < 10){
		rtn = "0"+value;
	}else{
		rtn = value;
	}

	return rtn;
}

function trendStime(){
	var now = new Date();
	now.setHours(now.getHours() - 8);
	
	var ye = now.getFullYear();
	var mo = paddingZero(now.getMonth()+1);
	var da = paddingZero(now.getDate());
	
	var ho = paddingZero(now.getHours());
	var mi = paddingZero(now.getMinutes());
		
	return ye+"-"+mo+"-"+da+" "+ho+":"+mi; 
}

function trendEtime(){
	var now = new Date();
	var ye = now.getFullYear();
	var mo = paddingZero(now.getMonth()+1);
	var da = paddingZero(now.getDate());
	
	var ho = paddingZero(now.getHours());
	var mi = paddingZero(now.getMinutes());
		
	return ye+"-"+mo+"-"+da+" "+ho+":"+mi; 
}

function rpImagePopup() {
    var img = document.createElement("img");
//    console.log(img);
    
    // $(img).attr("src", "imgs/noimage_01.gif");
    $(img).css("width", "600");
    $(img).css("height", "500");
    
    var div = document.createElement("div");
    $(div).css("position", "absolute");
    $(div).css("display", "none");
    $(div).css("z-index", "24999");
    $(div).append(img);
    $(div).hide();
    $("body").append(div);

    $(document).on("mouseover", ".rp-img-popup > img", function(){
            $(img).attr("src", $(this).attr("src"));
            $(div).show();
            var iHeight = (document.body.clientHeight / 2) - $(img).height() / 2 + document.body.scrollTop;   // 화면중앙
            var iWidth = (document.body.clientWidth / 2) - $(img).width() / 2 + document.body.scrollLeft;
            $(div).css("left", iWidth);
            $(div).css("top", 100);
        })
        .on("mouseout", ".rp-img-popup > img", function(){
            $(div).hide();
        });
    
    $(document).on("mouseover", ".rp-img-popup", function(){
        $(img).attr("src", $(this).attr("src"));
        $(div).show();
        var iHeight = (document.body.clientHeight / 2) - $(img).height() / 2 + document.body.scrollTop;   // 화면중앙
        var iWidth = (document.body.clientWidth / 2) - $(img).width() / 2 + document.body.scrollLeft;
        $(div).css("left", iWidth);
        $(div).css("top", 100);
    })
    .on("mouseout", ".rp-img-popup", function(){
        $(div).hide();
    });
}

function pageObject(paramKey){
//	console.log("받은 키값 : "+paramKey);
	var obj = {
			"a01":"",//기존 : 품목관리
			"a02":["/tkheat/product/ipgo","입고관리"],
			"a03":["/tkheat/product/chulgo","출고관리"],
			"a04":"",//기존 : 기타출고
			"a05":["/tkheat/product/pJaegoStatus","제품별재고현황"],
			"a06":["/tkheat/product/chulgoWaiting","출고대기현황"],
			"a07":["/tkheat/product/workStatus","공정작업현황"],
			"a08":["/tkheat/product/jaegoStatus","재고현황(상세정보)"],
			"a09":"",//기존 : 재고현황(개괄)
			"a10":["/tkheat/product/ipChulDelete","입출고삭제현황"],
			"b01":["/tkheat/production/workInstruction","작업지시"],
			"b02":["/tkheat/production/workStatus","작업현황"],
			"b03":"",
			"b04":["/tkheat/production/prodWaitingStatus","생산대기현황"],
			"b05":["/tkheat/production/lotIpgo","LOT추적관리(입고)"],
			"b06":["/tkheat/production/lotHeat","LOT추적관리(열처리LOT)"],
			"b07":"",
			"c01":["/tkheat/process/cleanSiljuk","전세정작업실적"],
			"c02":["/tkheat/process/chimSiljuk","침탄작업실적"],
			"c03":"",//기존 : 각로별작업실적
			"c04":["/tkheat/process/temSiljuk","템퍼링작업실적"],
			"c05":["/tkheat/process/cleanRwSiljuk","후세정작업실적"],
			"c06":["/tkheat/process/shortSiljuk","쇼트/샌딩작업실적"],
			"c07":"",
			"c08":["/tkheat/process/facSiljuk","설비별작업실적"],
			"c09":"",
			"c10":"",
			"c11":"",//기존 : 출고대기현황
			"c12":["/tkheat/process/readySiljuk","준비작업실적"],
			"d01":"",//기존 : 전체모니터링
			"d02":"",//기존 : 전체모니터링(설비)
			"d03":"",
			"e01":["/tkheat/preservation/sparePart","SparePart관리"],
			"e02":["/tkheat/preservation/begaInsert","설비비가동등록"],
			"e03":["/tkheat/preservation/begaAnaly","설비비가동율분석"],
			"e04":["/tkheat/preservation/suriHistory","설비수리이력관리"],
			"e05":["/tkheat/preservation/jeomgeomInsert","설비점검기준등록"],
			"e06":["/tkheat/preservation/dayJeomgeom","설비별점검현황(일별)"],
			"e07":["/tkheat/preservation/monthJeomgeom","설비별점검현황(월별)"],
			"e08":["/tkheat/preservation/gigiGojang","측정기기고장이력"],
			"e09":["/tkheat/preservation/gigiJeomgeom","측정기기점검관리"],
			"f01":["/tkheat/quality/suip","수입검사"],
			"f02":"",//기존 : 최종검사
			"f03":["/tkheat/quality/nonInsert","부적합등록"],
			"f04":["/tkheat/quality/xBar","Xbar-R관리도"],
			"f05":["/tkheat/quality/jajuStatus","자주검사불량현황"],//기존 : LOT추적
			"f06":"",
			"f07":"",//기존 : 세척청정도검사
			"f08":["/tkheat/quality/queHard","소입경도현황"],
			"f09":["/tkheat/quality/temHard","템퍼링경도현황"],
			"g01":["/tkheat/operation/pIpgoStatus","제품별입고현황"],
			"g02":["/tkheat/operation/pChulgoStatus","제품별출고현황"],
			"g03":["/tkheat/operation/prodSiljuk","제품별작업실적"],
			"g04":["/tkheat/operation/cuIpgoStatus","거래처별입고현황"],
			"g05":["/tkheat/operation/cuChulgoStatus","거래처별출고현황"],
			"g06":"",
			"g07":["/tkheat/operation/monthSale","월매출현황(마감)"],
			"g08":"",//기존 : 없음
			"g09":"",//기존 : 입고현황(종합)
			"g10":"",//기존 : 생산현황(종합)
			"g11":"",//기존 : 출고현황(종합)
			"g12":"",//기존 : 일일매출현황(영업)
			"g13":["/tkheat/operation/monthBul","월별불량현황"],//기존 : 월별매출및증량보고서
			"g14":["/tkheat/operation/yearSale","년간매출현황"],
			"g15":"",
			"g16":"",//기존 : 월매출현황(마감)_개괄
			"g17":"",//기존 : 출고현황(종합)_내방
			"g18":["/tkheat/operation/notice","공지사항"],
			"g19":["/tkheat/operation/cuMonthBul","월별거래처별불량현황"],
			"h01":["/tkheat/management/productInsert","제품등록"],
			"h02":["/tkheat/management/cutumInsert","거래처등록"],
			"h03":["/tkheat/management/facInsert","푸시알림"],
			"h04":["/tkheat/management/chimStandard","그룹관리"],
			"h05":["/tkheat/management/userinsert","작업자등록"],
			"h06":["/tkheat/management/pushAlarm","푸시알림 관리"],
			"h07":"",//기존 : 설비비가동코드등록
			"h08":["/tkheat/management/authority","사원별권한등록"],
			"h09":"",//기존 : 로그인기록
			"h10":"",//코일등록
			"h11":"",//plug등록
			"h12":"",//plug점검기준등록
			"h13":["/tkheat/management/measurement","측정기기관리"],
			"d04":["/tkheat/monitoring/alarm1","알람-1"],
			"d05":["/tkheat/monitoring/alarm2","알람-2"],
			"d06":["/tkheat/monitoring/trend","트렌드"],
			"d07":["/tkheat/monitoring/alarmHistory","알람내역"],
			"d08":["/tkheat/monitoring/alarmRanking","알람랭킹"]
	};

	
	return obj[paramKey];
}

	
	let userPermissions = {};
	
	function userInfoList(now_page_code) {
	    $.ajax({
	        url: '/ezPublic/user/info',
	        type: 'POST',
	        contentType: 'application/json',
	        dataType: 'json',
	        success: function(response) {
	            const loginUserPage = response.loginUserPage;
	            userPermissions = loginUserPage || {};
	            //controlButtonPermissions(now_page_code);
	        },
	        error: function(xhr, status, error) {
	            console.error("데이터 가져오기 실패:", error);
	        }
	    });
	}




/* 	function controlButtonPermissions(now_page_code) {
	    const permission = userPermissions?.[now_page_code];
	  //  console.log("현재 페이지 권한(permission):", permission);
	
	    const canRead = permission === "R" || permission === "C" || permission === "D";
	    const canCreate = permission === "C" || permission === "D";
	    const canDelete = permission === "D";
	
	    if (!canRead) {
	        $(".select-button").css("pointer-events", "none").css("background-color", "#ced4da");
	    }
	
	    if (!canCreate) {
	        $(".insert-button").css("pointer-events", "none").css("background-color", "#ced4da");
	        $("#corrForm").prop("disabled", true);
	    }
	
	    if (!canDelete) {
	        $(".delete").css("pointer-events", "none").css("background-color", "#ced4da");
	    }
	
	    $(".select-button").on("click", function (e) {
	        if (!canRead) {
	            alert("당신의 권한이 없습니다. (조회)");
	            e.preventDefault();
	            e.stopImmediatePropagation();
	        }
	    });
	
	    $(".insert-button").on("click", function (e) {
	        if (!canCreate) {
	            alert("당신의 권한이 없습니다. (추가)");
	            e.preventDefault();
	            e.stopImmediatePropagation();
	        }
	    });
	
	    $(".delete").on("click", function (e) {
	        if (!canDelete) {
	            alert("당신의 권한이 없습니다. (삭제)");
	            e.preventDefault();
	            e.stopImmediatePropagation();
	        }
	    });
	} */




	$(document).ready(function() {
	    userInfoList(now_page_code);
	    console.log("나우페이지코드",now_page_code)
	});







</script>
