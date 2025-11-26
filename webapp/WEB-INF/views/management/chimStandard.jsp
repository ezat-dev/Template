<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>그룹관리</title>
    <%-- <%@ include file="../include/sideBar.jsp" %> --%>
    <link rel="stylesheet" href="/ezPublic/css/tabBar/tabBar.css">
    <%@include file="../include/pluginpage.jsp" %>
    <link rel="stylesheet" href="/ezPublic/css/management/userinsert2.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/locales-all.min.js'></script>
    <style>
    
        .container {
            display: flex;
            justify-content: space-between;
            padding: 20px;
            margin-left: 1008px;
            margin-top: 200px;
        }
        .view {
            display: flex;
            justify-content: center;
            margin-top: 1%;
        }
        .groupScheduleView {
            display: flex;
            justify-content: center;
            margin-top: 1%;
        }
        .tab {
            width: 95%;
            margin-bottom: 37px;
            margin-top: 5px;
            height: 45px;
            border-radius: 6px 6px 0px 0px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .modal {
            display: none;
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            transition: opacity 0.3s ease-in-out;
        }
	    .modal-content{
	        background: white;
		    width: 70%;
		    max-width: 1065px;
	        height: 80vh; 
	        overflow-y: auto; 
	        margin: 6% auto 0;
	        padding: 20px;
	        border-radius: 10px;
	        position: relative;
	        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
	        transform: scale(0.8);
	        transition: transform 0.3s ease-in-out, opacity 0.3s ease-in-out;
	        opacity: 0;
	    }
        .modal.show {
            display: block;
            opacity: 1;
        }
        .modal.show .modal-content{
            transform: scale(1);
            opacity: 1;
        }
        .close {
            background-color:white;
            position: absolute;
            right: 15px;
            top: 10px;
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
        }
        .modal-content form, .alarm-modal-content form, .recieve-alarm-modal-content form, .update-group-modal-content form{
            display: flex;
            flex-direction: column;
        }
        .modal-content label, .alarm-modal-content label, .recieve-alarm-modal-content label, .update-group-modal-content label{
            font-weight: bold;
            margin: 10px 0 5px;
        }
        .modal-content input, .modal-content textarea, 
        .alarm-modal-content input, .alarm-modal-content textarea,
        .recieve-alarm-modal-content input, .recieve-alarm-modal-content textarea
        .update-group-modal-content input, .update-group-modal-content textarea{
            width: 97%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        select {
            width: 14%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .modal-content button, 
        .alarm-modal-content button,
        .recieve-alarm-modal-content button,
        .update-group-modal-content button{
            background-color: #d3d3d3;
            color: black;
            padding: 10px;
            border: none;
            border-radius: 5px;
            margin-top: 10px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .modal-content button:hover, 
        .alarm-modal-content button:hover,
        .recieve-alarm-modal-content  button:hover,
        .update-group-modal-content button: hover{
            background-color: #a9a9a9;
        }
        .button-container {
    		display: flex;
		    gap: 10px;
		    margin-left: auto;
		    margin-right: 10px;
		    margin-top: 40px;
		}
		.box1 {
		    display: flex;
		    justify-content: right;
		    align-items: center;
		    width: 1000px;
		    margin-right: 0px;
		    margin-top: 4px;
		    margin-left: -16%;
		}
        .dayselect {
            width: 20%;
            text-align: center;
            font-size: 15px;
        }
        .daySet {
        	width: 20%;
      		text-align: center;
            height: 16px;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 15px;
        }
        .daylabel {
            margin-right: 10px;
            margin-bottom: 13px;
            font-size: 18px;
            margin-left: 20px;
        }
        button-container.button{
        height: 16px;
        }
         .mid{
        margin-right: 9px;
	    font-size: 20px;
	    font-weight: bold;
	
	    height: 42px;
	    margin-left: 9px;
        }
        .row_select {
	    background-color: #ffeeba !important;
	    }
	    
	    .form-row {
  display: flex;
  align-items: center;
  gap: 16px;           /* 레이블–인풋 간격 */
  flex-wrap: wrap;     /* 화면 좁아지면 줄 바꿈 */
  margin-bottom: 12px; /* 각 행 간 간격 */
}
	.delete-button {
	    height: 40px; /* tab보다 조금 작게 설정 */
	    padding: 0 11px; /* 좌우 패딩 */
	    border: 1px solid rgb(53, 53, 53);
	    border-radius: 4px; /* 모서리 둥글게 */
	    background-color: #ffffff; /* 배경색 */
	    cursor: pointer; /* 포인터 커서 */
	    display: flex; /* 내부 요소를 플렉스 박스로 설정 */
	    align-items: center; /* 버튼 안에서 세로 가운데 정렬 */
	}
.group-time-button {
    background-color: white;
    border: 1px solid black;
    border-radius: 4px;
    height: 40px;
    padding: 0px 15px;
    font-size: 14px;
    color: #333;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    box-shadow: none;
    transition: background-color 0.2s;
    width: 158px;
}
.alarm-group-button{
    background-color: white;
    border: 1px solid black;
    border-radius: 4px;
    height: 40px;
    padding: 0px 15px;
    font-size: 14px;
    color: #333;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    box-shadow: none;
    transition: background-color 0.2s;
    width: 158px;
}
.update-group-name-button{
    background-color: white;
    border: 1px solid black;
    border-radius: 4px;
    height: 40px;
    padding: 0px 15px;
    font-size: 14px;
    color: #333;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    box-shadow: none;
    transition: background-color 0.2s;
    width: 158px;
}
.recieve-alarm-button{
    background-color: white;
    border: 1px solid black;
    border-radius: 4px;
    height: 40px;
    padding: 0px 15px;
    font-size: 14px;
    color: #333;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    box-shadow: none;
    transition: background-color 0.2s;
    width: 188px;
}
/* 모달 전체 배경 */
.modal {
  display: none; /* 초기에는 숨김 */
  position: fixed;
  z-index: 999;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
  overflow: auto;
  font-family: 'Arial', sans-serif;
}

/* 모달 내용 영역 */
.time-modal {
  background-color: #fff;
  margin: 8% auto;
  padding: 20px 30px;
  border-radius: 12px;
  width: 60%;
  max-width: 623px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.3);
  position: relative;
}

/* 모달 닫기 버튼 */
.close {
  position: absolute;
  top: 12px;
  right: 18px;
  font-size: 28px;
  font-weight: bold;
  color: #333;
  cursor: pointer;
  transition: color 0.2s;
}

.close:hover {
  color: #e74c3c;
}

/* 모달 제목 */
.time-modal h2 {
  text-align: center;
  margin-bottom: 20px;
  font-size: 20px;
  color: #333;
}

/* 테이블 기본 스타일 */
.time-modal table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 20px;
}

.time-modal th, .time-modal td {
  border: 1px solid #ddd;
  padding: 10px;
  text-align: center;
  font-size: 14px;
}

.time-modal th {
  background-color: #f2f2f2;
  font-weight: bold;
}

/* 입력 필드 */
.time-modal input[type="datetime-local"] {
  width: 90%;
  padding: 6px 8px;
  border: 1px solid #ccc;
  border-radius: 6px;
  font-size: 13px;
}

/* 모달 하단 버튼 */
.modal-footer {
  text-align: right;
}

.modal-footer button {
  padding: 8px 16px;
  margin-left: 10px;
  border: none;
  border-radius: 6px;
  font-size: 14px;
  cursor: pointer;
  transition: background 0.2s;
}

.modal-footer button[type="submit"] {
  background-color: #3498db;
  color: #fff;
}

.modal-footer button[type="submit"]:hover {
  background-color: #2980b9;
}

.modal-footer button#cancelBtn {
  background-color: #ccc;
}

.modal-footer button#cancelBtn:hover {
  background-color: #999;
}
	   .alarm-modal-content{
	        background: white;
			width: 100%;
			max-width: 1545px;
	        height: 80vh; 
	        overflow-y: auto; 
	        margin: 6% auto 0;
	        padding: 20px;
	        border-radius: 10px;
	        position: relative;
	        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
	        transform: scale(0.8);
	        transition: transform 0.3s ease-in-out, opacity 0.3s ease-in-out;
	        opacity: 0;
	    }
	    	.recieve-alarm-modal-content{
	        background: white;
			width: 100%;
			max-width: 1350px;
	        height: 80vh; 
	        overflow-y: auto; 
	        margin: 6% auto 0;
	        padding: 20px;
	        border-radius: 10px;
	        position: relative;
	        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
	        transform: scale(0.8);
	        transition: transform 0.3s ease-in-out, opacity 0.3s ease-in-out;
	        opacity: 0;
	    }
	    	.update-group-modal-content{
	        background: white;
			width: 100%;
			max-width: 345px;
	        height: 90vh; 
	        overflow-y: auto; 
	        margin: 1% auto 0;
	        padding: 20px;
	        border-radius: 10px;
	        position: relative;
	        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
	        transform: scale(0.8);
	        transition: transform 0.3s ease-in-out, opacity 0.3s ease-in-out;
	        opacity: 0;
	    }
        .alarm-modal-content{
            transform: scale(1);
            opacity: 1;
        }
         .recieve-alarm-modal-content{
            transform: scale(1);
            opacity: 1;
        }
         .update-group-modal-content{
            transform: scale(1);
            opacity: 1;
        }
        #groupScheduleDataTable{
        width: 600px;
        }
#deleteBtn {
  background-color: #e74c3c; 
  color: #fff;
}
#deleteBtn:hover {
  background-color: #c0392b; 
}   
    </style>
</head>

<body>

    <main class="main">
        <div class="tab">
        

            <div class="button-container">
            
               <div class="box1">
	           <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
	           <label class="daylabel">그룹별 조회 :</label>
				<select id="groupSelect" name="group_filter">
				    <option value="">-- 전체 그룹 --</option> 
				    <option value="1">그룹 A</option>
				    <option value="2">그룹 B</option>
				    <option value="3">그룹 C</option>
				    <option value="4">그룹 D</option>
				    <option value="5">그룹 E</option>
				</select>
				
				<!-- <span class="mid"  style="font-size: 20px; font-weight: bold; margin-botomm:10px;"> ~ </span> -->
	
			<!-- 	<input type="text"autocomplete="off" class="daySet" id="endDate" style="font-size: 16px; margin-bottom:10px;" placeholder="종료 날짜 선택"> 
 -->
	
<!-- 			  <label class="daylabel">성명 :</label>
			 <input type="text" id="user_name" style="font-size:16px; height:30px; width:220px; margin-bottom:10px; text-align:center; border-radius:6px; border:1px solid #ccc;" placeholder="이름 입력"> -->



	</div>

	           
		<!-- 
                <button class="select-button">
                    <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">조회
                </button>
              -->
                <button class="insert-button" style="width: 156px;">
                    <img src="/ezPublic/css/image/insert-icon.png" alt="insert" class="button-image">알람 발송 그룹 관리
                </button>
                <button class="group-time-button">
                    <img src="/ezPublic/css/image/insert-icon.png" alt="insert" class="button-image">알람 발송 스케줄
                </button>
                <button class="recieve-alarm-button">
                    <img src="/ezPublic/css/image/insert-icon.png" alt="insert" class="button-image">그룹별 수신 알람 설정
                </button>
                <button class="alarm-group-button">
                    <img src="/ezPublic/css/image/insert-icon.png" alt="insert" class="button-image">발송 알람 선택
                </button>
                
                 <button class="update-group-name-button">
                    <img src="/ezPublic/css/image/insert-icon.png" alt="insert" class="button-image">그룹 이름 변경
                </button>
                <!-- 
                <button class="delete-button">
				    <img src="/tkheat/css/tabBar/xDel3.png" alt="delete" class="button-image"> 삭제
				</button>
                <button class="excel-button">
                    <img src="/tkheat/css/tabBar/excel-icon.png" alt="excel" class="button-image">엑셀
                </button>
                 -->
                
            </div>
        </div>
<div id="groupTimeModal" class="modal">
  <div class="time-modal">
    <h2>알람 발송 스케줄</h2>

    <form id="groupTimeForm">
    <input type="text" name="schedule_id" style="display:none;">
      <table>
        <thead>
          <tr>
            <th>그룹</th>
                <th>시작 날짜</th>
                <th>종료 날짜</th>
                <th>시작 시간</th>
                <th>종료 시간</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>
              <select id="selectGroupSchedule" name="group_id" required style="width: 100px;">
                <option value="">--그룹 선택--</option>
                <option value="1">그룹 A</option>
                <option value="2">그룹 B</option>
                <option value="3">그룹 C</option>
                <option value="4">그룹 D</option>
                <option value="5">그룹 E</option>
              </select>
            </td>
                <td><input type="date" name="start_date" required></td>
                <td><input type="date" name="end_date" required></td>
                <td><input type="time" name="start_time" required></td>
                <td><input type="time" name="end_time" required></td>
          </tr>
        </tbody>
      </table>

      <div class="modal-footer">
        <button type="submit" id="saveTimeBtn">저장</button>
        <button type="submit" id="updateBtn" style="display:none">수정</button>
        <button type="submit" id="deleteBtn" style="display:none">삭제</button>
        <button type="button" id="cancelBtn">취소</button>
      </div>
    </form>
  </div>
</div>
        <div class="view">
            <div id="dataTable"></div>
            
            <div id="groupScheduleDataTable" style="margin-left:75px"></div>
        </div>
         <div class="groupScheduleView">
        </div>
    </main>
	
	   <div id="modalContainer" class="modal">
	    <div class="modal-content">
	<!--         <span class="close">&times;</span> -->
	        <h2>알람 발송 그룹 관리</h2>
            <div id="modalDataTable" style="margin-bottom: 20px;"></div> 
	        <form id="corrForm"autocomplete="off">

	            <!-- <button type="submit" id="saveCorrStatus">저장</button> -->
	            <!-- <button type="submit" id="updateCorrStatus" style="display: none;">수정</button>-->
	            <button type="button" id="closeModal">닫기</button>
	        </form>
	    </div>
	</div>
	
		   <div id="alarmGroupModal" class="modal">
	    <div class="alarm-modal-content">
	<!--         <span class="close">&times;</span> -->
	        <h2>발송 알람 선택</h2>
            <div id="alarmGroupTable" style="margin-bottom: 20px;"></div> 
	        <form id="corrForm"autocomplete="off">

	            <!-- <button type="submit" id="saveCorrStatus">저장</button> -->
	            <!-- <button type="submit" id="updateCorrStatus" style="display: none;">수정</button>-->
	            <button type="button" id="closeModal">닫기</button>
	        </form>
	    </div>
	</div>
	
			   <div id="recieveAlarmModal" class="modal">
	    <div class="recieve-alarm-modal-content">
	<!--         <span class="close">&times;</span> -->
	        <h2>그룹별 수신 알람 설정</h2>
            <div id="recieveAlarmTable" style="margin-bottom: 20px;"></div> 
	        <form id="corrForm"autocomplete="off">

	            <!-- <button type="submit" id="saveCorrStatus">저장</button> -->
	            <!-- <button type="submit" id="updateCorrStatus" style="display: none;">수정</button>-->
	            <button type="button" id="closeModal">닫기</button>
	        </form>
	    </div>
	</div>
	
	<!-- 그룹 이름 변경 -->
	   <div id="updateGroupModel" class="modal">
	    <div class="update-group-modal-content">
	<!--         <span class="close">&times;</span> -->
	        <h2>그룹 이름 변경</h2>
	        <form id="corrForm"autocomplete="off">
	        <h4>회원 그룹</h4>
	          <div id="updateGroupNameTable"></div>
	          <h4>알람 그룹</h4>
	          <div id="updateAlarmGroupNameTable"></div>
<!-- 		 	<input type="text" name="user_code" style="display:none;">
 
				<h4>회원 그룹</h4>
	            <label>첫 번째 그룹</label>
				<input type="text" name="user_id">
	
	           <label>두 번째 그룹</label>
	           <input type="text" name="user_pw">
	           
	           <label>세 번째 그룹</label>
	           <input type="text" name="user_pw">
	           
	           <label>네 번째 그룹</label>
	           <input type="text" name="user_pw">
	           
	           <label>다섯 번째 그룹</label>
	           <input type="text" name="user_pw">

	             <input type="text" name="user_jick"> -->
	            
	           <!--  <button type="submit" id="saveGroupNameCorrStatus">저장</button> -->
	            <button type="button" id="closeModal">닫기</button>
	        </form>
	    </div>
	</div>

<script>
let now_page_code = "h03";
var dataTable;
var selectedRowData = null;
var modalDataTable; // ⚠️ 모달용 Tabulator 변수 추가
var alarmGroupTable;
var groupScheduleDataTable;
var calendar;
var calendarEl;
var recieveAlarmTable;
let currentScheduleId = null;
let groupNames = [];
let alarmGroupNames = [];

$(function() {
	loadGroupNames();
	loadAlarmGroupNames();
	
	function loadGroupNames() {
	//사람 그룹 이름 가져오기
	$.ajax({
        url: "/ezPublic/user/getGroupName", 
        type: "POST", 
        dataType: "json",
        success: function(groups) {
            groupNames = groups.map(item => ({
                group_id: item.group_id, 
                group_name: item.group_name
            }));
            console.log("저장된 사람 그룹 배열:", groupNames);

            //그룹별 조회 부분
			const $groupSelect = $('#groupSelect');
            $groupSelect.empty();
            $groupSelect.append('<option value="">-- 전체 그룹 --</option>');

            groupNames.forEach(groupNames => {
                const newOption = '<option value="' + groupNames.group_id + '">' + groupNames.group_name + '</option>';
                $groupSelect.append(newOption);
            });

            //알람 발송 스케줄 부분
            const $groupScheduleSelect = $('#selectGroupSchedule');
            $groupScheduleSelect.empty();
            $groupScheduleSelect.append('<option value="">-- 그룹 선택 --</option>');

            groupNames.forEach(groupNames => {
                const newOption = '<option value="' + groupNames.group_id + '">' + groupNames.group_name + '</option>';
                $groupScheduleSelect.append(newOption);
            });
        },
        error: function(xhr, status, error) {
            console.error("회원 그룹 목록을 불러오는 데 실패했습니다:", error);
            alert("회원 그룹 데이터 로드에 실패했습니다. 관리자에게 문의하세요.");
        }
    });
}
	//알람 그룹 이름 가져오기
	function loadAlarmGroupNames(){
	$.ajax({
        url: "/ezPublic/alarm/getAlarmGroupName", 
        type: "POST", 
        dataType: "json",
        success: function(groups) {
        	alarmGroupNames = groups.map(item => ({
        		alarm_group_id: item.alarm_group_id, 
        		alarm_group_name: item.alarm_group_name
            }));
            console.log("저장된 알람 그룹 배열:", alarmGroupNames);
        },
        error: function(xhr, status, error) {
            console.error("알람 그룹 목록을 불러오는 데 실패했습니다:", error);
            alert("알람 그룹 데이터 로드에 실패했습니다. 관리자에게 문의하세요.");
        }
    });
	}
    
    //그룹 이름 변경 테이블
  updateGroupNameTable = new Tabulator('#updateGroupNameTable', {
    height: "180px",
    layout: "fitColumns",
    headerHozAlign: "center",
    ajaxConfig: { method: 'POST' },
    ajaxLoader: false,
    ajaxURL: "/ezPublic/user/getGroupName",
    ajaxParams: {},
    placeholder: "조회된 데이터가 없습니다.",
    ajaxResponse: function(url, params, response) {
     console.log("서버 응답 데이터 확인:", response);
      return response;
    },
    columns: [
        { title: "group_id", field: "group_id", sorter: "string", width: 240, hozAlign: "center", visible:false},
      { title: "NO", formatter: "rownum", hozAlign: "center", width: 100, headerSort: false },
      { title: "회원 그룹 이름", field: "group_name", width: 230, hozAlign: "center",editor: "input", headerSort: false},
    ],
    cellEdited: function(cell) {
        if (cell.getField() === "group_name") {
            const rowData = cell.getRow().getData();
            const groupId = rowData.group_id;
            const newGroupName = rowData.group_name;
            
            // 3. 업데이트 요청을 위한 AJAX 호출
            $.ajax({
                url: '/ezPublic/user/updateGroupName', // 💡 그룹 이름을 업데이트할 서버 API 엔드포인트
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    group_id: groupId,
                    group_name: newGroupName
                }),
                success: function(response) {
                    // 서버 응답에 따라 성공 메시지 표시
                    if (response == true) { // 서버 응답 구조에 따라 변경 필요
                        console.log("그룹 이름 업데이트 완료");
                        loadGroupNames();
                    	calendar.refetchEvents();
                    } else {
                        alert("그룹 이름 업데이트 실패: " + (response.message || "알 수 없는 오류"));
                        // 실패 시 값을 롤백해야 할 수도 있습니다 (선택 사항).
                        // cell.restoreOldValue(); 
                    }
                },
                error: function(xhr, status, error) {
                    alert('서버 통신 오류가 발생했습니다: ' + error);
                    // cell.restoreOldValue(); // 실패 시 값 롤백
                }
            });
        }
    },
    rowClick: function(e, row) {
    }
  });
  updateAlarmGroupNameTable = new Tabulator('#updateAlarmGroupNameTable', {
	    height: "295px",
	    layout: "fitColumns",
	    headerHozAlign: "center",
	    ajaxConfig: { method: 'POST' },
	    ajaxLoader: false,
	    ajaxURL: "/ezPublic/alarm/getAlarmGroupName",
	    ajaxParams: {},
	    placeholder: "조회된 데이터가 없습니다.",
	    ajaxResponse: function(url, params, response) {
	     console.log("서버 응답 데이터 확인:", response);
	      return response;
	    },
	    columns: [
	    	 { title: "alarm_group_id", field: "alarm_group_id", sorter: "string", width: 240, hozAlign: "center", visible:false},
	      { title: "NO", formatter: "rownum", hozAlign: "center", width: 100, headerSort: false },
	      { title: "알람 그룹 이름", field: "alarm_group_name", width: 230, hozAlign: "center", editor: "input",headerSort: false}
	    ],cellEdited: function(cell) {
	        if (cell.getField() === "alarm_group_name") {
	            const rowData = cell.getRow().getData();
	            const alarm_group_id = rowData.alarm_group_id;
	            const alarm_group_name = rowData.alarm_group_name;
	            
	            // 3. 업데이트 요청을 위한 AJAX 호출
	            $.ajax({
	                url: '/ezPublic/alarm/updateAlarmGroupName', // 💡 그룹 이름을 업데이트할 서버 API 엔드포인트
	                type: 'POST',
	                contentType: 'application/json',
	                data: JSON.stringify({
	                	alarm_group_id: alarm_group_id,
	                	alarm_group_name: alarm_group_name
	                }),
	                success: function(response) {
	                    // 서버 응답에 따라 성공 메시지 표시
	                    if (response == true) { // 서버 응답 구조에 따라 변경 필요
	                        console.log("알람 그룹 이름 업데이트 완료");
	                        loadAlarmGroupNames();
	                    	calendar.refetchEvents();
	                    } else {
	                        alert("그룹 이름 업데이트 실패: " + (response.message || "알 수 없는 오류"));
	                        // 실패 시 값을 롤백해야 할 수도 있습니다 (선택 사항).
	                        // cell.restoreOldValue(); 
	                    }
	                },
	                error: function(xhr, status, error) {
	                    alert('서버 통신 오류가 발생했습니다: ' + error);
	                    // cell.restoreOldValue(); // 실패 시 값 롤백
	                }
	            });
	        }
	    },
	    rowClick: function(e, row) {
	    }
	  });
  
  // Initialize the dataTable
  dataTable = new Tabulator('#dataTable', {
    height: "705px",
    layout: "fitColumns",
    headerHozAlign: "center",
    ajaxConfig: { method: 'POST' },
    ajaxLoader: false,
    ajaxURL: "/ezPublic/user/selectList",
    ajaxParams: {},
    placeholder: "조회된 데이터가 없습니다.",
    ajaxResponse: function(url, params, response) {
     console.log("서버 응답 데이터 확인:", response);
      return response;
    },
    columns: [
      { title: "NO", formatter: "rownum", hozAlign: "center", width: 120 },
      { title: "user_code", field: "user_code", sorter: "string", width: 240, hozAlign: "center", visible:false},
      { title: "user_pw", field: "user_pw", sorter: "string", width: 320, hozAlign: "center", visible: false },

      { title: "아이디", field: "user_id", sorter: "string", width: 180, hozAlign: "center" },
      { title: "비밀번호", field: "user_pw", sorter: "string", width: 240, hozAlign: "center", visible: false },
      { title: "성명", field: "user_name", sorter: "string", width: 200, hozAlign: "center" },
      { title: "소속 그룹", field: "user_groups", width: 140, hozAlign: "center" }
    ],
    rowClick: function(e, row) {
      $('#dataTable .tabulator-row').removeClass('row_select');
      row.getElement().classList.add('row_select');
      selectedRowData = row.getData();

      // 선택된 행 정보를 오른쪽 영역에 표시
      $('#display_user_name').text('성명: ' + selectedRowData.user_name);
      $('#display_user_phone').text('전화번호: ' + selectedRowData.user_phone);


      // 2. 1호기 알람 상태에 따라 HTML 변경 (기존 코드 수정)
      const alarm1_yn = selectedRowData.message_yn;
      console.log("alarm1_yn: ", alarm1_yn);
      const alarm1_html = createAlarmCheckboxHtml('1라인 알람', alarm1_yn);
      // display_message_yn이 이미 P 태그이므로 내부를 변경합니다.
      $('#display_message_yn').html(alarm1_html); 

      // 3. 2호기 알람 상태에 따라 HTML 변경 (기존 코드 수정)
      const alarm2_yn = selectedRowData.message_yn2; 
      console.log("alarm2_yn: ", alarm2_yn);
      const alarm2_html = createAlarmCheckboxHtml('2라인 알람', alarm2_yn);
      // display_message_yn2가 이미 P 태그이므로 내부를 변경합니다.
      $('#display_message_yn2').html(alarm2_html); 
    }/* ,
    rowDblClick: function(e, row) {
      var d = row.getData();
      selectedRowData = d;
      $('#corrForm')[0].reset();
      $('input[name="no"]').val(d.idx);
      $('input[name="user_id"]').val(d.user_id);
      $('input[name="user_pw"]').val(d.user_pw);
      $('input[name="st_day"]').val(d.st_day);
      $('input[name="user_phone"]').val(d.user_phone);
      $('input[name="user_name"]').val(d.user_name);
      $('select[name="user_level"]').val(d.user_level);
      $('input[name="user_busu"]').val(d.user_busu);
      $('input[name="user_jick"]').val(d.user_jick);

      // 저장 숨기고 수정 보이게
      $('#saveCorrStatus').hide();
      $('#updateCorrStatus').show();
      
      $('#modalContainer').show().addClass('show');
    } */
  });
//그룹 이름 가져오기(캘린더에 넣을거)
function getGroupName(groupId) {
    const index = groupId - 1; // 💡 핵심: ID 1 -> 인덱스 0, ID 5 -> 인덱스 4
    
    // 배열이 존재하고, 유효한 인덱스 범위(0 ~ 4) 내에 있는지 확인
    if (groupNames && index >= 0 && index < groupNames.length) {
        // 그룹 이름 반환
        return groupNames[index].group_name; 
    }
    
    // 유효하지 않은 ID이거나 데이터가 없을 경우
    return '알 수 없는 그룹';
}
      calendarEl = document.getElementById('groupScheduleDataTable'); // ID 재사용

      calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: 'dayGridMonth', // 기본 월별 뷰
      locale: 'ko', // 한국어 설정
      height: "600px", 
      headerToolbar: { 
          left: 'prev,next today',
          center: 'title',
          right: ''
      },
      //클릭시
      eventClick: function(info) {
          handleEventClick(info); 
      },
      displayEventTime: false,
      eventTimeFormat: {
          hour: '2-digit', // 시 (예: 10)
          minute: '2-digit', // 분 (예: 15)
          meridiem: false, // 🌟 오전/오후(AM/PM) 표시를 완전히 제거합니다.
          hour12: false     // 🌟 12시간제 대신 24시간제를 사용하도록 강제합니다.
      },
      
      // 🚨 DB 데이터 연동 핵심: 서버 API에서 JSON 이벤트 데이터를 가져옵니다.
      events: {
          // Tabulator에서 사용했던 URL을 재사용하되, 반환 형식이 FullCalendar JSON 형식이어야 합니다.
          url: "/ezPublic/user/getGroupScheduleList", 
          method: 'POST', // POST 방식으로 요청
          // 데이터를 FullCalendar 형식으로 변환하는 함수
          eventDataTransform: function(rawEventData) {
              // 백엔드에서 받은 schedule 데이터를 FullCalendar 이벤트 형식으로 변환합니다.
            const groupName = getGroupName(rawEventData.group_id);
            
            // 2. 변환된 그룹명을 사용하여 title 구성
            const eventTitle = '그룹 ' + groupName + ' (' + rawEventData.start_time + '~' + rawEventData.end_time + ')';
            const eventColor = getGroupColor(rawEventData.group_id);
              return {
            	  extendedProps: {
            		  raw_group_id: rawEventData.group_id,
                      raw_start_date: rawEventData.start_date,
                      raw_end_date: rawEventData.end_date,
                      raw_start_time: rawEventData.start_time,
                      raw_end_time: rawEventData.end_time
                  },
                  id: rawEventData.schedule_id,
                  groupId: rawEventData.group_id,
                  title: eventTitle,
                  start: rawEventData.start_date + 'T' + rawEventData.start_time, // 'YYYY-MM-DDT10:15:00' 형식
                  end: rawEventData.end_date + 'T' + rawEventData.end_time, // 'YYYY-MM-DDT22:15:00' 형식
                  allDay: false, // 시간 정보가 있으므로 allDay는 false
                  backgroundColor: eventColor 
              };
          },
          failure: function() {
              console.error('일정 데이터를 불러오는 데 실패했습니다.');
          }
      }
      // ... 필요한 다른 옵션 (eventClick 등)
  });

  calendar.render();

  //캘린더 클릭 시 호출 함수
  function handleEventClick(info) {
    const event = info.event;
    const props = event.extendedProps;
    
    const schedule_id = event.id;
    const start_date = props.raw_start_date; 
    const end_date = props.raw_end_date;
    const start_time = props.raw_start_time;
    const end_time = props.raw_end_time;
    const group_id = props.raw_group_id;
    console.log("start_time:",start_time + ", end_time:",end_time +
    	    ", start_date:",start_date + ", end_date:",end_date+ ", schedule_id:",schedule_id);

    currentScheduleId = schedule_id;

 // 3. 모달 폼 필드에 값 채우기 (HTML 폼의 name 속성 사용)
    const $form = $('#groupTimeForm');
    
    // group_id 설정
    $form.find('select[name="group_id"]').val(group_id);
    
    // 날짜/시간 설정
    $form.find('input[name="schedule_id"]').val(schedule_id);
    $form.find('input[name="start_date"]').val(start_date);
    $form.find('input[name="end_date"]').val(end_date);
    $form.find('input[name="start_time"]').val(start_time);
    $form.find('input[name="end_time"]').val(end_time);
    
    $('#deleteBtn').show(); // 삭제 버튼 표시
    $('#updateBtn').show();
    $('#saveTimeBtn').hide();
    
    // 5. 모달 열기
    $('#groupTimeModal').show();
}
  
//그룹 ID를 그룹명(A, B, C...)으로 변환하는 함수
  function getGroupName(groupId) {
      // 1: A, 2: B, ..., 5: E
      const groupNamess = {
    	[groupNames[0].group_id]: groupNames[0].group_name, 
    	[groupNames[1].group_id]: groupNames[1].group_name, 
    	[groupNames[2].group_id]: groupNames[2].group_name, 
    	[groupNames[3].group_id]: groupNames[3].group_name, 
    	[groupNames[4].group_id]: groupNames[4].group_name
      };
      return groupNamess[groupId] || String(groupId); 
  }
//그룹 ID에 따라 색상을 반환하는 함수 (새로 추가)
  function getGroupColor(groupId) {
      // 🎨 그룹별 색상 정의
      const groupColors = {
    	[groupNames[0].group_id]: '#4CAF50', // 그룹 A: 그린 계열
    	[groupNames[1].group_id]: '#2196F3', // 그룹 B: 블루 계열
    	[groupNames[2].group_id]: '#FF9800', // 그룹 C: 오렌지 계열
    	[groupNames[3].group_id]: '#673AB7', // 그룹 D: 퍼플 계열
    	[groupNames[4].group_id]: '#E53935', // 그룹 E: 레드 계열
          // 기본값: 6번 이상의 그룹 ID를 위한 기본 색상
          default: '#607D8B' 
      };
      // 해당 ID의 색상이 있으면 반환하고, 없으면 default 색상을 반환
      return groupColors[groupId] || groupColors.default; 
  }
  // 조회 버튼 클릭 시
  $('.select-button').click(function() {
    var user_name = $('#user_name').val();
    var startDate = $('#startDate').val();
/*     console.log("조회 버튼 클릭됨 - 전송 데이터:", {
      user_name: user_name,
      startDate: startDate
    }); */
   // console.log("전송된 startDate 값:", startDate);
    dataTable.setData("/ezPublic/user/selectList", {});

  });

  function initModalDataTable() {
	    if (modalDataTable) {
	        modalDataTable.destroy();
	    }
	    //오늘 날짜
	    const todayDate = getTodayDate();  
	    
	    modalDataTable = new Tabulator('#modalDataTable', {
	        height: "450px", // 테이블 높이 설정 (모달 크기에 맞게)
	        layout: "fitColumns",
	        headerHozAlign: "center",
            sortable: false,
	        ajaxConfig: { method: 'POST' },
	        ajaxLoader: false,
	        ajaxURL: "/ezPublic/user/selectList", // 적절한 데이터 로드 URL 사용
	        ajaxParams: {work_day: todayDate },
	        success:function(groups){
		        console.log("groups: ", groups);
				groupNames = groups;
		        },
	        placeholder: "조회된 데이터가 없습니다.",
	        columns: [
	        	{ title: "user_code", field: "user_code", visible: false},
	        	{ title: "no", field: "no", visible: false},
	            { title: "ID", field: "user_id", hozAlign: "center", width: 110 },
	            { title: "성명", field: "user_name", hozAlign: "center", width: 120 },
	            { title: "부서", field: "user_busu", hozAlign: "center", width: 120 },
	            { 
	            	title: groupNames[0].group_name,  
	                field: "user_groups", 
	                headerSort: false,
	                width: 140, 
	                hozAlign: "center",
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const groupString = cell.getValue();
	                    console.log("groupString: ", groupString);
	                    let isChecked = false;
	                    
	                    // 1. groupString이 유효하고, 'A 그룹'을 포함하는지 확인
	                    if (groupString && groupString.includes(groupNames[0].group_name)) {
	                         isChecked = true;
	                    }
	                    console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                cellClick: handleGroupClick
	            },
	            { 
	                title: groupNames[1].group_name, 
	                field: "user_groups", 
	                headerSort: false,
	                width: 140, 
	                hozAlign: "center",
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const groupString = cell.getValue();
	                    console.log("groupString: ", groupString);
	                    let isChecked = false;
	                    
	                    // 1. groupString이 유효하고, 'A 그룹'을 포함하는지 확인
	                    if (groupString && groupString.includes(groupNames[1].group_name)) {
	                         isChecked = true;
	                    }
	                    console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                cellClick: handleGroupClick
	            },
	            { 
	                title: groupNames[2].group_name, 
	                field: "user_groups", 
	                headerSort: false,
	                width: 140, 
	                hozAlign: "center",
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const groupString = cell.getValue();
	                    console.log("groupString: ", groupString);
	                    let isChecked = false;
	                    
	                    // 1. groupString이 유효하고, 'A 그룹'을 포함하는지 확인
	                    if (groupString && groupString.includes(groupNames[2].group_name)) {
	                         isChecked = true;
	                    }
	                    console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                cellClick: handleGroupClick
	            },
	            { 
	                title: groupNames[3].group_name, 
	                field: "user_groups", 
	                headerSort: false,
	                width: 140, 
	                hozAlign: "center",
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const groupString = cell.getValue();
	                    console.log("groupString: ", groupString);
	                    let isChecked = false;
	                    
	                    // 1. groupString이 유효하고, 'A 그룹'을 포함하는지 확인
	                    if (groupString && groupString.includes(groupNames[3].group_name)) {
	                         isChecked = true;
	                    }
	                    console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                cellClick: handleGroupClick
	            },
	            { 
	                title: groupNames[4].group_name, 
	                field: "user_groups", 
	                headerSort: false,
	                width: 140, 
	                hozAlign: "center",
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const groupString = cell.getValue();
	                    console.log("groupString: ", groupString);
	                    let isChecked = false;
	                    
	                    // 1. groupString이 유효하고, 'A 그룹'을 포함하는지 확인
	                    if (groupString && groupString.includes(groupNames[4].group_name)) {
	                         isChecked = true;
	                    }
	                    console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                cellClick: handleGroupClick
	            }
	        ],
	        // 모달 내 테이블 클릭 이벤트 (필요 시 추가)
	        rowClick: function(e, row) {
	            // ... (모달 내 테이블 클릭 시 동작 정의)
	        }
	    });
	}

	//발송 알람 선택 테이블
	  function initAlarmGroupTable() {
	    if (alarmGroupTable) {
	    	alarmGroupTable.destroy();
	    }
	    //오늘 날짜
	    const todayDate = getTodayDate();  
	    
	    alarmGroupTable = new Tabulator('#alarmGroupTable', {
	        height: "450px", // 테이블 높이 설정 (모달 크기에 맞게)
	        layout: "fitColumns",
	        headerHozAlign: "center",
	        ajaxConfig: { method: 'POST' },
	        contentType: 'application/json',
	        ajaxLoader: false,
	        ajaxURL: "/ezPublic/alarm/selectAlarmList", 
	        placeholder: "조회된 데이터가 없습니다.",
	        columns: [
	        	{title: "NO", formatter: "rownum", hozAlign: "center", width: 250, headerFilter:true},
		        {title: "알람 주소", field: "alarm_address", hozAlign: "center", width: 180, headerFilter:"select",
		        	headerFilterParams:{
		                values:{
			                "": "전체",
		                    "BCF1": "BCF1호기",
		                    "BCF2": "BCF2호기",
		                    "BCF3": "BCF3호기",
		                    "BCF4": "BCF4호기",
		                    "CM.": "공통1라인",
		                    "CM2": "공통2라인",
		                }
		            }},
		        {title: "알람 내용", field: "comment", hozAlign: "center", width: 250, headerFilter:true},
	            { 
		        	titleFormatter: function(cell, formatterParams, onRender) {
	                    // 헤더 텍스트와 체크박스를 함께 반환
	                    return '<span>'+alarmGroupNames[0].alarm_group_name+'</span> <input type="checkbox" class="header-group-checkbox" style="width: 15px"> ';
	                },
	                alarm_group_id:alarmGroupNames[0].alarm_group_id,
	                //title: alarmGroupNames[0].alarm_group_name,
	                field: "alarm_groups", 
	                width: 110, 
	                hozAlign: "center",
	                headerSort: false, 
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const groupString = cell.getValue();
	                    //console.log("groupString: ", groupString);
	                    let isChecked = false;
	                    
	                    // 1. groupString이 유효하고, 'A 그룹'을 포함하는지 확인
	                    if (groupString && groupString.includes(alarmGroupNames[0].alarm_group_name)) {
	                         isChecked = true;
	                    }
	                    //console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                headerClick: function(e, column) {
	                    const headerCheckbox = e.target;
	                    
	                    if (headerCheckbox.matches('input[type="checkbox"]')) {
	                        e.stopPropagation(); // Tabulator 정렬 이벤트 방지

	                        const isChecked = headerCheckbox.checked;
	                        const columnDefinition = column.getDefinition();
	                        
	                        // 💡 1. 컬럼 정의에서 alarm_group_id를 직접 가져옵니다.
	                        const alarm_group_id = columnDefinition.alarm_group_id; 
	                        
	                        console.log("헤더 체크박스 클릭, 그룹 ID:", alarm_group_id);

	                        // 💡 2. Tabulator 인스턴스에서 현재 로드된 모든 데이터를 가져옵니다.
	                        // dataTable이 전역 Tabulator 인스턴스라고 가정합니다.
	                        const allData = alarmGroupTable.getData();
	                        console.log("allData: ", allData); 
	                        
	                        // 💡 3. 모든 행 데이터에서 alarm_address만 추출합니다.
	                        const alarmAddresses = allData.map(row => row.alarm_address);
	                        console.log("alarmAddresses",alarmAddresses);
	                        
	                        if (alarmAddresses.length === 0) {
	                            alert('현재 테이블에 로드된 알람 데이터가 없습니다.');
	                            return;
	                        }

	                        // 4. 분리된 함수 호출 (함수명 변경 및 파라미터 업데이트)
	                        updateAllAlarmGroup(
	                            alarm_group_id, 
	                            alarmAddresses, // 💡 주소 배열 전달
	                            isChecked,
	                            headerCheckbox
	                        );
	                    }
	                },
	                cellClick: handleAlarmGroupClick
	            },
	            { 
 		        	titleFormatter: function(cell, formatterParams, onRender) {
	                    // 헤더 텍스트와 체크박스를 함께 반환
 		        		return '<span>'+alarmGroupNames[1].alarm_group_name+'</span> <input type="checkbox" class="header-group-checkbox" style="width: 15px"> ';
	                },  
	                //title: alarmGroupNames[1].alarm_group_name,
	                alarm_group_id:alarmGroupNames[1].alarm_group_id,
	                field: "alarm_groups", 
	                width: 110, 
	                hozAlign: "center",
	                headerSort: false,
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const groupString = cell.getValue();
	                    //console.log("groupString: ", groupString);
	                    let isChecked = false;
	                    
	                    // 1. groupString이 유효하고, 'A 그룹'을 포함하는지 확인
	                    if (groupString && groupString.includes(alarmGroupNames[1].alarm_group_name)) {
	                         isChecked = true;
	                    }
	                    //console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                headerClick: function(e, column) {
	                    const headerCheckbox = e.target;
	                    
	                    if (headerCheckbox.matches('input[type="checkbox"]')) {
	                        e.stopPropagation(); // Tabulator 정렬 이벤트 방지

	                        const isChecked = headerCheckbox.checked;
	                        const columnDefinition = column.getDefinition();
	                        
	                        // 💡 1. 컬럼 정의에서 alarm_group_id를 직접 가져옵니다.
	                        const alarm_group_id = columnDefinition.alarm_group_id; 
	                        
	                        console.log("헤더 체크박스 클릭, 그룹 ID:", alarm_group_id);

	                        // 💡 2. Tabulator 인스턴스에서 현재 로드된 모든 데이터를 가져옵니다.
	                        // dataTable이 전역 Tabulator 인스턴스라고 가정합니다.
	                        const allData = alarmGroupTable.getData();
	                        console.log("allData: ", allData); 
	                        
	                        // 💡 3. 모든 행 데이터에서 alarm_address만 추출합니다.
	                        const alarmAddresses = allData.map(row => row.alarm_address);
	                        console.log("alarmAddresses",alarmAddresses);
	                        
	                        if (alarmAddresses.length === 0) {
	                            alert('현재 테이블에 로드된 알람 데이터가 없습니다.');
	                            return;
	                        }

	                        // 4. 분리된 함수 호출 (함수명 변경 및 파라미터 업데이트)
	                        updateAllAlarmGroup(
	                            alarm_group_id, 
	                            alarmAddresses, // 💡 주소 배열 전달
	                            isChecked,
	                            headerCheckbox
	                        );
	                    }
	                },
	                cellClick: handleAlarmGroupClick
	            },
	            { 
 		        	titleFormatter: function(cell, formatterParams, onRender) {
	                    // 헤더 텍스트와 체크박스를 함께 반환
 		        		return '<span>'+alarmGroupNames[2].alarm_group_name+'</span> <input type="checkbox" class="header-group-checkbox" style="width: 15px"> ';
	                },  
	                //title: alarmGroupNames[2].alarm_group_name,
	                alarm_group_id:alarmGroupNames[2].alarm_group_id,
	                field: "alarm_groups", 
	                width: 110, 
	                hozAlign: "center",
	                headerSort: false,
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const groupString = cell.getValue();
	                    //console.log("groupString: ", groupString);
	                    let isChecked = false;
	                    
	                    // 1. groupString이 유효하고, 'A 그룹'을 포함하는지 확인
	                    if (groupString && groupString.includes(alarmGroupNames[2].alarm_group_name)) {
	                         isChecked = true;
	                    }
	                    //console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                headerClick: function(e, column) {
	                    const headerCheckbox = e.target;
	                    
	                    if (headerCheckbox.matches('input[type="checkbox"]')) {
	                        e.stopPropagation(); // Tabulator 정렬 이벤트 방지

	                        const isChecked = headerCheckbox.checked;
	                        const columnDefinition = column.getDefinition();
	                        
	                        // 💡 1. 컬럼 정의에서 alarm_group_id를 직접 가져옵니다.
	                        const alarm_group_id = columnDefinition.alarm_group_id; 
	                        
	                        console.log("헤더 체크박스 클릭, 그룹 ID:", alarm_group_id);

	                        // 💡 2. Tabulator 인스턴스에서 현재 로드된 모든 데이터를 가져옵니다.
	                        // dataTable이 전역 Tabulator 인스턴스라고 가정합니다.
	                        const allData = alarmGroupTable.getData();
	                        console.log("allData: ", allData); 
	                        
	                        // 💡 3. 모든 행 데이터에서 alarm_address만 추출합니다.
	                        const alarmAddresses = allData.map(row => row.alarm_address);
	                        console.log("alarmAddresses",alarmAddresses);
	                        
	                        if (alarmAddresses.length === 0) {
	                            alert('현재 테이블에 로드된 알람 데이터가 없습니다.');
	                            return;
	                        }

	                        // 4. 분리된 함수 호출 (함수명 변경 및 파라미터 업데이트)
	                        updateAllAlarmGroup(
	                            alarm_group_id, 
	                            alarmAddresses, // 💡 주소 배열 전달
	                            isChecked,
	                            headerCheckbox
	                        );
	                    }
	                },
	                cellClick: handleAlarmGroupClick
	            },
	            { 
 		        	titleFormatter: function(cell, formatterParams, onRender) {
	                    // 헤더 텍스트와 체크박스를 함께 반환
 		        		return '<span>'+alarmGroupNames[3].alarm_group_name+'</span> <input type="checkbox" class="header-group-checkbox" style="width: 15px"> ';
	                },  
	                //title: alarmGroupNames[3].alarm_group_name,
	                alarm_group_id:alarmGroupNames[3].alarm_group_id,
	                field: "alarm_groups", 
	                width: 110, 
	                hozAlign: "center",
	                headerSort: false,
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const groupString = cell.getValue();
	                    //console.log("groupString: ", groupString);
	                    let isChecked = false;
	                    
	                    // 1. groupString이 유효하고, 'A 그룹'을 포함하는지 확인
	                    if (groupString && groupString.includes(alarmGroupNames[3].alarm_group_name)) {
	                         isChecked = true;
	                    }
	                    //console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                headerClick: function(e, column) {
	                    const headerCheckbox = e.target;
	                    
	                    if (headerCheckbox.matches('input[type="checkbox"]')) {
	                        e.stopPropagation(); // Tabulator 정렬 이벤트 방지

	                        const isChecked = headerCheckbox.checked;
	                        const columnDefinition = column.getDefinition();
	                        
	                        // 💡 1. 컬럼 정의에서 alarm_group_id를 직접 가져옵니다.
	                        const alarm_group_id = columnDefinition.alarm_group_id; 
	                        
	                        console.log("헤더 체크박스 클릭, 그룹 ID:", alarm_group_id);

	                        // 💡 2. Tabulator 인스턴스에서 현재 로드된 모든 데이터를 가져옵니다.
	                        // dataTable이 전역 Tabulator 인스턴스라고 가정합니다.
	                        const allData = alarmGroupTable.getData();
	                        console.log("allData: ", allData); 
	                        
	                        // 💡 3. 모든 행 데이터에서 alarm_address만 추출합니다.
	                        const alarmAddresses = allData.map(row => row.alarm_address);
	                        console.log("alarmAddresses",alarmAddresses);
	                        
	                        if (alarmAddresses.length === 0) {
	                            alert('현재 테이블에 로드된 알람 데이터가 없습니다.');
	                            return;
	                        }

	                        // 4. 분리된 함수 호출 (함수명 변경 및 파라미터 업데이트)
	                        updateAllAlarmGroup(
	                            alarm_group_id, 
	                            alarmAddresses, // 💡 주소 배열 전달
	                            isChecked,
	                            headerCheckbox
	                        );
	                    }
	                },
	                cellClick: handleAlarmGroupClick
	            },
	            { 
        	      titleFormatter: function(cell, formatterParams, onRender) {
	                    // 헤더 텍스트와 체크박스를 함께 반환
        	    	  return '<span>'+alarmGroupNames[4].alarm_group_name+'</span> <input type="checkbox" class="header-group-checkbox" style="width: 15px"> ';
	                }, 
	                //title: alarmGroupNames[4].alarm_group_name,
	                alarm_group_id:alarmGroupNames[4].alarm_group_id,
	                field: "alarm_groups", 
	                width: 110, 
	                hozAlign: "center",
	                headerSort: false,
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const groupString = cell.getValue();
	                    //console.log("groupString: ", groupString);
	                    let isChecked = false;
	                    
	                    // 1. groupString이 유효하고, 'A 그룹'을 포함하는지 확인
	                    if (groupString && groupString.includes(alarmGroupNames[4].alarm_group_name)) {
	                         isChecked = true;
	                    }
	                    //console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                headerClick: function(e, column) {
	                    const headerCheckbox = e.target;
	                    
	                    if (headerCheckbox.matches('input[type="checkbox"]')) {
	                        e.stopPropagation(); // Tabulator 정렬 이벤트 방지

	                        const isChecked = headerCheckbox.checked;
	                        const columnDefinition = column.getDefinition();
	                        
	                        // 💡 1. 컬럼 정의에서 alarm_group_id를 직접 가져옵니다.
	                        const alarm_group_id = columnDefinition.alarm_group_id; 
	                        
	                        console.log("헤더 체크박스 클릭, 그룹 ID:", alarm_group_id);

	                        // 💡 2. Tabulator 인스턴스에서 현재 로드된 모든 데이터를 가져옵니다.
	                        // dataTable이 전역 Tabulator 인스턴스라고 가정합니다.
	                        const allData = alarmGroupTable.getData();
	                        console.log("allData: ", allData); 
	                        
	                        // 💡 3. 모든 행 데이터에서 alarm_address만 추출합니다.
	                        const alarmAddresses = allData.map(row => row.alarm_address);
	                        console.log("alarmAddresses",alarmAddresses);
	                        
	                        if (alarmAddresses.length === 0) {
	                            alert('현재 테이블에 로드된 알람 데이터가 없습니다.');
	                            return;
	                        }

	                        // 4. 분리된 함수 호출 (함수명 변경 및 파라미터 업데이트)
	                        updateAllAlarmGroup(
	                            alarm_group_id, 
	                            alarmAddresses, // 💡 주소 배열 전달
	                            isChecked,
	                            headerCheckbox
	                        );
	                    }
	                },
	                cellClick: handleAlarmGroupClick
	            },
	            { 
 		        	titleFormatter: function(cell, formatterParams, onRender) {
	                    // 헤더 텍스트와 체크박스를 함께 반환
 		        		return '<span>'+alarmGroupNames[5].alarm_group_name+'</span> <input type="checkbox" class="header-group-checkbox" style="width: 15px"> ';
	                },  
	                //title: alarmGroupNames[5].alarm_group_name,
	                alarm_group_id:alarmGroupNames[5].alarm_group_id,
	                field: "alarm_groups", 
	                width: 110, 
	                hozAlign: "center",
	                headerSort: false,
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const groupString = cell.getValue();
	                    //console.log("groupString: ", groupString);
	                    let isChecked = false;
	                    
	                    // 1. groupString이 유효하고, 'A 그룹'을 포함하는지 확인
	                    if (groupString && groupString.includes(alarmGroupNames[5].alarm_group_name)) {
	                         isChecked = true;
	                    }
	                    //console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                headerClick: function(e, column) {
	                    const headerCheckbox = e.target;
	                    
	                    if (headerCheckbox.matches('input[type="checkbox"]')) {
	                        e.stopPropagation(); // Tabulator 정렬 이벤트 방지

	                        const isChecked = headerCheckbox.checked;
	                        const columnDefinition = column.getDefinition();
	                        
	                        // 💡 1. 컬럼 정의에서 alarm_group_id를 직접 가져옵니다.
	                        const alarm_group_id = columnDefinition.alarm_group_id; 
	                        
	                        console.log("헤더 체크박스 클릭, 그룹 ID:", alarm_group_id);

	                        // 💡 2. Tabulator 인스턴스에서 현재 로드된 모든 데이터를 가져옵니다.
	                        // dataTable이 전역 Tabulator 인스턴스라고 가정합니다.
	                        const allData = alarmGroupTable.getData();
	                        console.log("allData: ", allData); 
	                        
	                        // 💡 3. 모든 행 데이터에서 alarm_address만 추출합니다.
	                        const alarmAddresses = allData.map(row => row.alarm_address);
	                        console.log("alarmAddresses",alarmAddresses);
	                        
	                        if (alarmAddresses.length === 0) {
	                            alert('현재 테이블에 로드된 알람 데이터가 없습니다.');
	                            return;
	                        }

	                        // 4. 분리된 함수 호출 (함수명 변경 및 파라미터 업데이트)
	                        updateAllAlarmGroup(
	                            alarm_group_id, 
	                            alarmAddresses, // 💡 주소 배열 전달
	                            isChecked,
	                            headerCheckbox
	                        );
	                    }
	                },
	                cellClick: handleAlarmGroupClick
	            },
	            { 
 		        	titleFormatter: function(cell, formatterParams, onRender) {
	                    // 헤더 텍스트와 체크박스를 함께 반환
 		        		return '<span>'+alarmGroupNames[6].alarm_group_name+'</span> <input type="checkbox" class="header-group-checkbox" style="width: 15px"> ';
	                },  
	                //title: alarmGroupNames[6].alarm_group_name,
	                alarm_group_id:alarmGroupNames[6].alarm_group_id,
	                field: "alarm_groups", 
	                width: 110, 
	                hozAlign: "center",
	                headerSort: false,
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const groupString = cell.getValue();
	                    //console.log("groupString: ", groupString);
	                    let isChecked = false;
	                    
	                    // 1. groupString이 유효하고, 'A 그룹'을 포함하는지 확인
	                    if (groupString && groupString.includes(alarmGroupNames[6].alarm_group_name)) {
	                         isChecked = true;
	                    }
	                    //console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                headerClick: function(e, column) {
	                    const headerCheckbox = e.target;
	                    
	                    if (headerCheckbox.matches('input[type="checkbox"]')) {
	                        e.stopPropagation(); // Tabulator 정렬 이벤트 방지

	                        const isChecked = headerCheckbox.checked;
	                        const columnDefinition = column.getDefinition();
	                        
	                        // 💡 1. 컬럼 정의에서 alarm_group_id를 직접 가져옵니다.
	                        const alarm_group_id = columnDefinition.alarm_group_id; 
	                        
	                        console.log("헤더 체크박스 클릭, 그룹 ID:", alarm_group_id);

	                        // 💡 2. Tabulator 인스턴스에서 현재 로드된 모든 데이터를 가져옵니다.
	                        // dataTable이 전역 Tabulator 인스턴스라고 가정합니다.
	                        const allData = alarmGroupTable.getData();
	                        console.log("allData: ", allData); 
	                        
	                        // 💡 3. 모든 행 데이터에서 alarm_address만 추출합니다.
	                        const alarmAddresses = allData.map(row => row.alarm_address);
	                        console.log("alarmAddresses",alarmAddresses);
	                        
	                        if (alarmAddresses.length === 0) {
	                            alert('현재 테이블에 로드된 알람 데이터가 없습니다.');
	                            return;
	                        }

	                        // 4. 분리된 함수 호출 (함수명 변경 및 파라미터 업데이트)
	                        updateAllAlarmGroup(
	                            alarm_group_id, 
	                            alarmAddresses, // 💡 주소 배열 전달
	                            isChecked,
	                            headerCheckbox
	                        );
	                    }
	                },
	                cellClick: handleAlarmGroupClick
	            },
	            { 
 		        	titleFormatter: function(cell, formatterParams, onRender) {
	                    // 헤더 텍스트와 체크박스를 함께 반환
 		        		return '<span>'+alarmGroupNames[7].alarm_group_name+'</span> <input type="checkbox" class="header-group-checkbox" style="width: 15px"> ';
	                },  
	                //title: alarmGroupNames[7].alarm_group_name,
	                alarm_group_id:alarmGroupNames[7].alarm_group_id,
	                field: "alarm_groups", 
	                width: 110, 
	                hozAlign: "center",
	                headerSort: false,
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const groupString = cell.getValue();
	                    //console.log("groupString: ", groupString);
	                    let isChecked = false;
	                    
	                    // 1. groupString이 유효하고, 'A 그룹'을 포함하는지 확인
	                    if (groupString && groupString.includes(alarmGroupNames[7].alarm_group_name)) {
	                         isChecked = true;
	                    }
	                    //console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                headerClick: function(e, column) {
	                    const headerCheckbox = e.target;
	                    
	                    if (headerCheckbox.matches('input[type="checkbox"]')) {
	                        e.stopPropagation(); // Tabulator 정렬 이벤트 방지

	                        const isChecked = headerCheckbox.checked;
	                        const columnDefinition = column.getDefinition();
	                        
	                        // 💡 1. 컬럼 정의에서 alarm_group_id를 직접 가져옵니다.
	                        const alarm_group_id = columnDefinition.alarm_group_id; 
	                        
	                        console.log("헤더 체크박스 클릭, 그룹 ID:", alarm_group_id);

	                        // 💡 2. Tabulator 인스턴스에서 현재 로드된 모든 데이터를 가져옵니다.
	                        // dataTable이 전역 Tabulator 인스턴스라고 가정합니다.
	                        const allData = alarmGroupTable.getData();
	                        console.log("allData: ", allData); 
	                        
	                        // 💡 3. 모든 행 데이터에서 alarm_address만 추출합니다.
	                        const alarmAddresses = allData.map(row => row.alarm_address);
	                        console.log("alarmAddresses",alarmAddresses);
	                        
	                        if (alarmAddresses.length === 0) {
	                            alert('현재 테이블에 로드된 알람 데이터가 없습니다.');
	                            return;
	                        }

	                        // 4. 분리된 함수 호출 (함수명 변경 및 파라미터 업데이트)
	                        updateAllAlarmGroup(
	                            alarm_group_id, 
	                            alarmAddresses, // 💡 주소 배열 전달
	                            isChecked,
	                            headerCheckbox
	                        );
	                    }
	                },
	                cellClick: handleAlarmGroupClick
	            },
	            { 
 		        	titleFormatter: function(cell, formatterParams, onRender) {
	                    // 헤더 텍스트와 체크박스를 함께 반환
 		        		return '<span>'+alarmGroupNames[8].alarm_group_name+'</span> <input type="checkbox" class="header-group-checkbox" style="width: 15px"> ';
	                },  
	                //title: alarmGroupNames[8].alarm_group_name,
	                alarm_group_id:alarmGroupNames[8].alarm_group_id,
	                field: "alarm_groups", 
	                width: 110, 
	                hozAlign: "center",
	                headerSort: false,
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const groupString = cell.getValue();
	                    //console.log("groupString: ", groupString);
	                    let isChecked = false;
	                    
	                    // 1. groupString이 유효하고, 'A 그룹'을 포함하는지 확인
	                    if (groupString && groupString.includes(alarmGroupNames[8].alarm_group_name)) {
	                         isChecked = true;
	                    }
	                    //console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                headerClick: function(e, column) {
	                    const headerCheckbox = e.target;
	                    
	                    if (headerCheckbox.matches('input[type="checkbox"]')) {
	                        e.stopPropagation(); // Tabulator 정렬 이벤트 방지

	                        const isChecked = headerCheckbox.checked;
	                        const columnDefinition = column.getDefinition();
	                        
	                        // 💡 1. 컬럼 정의에서 alarm_group_id를 직접 가져옵니다.
	                        const alarm_group_id = columnDefinition.alarm_group_id; 
	                        
	                        console.log("헤더 체크박스 클릭, 그룹 ID:", alarm_group_id);

	                        // 💡 2. Tabulator 인스턴스에서 현재 로드된 모든 데이터를 가져옵니다.
	                        // dataTable이 전역 Tabulator 인스턴스라고 가정합니다.
	                        const allData = alarmGroupTable.getData();
	                        console.log("allData: ", allData); 
	                        
	                        // 💡 3. 모든 행 데이터에서 alarm_address만 추출합니다.
	                        const alarmAddresses = allData.map(row => row.alarm_address);
	                        console.log("alarmAddresses",alarmAddresses);
	                        
	                        if (alarmAddresses.length === 0) {
	                            alert('현재 테이블에 로드된 알람 데이터가 없습니다.');
	                            return;
	                        }

	                        // 4. 분리된 함수 호출 (함수명 변경 및 파라미터 업데이트)
	                        updateAllAlarmGroup(
	                            alarm_group_id, 
	                            alarmAddresses, // 💡 주소 배열 전달
	                            isChecked,
	                            headerCheckbox
	                        );
	                    }
	                },
	                cellClick: handleAlarmGroupClick
	            },
	            { 
 		        	titleFormatter: function(cell, formatterParams, onRender) {
	                    // 헤더 텍스트와 체크박스를 함께 반환
 		        		return '<span>'+alarmGroupNames[9].alarm_group_name+'</span> <input type="checkbox" class="header-group-checkbox" style="width: 15px"> ';
	                },  
	                //title: alarmGroupNames[9].alarm_group_name,
	                alarm_group_id:alarmGroupNames[9].alarm_group_id,
	                field: "alarm_groups", 
	                width: 110, 
	                hozAlign: "center",
	                headerSort: false,
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const groupString = cell.getValue();
	                    //console.log("groupString: ", groupString);
	                    let isChecked = false;
	                    
	                    // 1. groupString이 유효하고, 'A 그룹'을 포함하는지 확인
	                    if (groupString && groupString.includes(alarmGroupNames[9].alarm_group_name)) {
	                         isChecked = true;
	                    }
	                    //console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                headerClick: function(e, column) {
	                    const headerCheckbox = e.target;
	                    
	                    if (headerCheckbox.matches('input[type="checkbox"]')) {
	                        e.stopPropagation(); // Tabulator 정렬 이벤트 방지

	                        const isChecked = headerCheckbox.checked;
	                        const columnDefinition = column.getDefinition();
	                        
	                        // 💡 1. 컬럼 정의에서 alarm_group_id를 직접 가져옵니다.
	                        const alarm_group_id = columnDefinition.alarm_group_id; 
	                        
	                        console.log("헤더 체크박스 클릭, 그룹 ID:", alarm_group_id);

	                        // 💡 2. Tabulator 인스턴스에서 현재 로드된 모든 데이터를 가져옵니다.
	                        // dataTable이 전역 Tabulator 인스턴스라고 가정합니다.
	                        const allData = alarmGroupTable.getData();
	                        console.log("allData: ", allData); 
	                        
	                        // 💡 3. 모든 행 데이터에서 alarm_address만 추출합니다.
	                        const alarmAddresses = allData.map(row => row.alarm_address);
	                        console.log("alarmAddresses",alarmAddresses);
	                        
	                        if (alarmAddresses.length === 0) {
	                            alert('현재 테이블에 로드된 알람 데이터가 없습니다.');
	                            return;
	                        }

	                        // 4. 분리된 함수 호출 (함수명 변경 및 파라미터 업데이트)
	                        updateAllAlarmGroup(
	                            alarm_group_id, 
	                            alarmAddresses, // 💡 주소 배열 전달
	                            isChecked,
	                            headerCheckbox
	                        );
	                    }
	                },
	                cellClick: handleAlarmGroupClick
	            },
	        ],
	        //데이터 로드된 후 타이블의 체크박스 체크 여부
	        
	        dataLoaded: function(data){
	            // 데이터 로드가 완료되면 이 함수가 실행됩니다.
	            
	            // 모든 알람 그룹 컬럼(group_a ~ group_j)에 대해 전체 체크 상태를 확인합니다.
	            //const groupFields = ["group_a", "group_b", "group_c", "group_d", "group_e", "group_f", "group_g", "group_h", "group_i", "group_j"];

	            alarmGroupNames.forEach((groupInfo, index) => {
	                // 데이터 로드 시점에는 현재 셀의 상태 변경이 아니므로 isChecked 인수는 필요 없음.
	                // 대신, 모든 행을 검사하는 checkAllRowsChecked 함수를 사용합니다.
	                checkAllRowsCheckedAndSetHeader(groupInfo.alarm_group_name, index);
	            });
	        },
	        // 모달 내 테이블 클릭 이벤트 (필요 시 추가)
	        rowClick: function(e, row) {
	            // ... (모달 내 테이블 클릭 시 동작 정의)
	        }
	    });
	}

		//타이틀 체크박스 체크 여부
		function checkAllRowsCheckedAndSetHeader(groupName, groupIndex) {
			console.log("타이틀 체크박스 여부", groupName);
    const allRows = alarmGroupTable.getRows();
    console.log("allRows: ", allRows);
    const allData = alarmGroupTable.getData(false);
    console.log("allData", allData);
    
    
    // 1. 모든 행이 체크되어 있는지 확인
    let allChecked = true;
    for (const rowData of allData) {
        const value = rowData["alarm_groups"];
        //console.log("value: ", value);
        if (!value || !value.includes(groupName)) { 
            allChecked = false;
            break;
        }
    }
    console.log("allChecked: ", allChecked);

    // 2. 헤더 체크박스를 찾아서 상태를 업데이트
/*     const headerSelector = ".tabulator-col[tabulator-field='" + fieldName + "'] .tabulator-col-title input[type=\"checkbox\"]";
    
    const headerCheckbox = document.querySelector(headerSelector);
    console.log(fieldName, "헤더 체크박스 요소:", headerCheckbox); 
    if (headerCheckbox) {
        headerCheckbox.checked = allChecked;
        // console.log(`[Data Loaded] ${fieldName} 헤더 상태: ${allChecked}`);
    } */
 // 열 정의의 field 값 사용
    const fieldName = "alarm_groups"; 
    const headerSelector = ".tabulator-col[tabulator-field=" + fieldName + "] .header-group-checkbox"; 
    
    // 이 방법이 전역으로 찾기 때문에 간단하고, Tabulator가 DOM을 로드했을 때 작동합니다.
    const headerCheckboxes = document.querySelectorAll(headerSelector);
    const headerCheckbox = headerCheckboxes[groupIndex];
    
    console.log(fieldName, "헤더 체크박스 요소:", headerCheckbox);

    if (headerCheckbox) {
        // 'checked' 속성을 업데이트합니다.
        headerCheckbox.checked = allChecked;
        console.log(`[Update] ${groupName} 헤더 상태를 ${allChecked}로 업데이트 완료`);
    } else {
        console.warn("[경고] 헤더 체크박스 요소를 찾을 수 없습니다. 셀렉터를 확인하세요:", headerSelector);
    }
}
		

		//그룹별 수신 알람 테이블
	  function initRecieveAlarmTable() {
	    if (recieveAlarmTable) {
	    	recieveAlarmTable.destroy();
	    }
	    
	    recieveAlarmTable = new Tabulator('#recieveAlarmTable', {
	        height: "450px", // 테이블 높이 설정 (모달 크기에 맞게)
	        layout: "fitColumns",
	        headerHozAlign: "center",
	        ajaxConfig: { method: 'POST' },
	        contentType: 'application/json',
	        ajaxLoader: false,
	        ajaxURL: "/ezPublic/user/getGroupList", // 적절한 데이터 로드 URL 사용
	        placeholder: "조회된 데이터가 없습니다.",
	        columns: [
		        {title: "group_id", field: "group_id", hozAlign: "center", width: 130, visible: false},
	        	{ title: "그룹 이름", field: "group_name", hozAlign: "center", width: 150},
	            { 
	                title: alarmGroupNames[0].alarm_group_name, 
	                field: "recieve_alarm", 
	                width: 120, 
	                hozAlign: "center",
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const recievedAlarmIds = cell.getValue(); 
	                    console.log("수신받는 알람: ", recievedAlarmIds);
	                    
	                    const targetAlarmId = alarmGroupNames[0].alarm_group_id;
	                    console.log("열 알람: ", targetAlarmId);
	                    let isChecked = false;

	                        if (recievedAlarmIds && recievedAlarmIds.includes(targetAlarmId)) {
		                        console.log("수신받음")
	                            isChecked = true;
	                        }
	                    
	                    console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                cellClick: recieveAlarmpClick
	            },
	            { 
	                title: alarmGroupNames[1].alarm_group_name, 
	                field: "recieve_alarm", 
	                width: 120, 
	                hozAlign: "center",
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const recievedAlarmIds = cell.getValue(); 
	                    console.log("수신받는 알람: ", recievedAlarmIds);
	                    
	                    const targetAlarmId = alarmGroupNames[1].alarm_group_id;
	                    console.log("열 알람: ", targetAlarmId);
	                    let isChecked = false;

	                        if (recievedAlarmIds && recievedAlarmIds.includes(targetAlarmId)) {
		                        console.log("수신받음")
	                            isChecked = true;
	                        }
	                    
	                    console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                cellClick: recieveAlarmpClick
	            },
	            { 
	                title: alarmGroupNames[2].alarm_group_name, 
	                field: "recieve_alarm", 
	                width: 120, 
	                hozAlign: "center",
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const recievedAlarmIds = cell.getValue(); 
	                    console.log("수신받는 알람: ", recievedAlarmIds);
	                    
	                    const targetAlarmId = alarmGroupNames[2].alarm_group_id;
	                    console.log("열 알람: ", targetAlarmId);
	                    let isChecked = false;

	                        if (recievedAlarmIds && recievedAlarmIds.includes(targetAlarmId)) {
		                        console.log("수신받음")
	                            isChecked = true;
	                        }
	                    
	                    console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                cellClick: recieveAlarmpClick
	            },
	            { 
	                title: alarmGroupNames[3].alarm_group_name, 
	                field: "recieve_alarm", 
	                width: 120, 
	                hozAlign: "center",
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const recievedAlarmIds = cell.getValue(); 
	                    console.log("수신받는 알람: ", recievedAlarmIds);
	                    
	                    const targetAlarmId = alarmGroupNames[3].alarm_group_id;
	                    console.log("열 알람: ", targetAlarmId);
	                    let isChecked = false;

	                        if (recievedAlarmIds && recievedAlarmIds.includes(targetAlarmId)) {
		                        console.log("수신받음")
	                            isChecked = true;
	                        }
	                    
	                    console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                cellClick: recieveAlarmpClick
	            },
	            { 
	                title: alarmGroupNames[4].alarm_group_name, 
	                field: "recieve_alarm", 
	                width: 120, 
	                hozAlign: "center",
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const recievedAlarmIds = cell.getValue(); 
	                    console.log("수신받는 알람: ", recievedAlarmIds);
	                    
	                    const targetAlarmId = alarmGroupNames[4].alarm_group_id;
	                    console.log("열 알람: ", targetAlarmId);
	                    let isChecked = false;

	                        if (recievedAlarmIds && recievedAlarmIds.includes(targetAlarmId)) {
		                        console.log("수신받음")
	                            isChecked = true;
	                        }
	                    
	                    console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                cellClick: recieveAlarmpClick
	            },
	            { 
	                title: alarmGroupNames[5].alarm_group_name, 
	                field: "recieve_alarm", 
	                width: 120, 
	                hozAlign: "center",
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const recievedAlarmIds = cell.getValue(); 
	                    console.log("수신받는 알람: ", recievedAlarmIds);
	                    
	                    const targetAlarmId = alarmGroupNames[5].alarm_group_id;
	                    console.log("열 알람: ", targetAlarmId);
	                    let isChecked = false;

	                        if (recievedAlarmIds && recievedAlarmIds.includes(targetAlarmId)) {
		                        console.log("수신받음")
	                            isChecked = true;
	                        }
	                    
	                    console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                cellClick: recieveAlarmpClick
	            },
	            { 
	                title: alarmGroupNames[6].alarm_group_name, 
	                field: "recieve_alarm", 
	                width: 120, 
	                hozAlign: "center",
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const recievedAlarmIds = cell.getValue(); 
	                    console.log("수신받는 알람: ", recievedAlarmIds);
	                    
	                    const targetAlarmId = alarmGroupNames[6].alarm_group_id;
	                    console.log("열 알람: ", targetAlarmId);
	                    let isChecked = false;

	                        if (recievedAlarmIds && recievedAlarmIds.includes(targetAlarmId)) {
		                        console.log("수신받음")
	                            isChecked = true;
	                        }
	                    
	                    console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                cellClick: recieveAlarmpClick
	            },
	            { 
	                title: alarmGroupNames[7].alarm_group_name, 
	                field: "recieve_alarm", 
	                width: 120, 
	                hozAlign: "center",
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const recievedAlarmIds = cell.getValue(); 
	                    console.log("수신받는 알람: ", recievedAlarmIds);
	                    
	                    const targetAlarmId = alarmGroupNames[7].alarm_group_id;
	                    console.log("열 알람: ", targetAlarmId);
	                    let isChecked = false;

	                        if (recievedAlarmIds && recievedAlarmIds.includes(targetAlarmId)) {
		                        console.log("수신받음")
	                            isChecked = true;
	                        }
	                    
	                    console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                cellClick: recieveAlarmpClick
	            },
	            { 
	                title: alarmGroupNames[8].alarm_group_name, 
	                field: "recieve_alarm", 
	                width: 120, 
	                hozAlign: "center",
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const recievedAlarmIds = cell.getValue(); 
	                    console.log("수신받는 알람: ", recievedAlarmIds);
	                    
	                    const targetAlarmId = alarmGroupNames[8].alarm_group_id;
	                    console.log("열 알람: ", targetAlarmId);
	                    let isChecked = false;

	                        if (recievedAlarmIds && recievedAlarmIds.includes(targetAlarmId)) {
		                        console.log("수신받음")
	                            isChecked = true;
	                        }
	                    
	                    console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                cellClick: recieveAlarmpClick
	            },
	            { 
	                title: alarmGroupNames[9].alarm_group_name, 
	                field: "recieve_alarm", 
	                width: 120, 
	                hozAlign: "center",
	                // HTML 체크박스를 반환하는 formatter
	                formatter: function(cell, formatterParams, onRender){
	                    const recievedAlarmIds = cell.getValue(); 
	                    console.log("수신받는 알람: ", recievedAlarmIds);
	                    
	                    const targetAlarmId = alarmGroupNames[9].alarm_group_id;
	                    console.log("열 알람: ", targetAlarmId);
	                    let isChecked = false;

	                        if (recievedAlarmIds && recievedAlarmIds.includes(targetAlarmId)) {
		                        console.log("수신받음")
	                            isChecked = true;
	                        }
	                    
	                    console.log("isChecked: ", isChecked);
	                    if (isChecked) {
	                        return '<input type="checkbox" checked>';
	                    } else {
	                        return '<input type="checkbox">';
	                    }
	                },
	                cellClick: recieveAlarmpClick
	            },
	        ],
	        // 모달 내 테이블 클릭 이벤트 (필요 시 추가)
	        rowClick: function(e, row) {
	            // ... (모달 내 테이블 클릭 시 동작 정의)
	        }
	    });
	}
//알람 그룹 일관 선택시 호출 함수
/* function updateAllAlarmGroup(columnField, newValue, headerCheckbox) {
    const isChecked = (newValue === 1);
    
    // 2. 서버에 보낼 데이터 (필드와 새 값만 전송)
    const data = {
        fieldName: columnField,         // "group_a", "group_b" 등
        newValue: newValue              // 1 또는 0
    };
    
    // 3. AJAX 호출
    $.ajax({
        url: '/tkheat/alarm/updateAllAlarmGroup', // 🚨 서버 API는 모든 tb_alarm 행을 업데이트
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(data),
        
        success: function(response) {
            if (response === true) { // 서버 응답 성공 확인 (구조에 맞게 수정 필요)
                // 4. Tabulator 데이터 일괄 업데이트 (화면 갱신)
                // 모든 행을 순회하며 해당 컬럼 필드만 업데이트
                alarmGroupTable.getRows().forEach(row => {
                    row.update({ [columnField]: newValue });
                });
                //alert(`알람 그룹 ${groupTitle}의 전체 상태가 성공적으로 ${isChecked ? '추가' : '해제'}되었습니다.`);
            } else {
                alert("오류가 발생했습니다: 일괄 변경 실패");
                // 실패 시 헤더 체크박스 상태를 되돌림
                headerCheckbox.checked = !isChecked;
            }
        },
        error: function(xhr, status, error) {
            alert('오류 발생: 전체 변경 사항이 저장되지 않았습니다. (' + error + ')');
            headerCheckbox.checked = !isChecked; // 실패 시 상태 되돌림
        }
    });
} */
//알람 그룹 일괄 선택시 호출 함수
function updateAllAlarmGroup(alarm_group_id, alarmAddresses, isChecked, headerCheckbox) {
	let url = '';
    let message = '';

    if (isChecked) {
        url = '/ezPublic/alarm/insertAllAlarmGroup'; // 💡 일괄 추가 요청 URL (서버 구현 필요)
        message = '전체 목록이 그룹에 추가되었습니다.';
    } else {
        url = '/ezPublic/alarm/deleteAllAlarmGroup'; // 💡 일괄 삭제 요청 URL (서버 구현 필요)
        message = '전체 목록이 그룹에서 해제되었습니다.';
    }
    
    // 서버로 전송할 데이터 구조 (ID와 주소 목록)
    const dataToSend = {
        alarm_group_id: alarm_group_id,
        alarmAddresses: alarmAddresses // 배열
    };

    $.ajax({
        url: url,
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(dataToSend),
        success: function(response) {
            if (response == true) {
                alert(message);
                // 💡 성공 시 테이블 전체를 새로고침하여 체크박스 상태를 갱신
                alarmGroupTable.replaceData(); 
            } else {
                alert("오류가 발생했습니다: " + response.data);
                // 실패 시 체크박스 상태 되돌리기 (UI와 DB 상태 불일치 방지)
                headerCheckbox.checked = !isChecked; 
            }
        },
        error: function(xhr, status, error) {
            alert('오류 발생: 변경 사항이 저장되지 않았습니다. (' + error + ')');
            // 실패 시 체크박스 상태 되돌리기
            headerCheckbox.checked = !isChecked; 
        }
    });
}

  //그룹 선택시 호출 함수(알람 발송 그룹 관리)
    function handleGroupClick(e, cell) {
        if (e.target.type !== 'checkbox') {
            return; 
        }
        // e.target.checked는 클릭 후의 체크박스 상태 (true 또는 false)를 반환합니다.
        const isChecked = e.target.checked; 

        console.log("체크박스 클릭:", isChecked, cell.getData());
	  console.log("체크박스 클릭:", e.target.checked, cell.getData());
      // 이벤트가 라디오 버튼에서 발생했는지 확인
          const groupTitle = cell.getColumn().getDefinition().title; 
          console.log("어떤 그룹인지: ", groupTitle);
          console.log("user_code: ", cell.getData().user_code);
          const user_code = cell.getData().user_code;
    
    // 2-2. 그룹 제목과 ID를 연결하는 맵 정의 (가장 확실한 방법)
    const groupIdMap = {
    	[groupNames[0].group_name]: groupNames[0].group_id,
    	[groupNames[1].group_name]: groupNames[1].group_id,
    	[groupNames[2].group_name]: groupNames[2].group_id,
    	[groupNames[3].group_name]: groupNames[3].group_id,
    	[groupNames[4].group_name]: groupNames[4].group_id
    };
    const group_id = groupIdMap[groupTitle];
    console.log("group_id: ", group_id);

    let url = '';
    let method = '';
    let message = '';

    if (isChecked) {
        // 체크: 그룹에 추가 (INSERT 요청)
        url = '/ezPublic/user/insertGroup'; // 서버에 그룹 추가를 요청할 URL
        method = 'POST';
        message = '그룹에 추가되었습니다.';
    } else {
        // 체크 해제: 그룹에서 제외 (DELETE 요청)
        url = '/ezPublic/user/deleteGroup'; // 서버에 그룹 해제를 요청할 URL
        method = 'POST'; 
        message = '그룹에서 해제되었습니다.';
    }

    // 서버에 보낼 데이터 (user_code와 group_id)
    const data = {
        user_code: user_code,
        group_id: group_id
    };
    $.ajax({
        url: url,
        type: method,
        contentType: 'application/json', // JSON 형식으로 데이터를 보낼 때
        data: JSON.stringify(data),
        success: function(response) {
            if (response == true) {
                alarmGroupTable.replaceData();
                //alert(`${fieldName} 상태가 성공적으로 ${newValue == 'Y' ? '수신' : '거부'}로 변경되었습니다. (작업 시간 기록 완료)`);
                
                // Tabulator 데이터 업데이트 (화면 갱신)
                const row = cell.getRow();
                const currentData = row.getData();
                
                // Tabulator 행 데이터를 수동으로 업데이트합니다.
/*                 const updateObj = {};
                updateObj[fieldName] = newValue;
                row.update(updateObj);  */
                
            } else {
                alert("오류가 발생했습니다: " + response.data);
            }
        },
        error: function(xhr, status, error) {
            alert('오류 발생: 변경 사항이 저장되지 않았습니다. (' + error + ')');
            // 실패 시 체크박스 상태를 되돌립니다.
            // (가장 확실한 방법은 Tabulator 데이터를 다시 로드하는 것입니다.)
            dataTable.replaceData(); 
        }
    });
  }

  //발송 알람 선택 클릭시
    function handleAlarmGroupClick(e, cell) {
        if (e.target.type !== 'checkbox') {
            return; 
        }
        // e.target.checked는 클릭 후의 체크박스 상태 (true 또는 false)를 반환합니다.
        const isChecked = e.target.checked; 

        console.log("체크박스 클릭:", isChecked, cell.getData());
	  console.log("체크박스 클릭:", e.target.checked, cell.getData());
      // 이벤트가 라디오 버튼에서 발생했는지 확인
          const groupTitle = cell.getColumn().getDefinition().title; 
          console.log("어떤 그룹인지: ", groupTitle);
          console.log("alarm_address: ", cell.getData().alarm_address);
          const alarm_address = cell.getData().alarm_address;
    
    // 2-2. 그룹 제목과 ID를 연결하는 맵 정의 (가장 확실한 방법)
    const alarmGroupIdMap = {
    	[alarmGroupNames[0].alarm_group_name]: alarmGroupNames[0].alarm_id,
    	[alarmGroupNames[1].alarm_group_name]: alarmGroupNames[1].alarm_id,
    	[alarmGroupNames[2].alarm_group_name]: alarmGroupNames[2].alarm_id,
    	[alarmGroupNames[3].alarm_group_name]: alarmGroupNames[3].alarm_id,
    	[alarmGroupNames[4].alarm_group_name]: alarmGroupNames[4].alarm_id,
    	[alarmGroupNames[5].alarm_group_name]: alarmGroupNames[5].alarm_id,
    	[alarmGroupNames[6].alarm_group_name]: alarmGroupNames[6].alarm_id,
    	[alarmGroupNames[7].alarm_group_name]: alarmGroupNames[7].alarm_id,
    	[alarmGroupNames[8].alarm_group_name]: alarmGroupNames[8].alarm_id,
    	[alarmGroupNames[9].alarm_group_name]: alarmGroupNames[9].alarm_id
    };
    const alarm_group_id = cell.getColumn().getDefinition().alarm_group_id;
    console.log("alarm_group_id: ", alarm_group_id);

    let url = '';
    let method = '';
    let message = '';

    if (isChecked) {
        // 체크: 그룹에 추가 (INSERT 요청)
        url = '/ezPublic/alarm/insertAlarmGroup'; // 서버에 그룹 추가를 요청할 URL
        method = 'POST';
        message = '그룹에 추가되었습니다.';
    } else {
        // 체크 해제: 그룹에서 제외 (DELETE 요청)
        url = '/ezPublic/alarm/deleteAlarmGroup'; // 서버에 그룹 해제를 요청할 URL
        method = 'POST'; 
        message = '그룹에서 해제되었습니다.';
    } 

    const data = {
    	alarm_address: alarm_address,
    	alarm_group_id: alarm_group_id
    };
    $.ajax({
        url: url,
        type: method,
        contentType: 'application/json', // JSON 형식으로 데이터를 보낼 때
        data: JSON.stringify(data),
        success: function(response) {
            if (response == true) {
                //alert(`${fieldName} 상태가 성공적으로 ${newValue == 'Y' ? '수신' : '거부'}로 변경되었습니다. (작업 시간 기록 완료)`);
                
                // Tabulator 데이터 업데이트 (화면 갱신)
                const row = cell.getRow();
                const currentData = row.getData();
                alarmGroupTable.replaceData();
                
            } else {
                alert("오류가 발생했습니다: " + response.data);
            }
        },
        error: function(xhr, status, error) {
            alert('오류 발생: 변경 사항이 저장되지 않았습니다. (' + error + ')');
            // 실패 시 체크박스 상태를 되돌립니다.
            // (가장 확실한 방법은 Tabulator 데이터를 다시 로드하는 것입니다.)
            dataTable.replaceData(); 
        }
    });
  }

    //알람 그룹 선택 시 호출 함수
/*     function alarmGroupClick(e, cell) {
        if (e.target.type !== 'checkbox') {
            return; 
        }
        // e.target.checked는 클릭 후의 체크박스 상태 (true 또는 false)를 반환합니다.
        const isChecked = e.target.checked;
        const newValue = isChecked ? 1 : 0; // 서버에 보낼 값 (1 또는 0) 

        const alarm_address = cell.getData().alarm_address; // 알람 고유 ID (PK)
        const columnField = cell.getColumn().getField(); // 클릭된 칼럼 이름 (예: "group_a", "group_b")
        const groupTitle = cell.getColumn().getDefinition().title; // 컬럼 제목 (예: "그룹 A")
        console.log("alarm_address: ", alarm_address + ", 필드: ", columnField + ", 새 값: ", newValue);

        // 서버에 보낼 데이터
        const data = {
        	alarm_address: alarm_address,
            fieldName: columnField, // "group_a", "group_b" 등
            newValue: newValue      // 1 또는 0
        };
        $.ajax({
            url: '/tkheat/alarm/updateAlarmGroup', 
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            
            success: function(response) {
                // 서버 응답이 성공 (true)일 경우
                if (response === true) { // 서버 응답 구조에 맞게 수정 (예: {success: true})
                    //alert(`${groupTitle} 상태가 성공적으로 ${isChecked ? '추가' : '해제'}되었습니다.`);
                    
                    // 2. Tabulator 데이터 업데이트 (화면 갱신)
                    const row = cell.getRow();
                    const updateObj = {};
                    const isChecked = e.target.checked;
                    
                    // 클릭된 칼럼 필드(group_a 등)의 값을 새 값(1 또는 0)으로 설정
                    updateObj[columnField] = newValue;
                    row.update(updateObj); 

                    checkAllRowsCheckedAndSetHeader(columnField);
                    
                } else {
                    alert("오류가 발생했습니다: " + (response.message || '알 수 없는 오류'));
                    // 실패 시, Tabulator를 강제 새로고침하여 체크박스 상태를 되돌립니다.
                    // alarmGroupTable.replaceData(); 
                }
            },
            error: function(xhr, status, error) {
                alert('오류 발생: 변경 사항이 저장되지 않았습니다. (' + error + ')');
                // 실패 시, 실제 데이터의 상태와 맞추기 위해 테이블을 새로고침하는 것이 안전합니다.
                // alarmGroupTable.replaceData(); 
            }
        });
  } */

    //그룹별 수신 알람 선택 시 호출 함수
    function recieveAlarmpClick(e, cell) {
        if (e.target.type !== 'checkbox') {
            return; 
        }
        const alarmGroupIdMap = {
            	[alarmGroupNames[0].alarm_group_name]: alarmGroupNames[0].alarm_group_id,
            	[alarmGroupNames[1].alarm_group_name]: alarmGroupNames[1].alarm_group_id,
            	[alarmGroupNames[2].alarm_group_name]: alarmGroupNames[2].alarm_group_id,
            	[alarmGroupNames[3].alarm_group_name]: alarmGroupNames[3].alarm_group_id,
            	[alarmGroupNames[4].alarm_group_name]: alarmGroupNames[4].alarm_group_id,
            	[alarmGroupNames[5].alarm_group_name]: alarmGroupNames[5].alarm_group_id,
            	[alarmGroupNames[6].alarm_group_name]: alarmGroupNames[6].alarm_group_id,
            	[alarmGroupNames[7].alarm_group_name]: alarmGroupNames[7].alarm_group_id,
            	[alarmGroupNames[8].alarm_group_name]: alarmGroupNames[8].alarm_group_id,
            	[alarmGroupNames[9].alarm_group_name]: alarmGroupNames[9].alarm_group_id
            };
        // e.target.checked는 클릭 후의 체크박스 상태 (true 또는 false)를 반환합니다.
        const isChecked = e.target.checked;
        const newValue = isChecked ? 1 : 0; // 서버에 보낼 값 (1 또는 0) 

        const group_id = cell.getData().group_id; // 알람 고유 ID (PK)
        const columnField = cell.getColumn().getField(); // 클릭된 칼럼 이름 (예: "group_a", "group_b")
        const groupTitle = cell.getColumn().getDefinition().title; // 컬럼 제목 (예: "그룹 A")
        const alarm_id = alarmGroupIdMap[groupTitle];
        console.log("그룹 ID: ", group_id + ", 필드: ", columnField + ", 새 값: ", newValue + ",그룹 이름: ", groupTitle + ", 알람 ID: ", alarm_id);

        // 서버에 보낼 데이터
        const data = {
        	group_id: group_id,
            fieldName: columnField, // "group_a", "group_b" 등
            newValue: newValue,      // 1 또는 0
            alarm_group_id: alarm_id
        };

        let url;
        let type;

        if (newValue === 1) { 
            url = '/ezPublic/user/updateRecieveAlarm';
            type = 'POST';
        } else { 
            url = '/ezPublic/user/deleteRecieveAlarm';
            type = 'POST';
        }
        
        $.ajax({
        	url: url,
            type: type,
            contentType: 'application/json',
            data: JSON.stringify(data),
            
            success: function(response) {
                // 서버 응답이 성공 (true)일 경우
                if (response === true) { // 서버 응답 구조에 맞게 수정 (예: {success: true})
                    //alert(`${groupTitle} 상태가 성공적으로 ${isChecked ? '추가' : '해제'}되었습니다.`);
                    
                    // 2. Tabulator 데이터 업데이트 (화면 갱신)
                    const row = cell.getRow();
                    const updateObj = {};
                    
                    // 클릭된 칼럼 필드(group_a 등)의 값을 새 값(1 또는 0)으로 설정
                    updateObj[columnField] = newValue;
                    row.update(updateObj); 
                    
                } else {
                    alert("오류가 발생했습니다: " + (response.message || '알 수 없는 오류'));
                    // 실패 시, Tabulator를 강제 새로고침하여 체크박스 상태를 되돌립니다.
                    // alarmGroupTable.replaceData(); 
                }
            },
            error: function(xhr, status, error) {
                alert('오류 발생: 변경 사항이 저장되지 않았습니다. (' + error + ')');
                // 실패 시, 실제 데이터의 상태와 맞추기 위해 테이블을 새로고침하는 것이 안전합니다.
                // alarmGroupTable.replaceData(); 
            }
        });
  }
    
//1호기 수신/거부 라디오 버튼 포맷터
function customCheckboxFormatter1(cell, formatterParams, onRendered) {
    const data = cell.getRow().getData();
    
    // 데이터가 null/undefined일 경우 'N'으로 기본값 설정
    const ynValue = data.message_yn || 'N'; 
    
    //console.log("ynValue: ", ynValue);
    
    // 1. 셀이 렌더링 된 후 실행될 콜백 함수를 등록합니다.
    onRendered(function() {
        // 셀 컴포넌트(cell)의 DOM 요소 내에서 체크박스를 찾습니다.
        const checkbox = cell.getElement().querySelector('input[type="checkbox"]');
        
        if (checkbox) {
            // 2. data.message_yn 값에 따라 체크박스의 checked 속성을 직접 설정합니다.
            // 'Y'이면 true (체크됨), 아니면 false (체크 안됨)
            checkbox.checked = (ynValue === 'Y');
            
            // 3. (선택 사항) 체크박스에 대한 이벤트 리스너를 여기서 설정할 수도 있습니다.
            //    현재는 column 정의의 cellClick을 사용하고 있다면 이 부분은 불필요합니다.
        }
    });

    // 4. 반환할 HTML 문자열 (checked 속성 없이 깨끗하게)
    //    체크 상태는 onRendered에서 설정되므로, HTML 템플릿에는 checked 속성을 넣지 않습니다.
    return `
        <label style="display: block; width: 100%; text-align: center;">
            <input type="checkbox" 
                   value="Y" 
                   data-field="message_yn" 
                   data-code="${data.user_code}"> 수신
        </label>
    `;
}
//2호기 수신/거부 라디오 버튼 포맷터 (message_yn2 필드를 사용)
  function customCheckboxFormatter2(cell, formatterParams, onRendered) {
	    const data = cell.getRow().getData();
	    
	    // 데이터가 null/undefined일 경우 'N'으로 기본값 설정
	    const ynValue = data.message_yn2 || 'N'; 
	    
	    //console.log("ynValue: ", ynValue);
	    
	    // 1. 셀이 렌더링 된 후 실행될 콜백 함수를 등록합니다.
	    onRendered(function() {
	        // 셀 컴포넌트(cell)의 DOM 요소 내에서 체크박스를 찾습니다.
	        const checkbox = cell.getElement().querySelector('input[type="checkbox"]');
	        
	        if (checkbox) {
	            // 2. data.message_yn 값에 따라 체크박스의 checked 속성을 직접 설정합니다.
	            // 'Y'이면 true (체크됨), 아니면 false (체크 안됨)
	            checkbox.checked = (ynValue === 'Y');
	            
	            // 3. (선택 사항) 체크박스에 대한 이벤트 리스너를 여기서 설정할 수도 있습니다.
	            //    현재는 column 정의의 cellClick을 사용하고 있다면 이 부분은 불필요합니다.
	        }
	    });

	    // 4. 반환할 HTML 문자열 (checked 속성 없이 깨끗하게)
	    //    체크 상태는 onRendered에서 설정되므로, HTML 템플릿에는 checked 속성을 넣지 않습니다.
	    return `
	        <label style="display: block; width: 100%; text-align: center;">
	            <input type="checkbox" 
	                   value="Y" 
	                   data-field="message_yn2" 
	                   data-code="${data.user_code}"> 수신
	        </label>
	    `;
  }

//라디오 버튼 클릭 이벤트 처리 함수
  function handleCheckboxClick(e, cell) {
	  console.log("체크박스 클릭:", e.target.checked, cell.getData());
      // 이벤트가 라디오 버튼에서 발생했는지 확인
      
    // 1. 클릭된 체크박스의 상태 및 정보 추출
    const input = e.target;
    const row = cell.getRow();
    const rowData = row.getData();
    const fieldName = cell.getField(); // 'message_yn' 또는 'message_yn2'
    const newValue = input.checked ? 'Y' : 'N'; // 👈 실제 체크 상태를 기준으로 'Y'/'N' 결정
    
    // 2. Tabulator 내부 데이터 갱신 (화면과 데이터 일치)
    // 클릭된 필드의 상태만 Tabulator 내부 데이터에 반영
    row.update({
        [fieldName]: newValue
    }).then(function() {
        // 3. 서버 전송 데이터 준비
        // 최신 데이터(클릭으로 인해 message_yn/2가 업데이트된 상태)를 가져옵니다.
        const currentData = row.getData();
        console.log("currentData: ", currentData);
        
        // 서버 @ModelAttribute Users에 맞게 필요한 최소 필드만 구성
        const dataToSend = {
            user_code: currentData.user_code,
            user_id: currentData.user_id,
            user_pw: currentData.user_pw,
            message_yn: currentData.message_yn,
            message_yn2: currentData.message_yn2
        };
        
        console.log("메시지 수신 상태 업데이트 요청 데이터:", dataToSend);

          // 2. AJAX 통신 (tb_user 업데이트 및 tb_user_worktime 저장)
          $.ajax({
              url: "/ezPublic/user/updateMessage", 
              type: "POST",
              data: dataToSend,
              success: function(response) {
                  if (response == true) {
                      //alert(`${fieldName} 상태가 성공적으로 ${newValue == 'Y' ? '수신' : '거부'}로 변경되었습니다. (작업 시간 기록 완료)`);
                      
                      // Tabulator 데이터 업데이트 (화면 갱신)
                      const row = cell.getRow();
                      const currentData = row.getData();
                      
                      // Tabulator 행 데이터를 수동으로 업데이트합니다.
                      const updateObj = {};
                      updateObj[fieldName] = newValue;
                      row.update(updateObj); 
                      
                  } else {
                      alert("업데이트 중 오류가 발생했습니다: " + response.data);
                  }
              },
              error: function() {
                  alert('서버와의 통신 중 오류가 발생했습니다.');
              }
          });
    });
  }
	
  // 삽입 버튼 클릭 시
  $('.insert-button').click(function() {
      // 수정 숨기고 저장 보이게
      $('#saveCorrStatus').show();
      $('#updateCorrStatus').hide();
    selectedRowData = null;
    $('#corrForm')[0].reset();
    $('#modalContainer').show().addClass('show');
    initModalDataTable(); 
  });

  // 알람 발송 스케줄 시간 버튼 클릭 시
  $('.group-time-button').click(function() {
	  $('#groupTimeModal form').trigger('reset');
	  $('#deleteBtn').hide();
	  $('#updateBtn').hide();
	  $('#saveTimeBtn').show();
    $('#groupTimeModal').show().addClass('show');
  });

  // 알람 그룹 관리 버튼 클릭 시
  $('.alarm-group-button').click(function() {
    $('#alarmGroupModal').show().addClass('show');
    initAlarmGroupTable();
  });
  // 그룹별 수신 알람 설정 버튼 클릭 시
  $('.recieve-alarm-button').click(function() {
    $('#recieveAlarmModal').show().addClass('show');
    initRecieveAlarmTable();
  });
  // 그룹 이름 수정 버튼 클릭 시
  $('.update-group-name-button').click(function() {
    $('#updateGroupModel').show().addClass('show');
    initRecieveAlarmTable();
  });

  // 삭제 버튼 클릭 시
  $('.delete-button').click(function() {
    if (!selectedRowData) {
      alert('삭제할 행을 먼저 클릭해 주세요.');
      return;
    }
    if (!selectedRowData) {
    	  alert('삭제할 행을 먼저 클릭해 주세요.');
    	  return;
    	}
    	if (!confirm('선택된 항목을 정말 삭제하시겠습니까?')) return;

    	const deleteData = { user_code: selectedRowData.user_code };
    	console.log("삭제 요청 데이터:", deleteData); // 추가된 로그

    	$.ajax({
    	  url: "/geomet/user/userInsert/delete",
    	  type: "POST",
    	  contentType: "application/json",
    	  data: JSON.stringify(deleteData),
    	  success: function(res) {
    	    alert('삭제되었습니다.');
    	
    	    dataTable.setData("/geomet/user/userInsert/select", {});
    	    selectedRowData = null;
    	  },
    	  error: function() {
    	    alert('삭제 중 오류가 발생했습니다.');
    	  }
    	});
  });

  // 모달 닫기
  $('.close, #closeModal, #cancelBtn').click(function() {
    $('#modalContainer').removeClass('show').hide();
    $('#groupTimeModal').removeClass('show').hide();
    $('#alarmGroupModal').removeClass('show').hide();
    $('#recieveAlarmModal').removeClass('show').hide();
    $('#updateGroupModel').removeClass('show').hide();
    dataTable.setData("/ezPublic/user/selectList", {});
  });

//1. 오늘 날짜를 YYYY-MM-DD 형식으로 반환하는 헬퍼 함수
  function getTodayDate() {
      const today = new Date();
      const year = today.getFullYear();
      // getMonth()는 0부터 시작하므로 +1, padStart(2, '0')로 2자리수 확보
      const month = String(today.getMonth() + 1).padStart(2, '0');
      const day = String(today.getDate()).padStart(2, '0');
      return year + "-" + month + "-" + day;
  }
  
  // 저장 버튼 클릭 시
  $('#saveCorrStatus').click(function(event) {
    event.preventDefault();

    const todayDate = getTodayDate();
    console.log("todayDate: ", todayDate);
    let dataToSend = []; // 전송할 데이터를 담을 배열
    let dataToDelete = [];  //  삭제할 데이터

    if (!modalDataTable) {
        alert('테이블 데이터가 준비되지 않았습니다.');
        return;
    }

    dataToSend = []; // 데이터 배열 초기화

    // 1. Tabulator에서 모든 행 컴포넌트(Row Component)를 가져옵니다.
    const allRows = modalDataTable.getRows();

    // 2. 각 행을 순회하며 DOM 요소의 체크박스 상태를 직접 확인합니다.
    allRows.forEach(row => {
        const rowElement = row.getElement(); // 행의 DOM 요소
        const rowData = row.getData();       // 행의 기본 데이터

        const workTime = rowData.work_time || "";
        
        if (workTime === '오전' || workTime === '오후') { 
            dataToSend.push({
                user_code: rowData.user_code,
                work_day: todayDate,
                work_time: workTime
            });
        }else if (workTime === "" || workTime === "선택 안함") { 
            // 삭제 요청은 user_code와 work_day만 필요
            dataToDelete.push({
                user_code: rowData.user_code,
                work_day: todayDate
            });
        }
    });
    
    if (dataToSend.length === 0) {
        alert("저장할 체크된 사용자 데이터가 없습니다.");
        return;
    }

    console.log("서버에 전송할 체크된 사용자 데이터 (JSON 배열):", dataToSend);
    console.log("삭제할 데이터:", dataToDelete);

    //2. ajax 요청
    let ajaxRequests = [];
    if (dataToSend.length > 0) {
    $.ajax({
      url: "/ezPublic/user/insertWorkTime",
      type: "POST",
      contentType: "application/json", // 👈 필수: JSON 데이터임을 서버에 알림
      data: JSON.stringify(dataToSend), // 👈 필수: JS 객체를 JSON 문자열로 변환
      //processData: false,
      //contentType: false,
      success: function(result) {
        console.log(result);
        if (result === true) {
            //alert("성공적으로 저장되었습니다."); // "사용자 정보가 성공적으로 저장되었습니다."
            $('#modalContainer').hide();
            //dataTable.setData("/tkheat/user/selectList", {});
            //selectedRowData = null;
        } else {
            //alert("오류: " + result.data); 
        }
      },
      error: function() {
        alert('저장 중 오류가 발생했습니다.');
      }
    });
    }

    if (dataToDelete.length > 0) {
        ajaxRequests.push(
            $.ajax({
                // 🚨 삭제 전용 컨트롤러 URL 사용
                url: "/ezPublic/user/deleteWorkTime", 
                type: "POST", // DELETE 메서드가 더 적합하지만, POST를 흔히 사용
                contentType: "application/json",
                data: JSON.stringify(dataToDelete)
            })
        );
        console.log("삭제 데이터:", dataToDelete);
    }

    // 3. 모든 요청의 성공/실패 처리
    Promise.all(ajaxRequests)
        .then(results => {
            // 모든 요청이 성공했을 때
            alert("작업 시간 정보가 성공적으로 처리되었습니다.");
            $('#modalContainer').hide();
            dataTable.setData("/ezPublic/user/selectList", {});
        })
        .catch(error => {
            // 하나라도 실패했을 때
            alert('일부 요청 처리 중 오류가 발생했습니다.');
            console.error("AJAX 오류:", error);
        });
  });

  // 시간 저장 버튼 클릭 시
  $('#saveTimeBtn').click(function(event) {
    event.preventDefault();
    
    const formElement = document.getElementById('groupTimeForm'); 
    
    // 🌟 폼 요소를 FormData에 전달합니다. 🌟
    const formData = new FormData(formElement); 

    // ... (이하 데이터 추출 로직은 동일) ...
    const data = {
    	group_id: formData.get('group_id'),
        start_date: formData.get('start_date'),
        end_date: formData.get('end_date'),
        start_time: formData.get('start_time'),
        end_time: formData.get('end_time')
    };
    console.log("전송 data: ", data);

    if (!data.group_id || !data.start_date || 
    		!data.end_date || !data.start_time || !data.end_time) {
        alert("모든 항목을 선택해 주세요.");
        return;
    }
    
    $.ajax({
        url: '/ezPublic/user/insertGroupSchedule', 
        type: 'POST', 
        contentType: 'application/json', // 보내는 데이터 형식: JSON
        data: JSON.stringify(data), // JavaScript 객체를 JSON 문자열로 변환하여 전송
        success: function(response) {
            alert("알림 수신 시간이 성공적으로 업데이트되었습니다. ");
            
            // 모달 닫기 (이전에 정의된 closeGroupTimeModal 함수 사용 가정)
            if (typeof closeGroupTimeModal === 'function') {
                closeGroupTimeModal();
            } else {
                // closeGroupTimeModal 함수가 없을 경우, jQuery로 모달 숨기기
                $('#groupTimeModal').hide(); 
            }
            calendar.refetchEvents();
        },
        error: function(xhr, status, error) {
            alert('시간 설정 업데이트 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요. ❌');
            console.error("AJAX Error:", error, xhr.responseText);
        }
    });
    
  });

  // 시간 수정 버튼 클릭 시
  $('#updateBtn').click(function(event) {
    event.preventDefault();
    
    const formElement = document.getElementById('groupTimeForm'); 
    
    // 🌟 폼 요소를 FormData에 전달합니다. 🌟
    const formData = new FormData(formElement); 

    // ... (이하 데이터 추출 로직은 동일) ...
    const data = {
        schedule_id: formData.get('schedule_id'),
        group_id: formData.get('group_id'),
        start_date: formData.get('start_date'),
        end_date: formData.get('end_date'),
        start_time: formData.get('start_time'),
        end_time: formData.get('end_time')
    };
    console.log("전송 data: ", data);

    if (!data.schedule_id || !data.group_id || !data.start_date || 
    		!data.end_date || !data.start_time || !data.end_time) {
        alert("모든 항목을 선택해 주세요.");
        return;
    }
    
    $.ajax({
        url: '/ezPublic/user/updateGroupSchedule', 
        type: 'POST', 
        contentType: 'application/json', // 보내는 데이터 형식: JSON
        data: JSON.stringify(data), // JavaScript 객체를 JSON 문자열로 변환하여 전송
        success: function(response) {
            alert("알림 수신 시간이 성공적으로 업데이트되었습니다. ");
            
            // 모달 닫기 (이전에 정의된 closeGroupTimeModal 함수 사용 가정)
            if (typeof closeGroupTimeModal === 'function') {
                closeGroupTimeModal();
            } else {
                // closeGroupTimeModal 함수가 없을 경우, jQuery로 모달 숨기기
                $('#groupTimeModal').hide(); 
            }
            calendar.refetchEvents();
        },
        error: function(xhr, status, error) {
            alert('시간 설정 업데이트 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요. ❌');
            console.error("AJAX Error:", error, xhr.responseText);
        }
    });
    
  });

  // 스케줄 삭제 버튼 클릭 시
  $('#deleteBtn').click(function(event) {
    event.preventDefault();
    
    const formElement = document.getElementById('groupTimeForm'); 
    
    // 🌟 폼 요소를 FormData에 전달합니다. 🌟
    const formData = new FormData(formElement); 
    // ... (이하 데이터 추출 로직은 동일) ...
    const data = {
        schedule_id: formData.get('schedule_id')
    };
    
    if (confirm("스케줄을 삭제하시겠습니까?")) {
        

        $.ajax({
            url: "/ezPublic/user/deleteSchedule",
            type: "POST", 
            contentType: "application/json", 
            data: JSON.stringify(data),
            success: function(response) {
                if (response === true || response.success === true) { 
                    alert("스케줄이 성공적으로 삭제되었습니다.");
                    $('#groupTimeModal').hide();
                    calendar.refetchEvents();
                } else {
                    alert("스케줄 삭제에 실패했습니다.");
                    console.error("서버 응답 오류:", response);
                }
            },
            error: function(xhr, status, error) {
                alert('서버 통신 오류로 삭제에 실패했습니다. (' + error + ')');
            }
        });
        
    } else {
        return;
    } 
    
  });

  //수정 버튼 클릭 시
  $('#updateCorrStatus').click(function(event) {
    event.preventDefault();
    //var formData = new FormData($('#corrForm')[0]);
    var formData = $('#corrForm').serialize();
    if (selectedRowData && selectedRowData.user_code) {
      formData.append('user_code', selectedRowData.user_code);  // 수정 시 user_code 추가
    }
/*     for (var pair of formData.entries()) {
        console.log(pair[0] + ': ' + pair[1]);
      } */
        

    $.ajax({
      url: "/geomet/user/userInsert/update",
      type: "POST",
      data: formData,
      //processData: false,
      //contentType: false,
      success: function() {
        alert("수정되었습니다!");
        $('#modalContainer').hide();
    
        dataTable.setData("/geomet/user/userInsert/select", {});
        selectedRowData = null;
      },
      error: function() {
        alert('저장 중 오류가 발생했습니다.');
      }
    });
  });

  //그룹별 조회
  $('#groupSelect').on('change', function() {
      const selectedGroupId = $(this).val(); // 선택된 <option>의 value (그룹 ID 또는 빈 문자열)
      const selectedGroupName = $(this).find('option:selected').text();
      /*       // 빈 문자열인 경우 null로 변환 (Integer 바인딩 오류 방지)
      if (selectedGroupId === "") {
          selectedGroupId = null;
      } */
      console.log("선택된 그룹 ID:", selectedGroupId);
      console.log("선택된 그룹 이름:", selectedGroupName);
      // 1. 서버에 전송할 데이터 
      const dataToSend = {
          group_id: selectedGroupId, 
          group_name: selectedGroupName
      };
      if (selectedGroupId === "") {
          dataToSend.group_name = null;
      }

      // 2. AJAX 요청: 서버에서 필터링된 알람 목록을 요청
      $.ajax({
          url: "/ezPublic/user/getGroupUser",
          type: 'POST', 
          contentType: 'application/json', // 보내는 데이터 형식: JSON
          data: JSON.stringify(dataToSend), // JavaScript 객체를 JSON 문자열로 변환하여 전송 
          success: function(filteredData) {
              console.log("필터링된 데이터 수신:", filteredData.length);
              
              // 3. Tabulator 데이터 갱신
              // dataTable은 Tabulator 인스턴스 변수라고 가정합니다.
              if (typeof dataTable !== 'undefined' && dataTable.replaceData) {
                  // 서버로부터 받은 새 데이터로 Tabulator를 교체하여 화면을 갱신합니다.
                  dataTable.replaceData(filteredData);
              } else {
                  console.error("Tabulator 인스턴스를 찾을 수 없습니다: dataTable");
              }
          },
          
          error: function(xhr, status, error) {
              console.error("그룹별 알람 조회 중 오류 발생:", error);
              alert("알람 목록을 조회하는 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
          }
      });
  });
});
</script>


</body>
</html>