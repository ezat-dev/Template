<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/ezPublic/css/login/style.css">
    <%@include file="include/pluginpage.jsp" %>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <title>로그인</title>

    <style>
        /* 기본 스타일 재설정 (기존 코드 유지) */
        a, button, input, select, h1, h2, h3, h4, h5, * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            border: none;
            text-decoration: none;
            background: none;
            -webkit-font-smoothing: antialiased;
        } 
        
        /* ======================================= */
        /* 💡 로그인 페이지 스타일 (개선된 부분) */
        /* ======================================= */
        
        /* 전체 페이지 배경 및 중앙 정렬 */
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f0f2f5; /* 밝은 회색 배경 */
            font-family: Arial, sans-serif;
            margin: 0;
        }

        /* 로그인 카드 컨테이너 */
        .login-container {
            width: 100%;
            max-width: 400px; /* 최대 너비 설정 */
            padding: 40px;
            background-color: #ffffff; /* 흰색 카드 배경 */
            border-radius: 10px; /* 둥근 모서리 */
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* 은은한 그림자 */
            text-align: center;
        }

        /* 헤더 / 타이틀 스타일 */
        .header-title {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 30px;
        }
        
        /* 폼 그룹 및 인풋 스타일 */
        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .input-group label {
            display: block;
            font-size: 14px;
            color: #555;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .input-group input[type="text"],
        .input-group input[type="password"] {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            color: #333;
            transition: border-color 0.3s;
        }

        .input-group input:focus {
            outline: none;
            border-color: #007bff; /* 포커스 시 색상 변경 */
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.25);
        }

        /* 로그인 버튼 스타일 */
        .login-btn {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            background-color: #007bff; /* 파란색 버튼 */
            color: white;
            font-size: 18px;
            font-weight: bold;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .login-btn:hover {
            background-color: #0056b3; /* 호버 시 진한 파란색 */
        }
        
        /* 카피라이트 텍스트 */
        .copyright {
            margin-top: 40px;
            font-size: 12px;
            color: #888;
        }
    </style>
</head>
<body>
    <div class="login-container">
        
        <h2 class="header-title">알람 발송 관리 로그인</h2>
        
        <form id="userForm">
            <div class="input-group">
                <label for="n_id">아이디</label>
                <input type="text" name="user_id" placeholder="아이디를 입력하세요." />
            </div>

            <div class="input-group">
                <label for="n_pw">패스워드</label>
                <input type="password" name="user_pw" placeholder="비밀번호를 입력하세요." />
            </div>

            <input type="hidden" id="n_ip" name="user_ip" />
            
            <button type="button" class="login-btn" onclick="login();">로그인</button>
        </form>
        
        <p class="copyright">Copyright 2025. EZAutomation Co. All rights reserved.</p>
        
    </div>

    <script>
        $(function(){
            $.ajax({
                url:"https://api.ip.pe.kr/json" 
            }).done(function(val){
                console.log(val);
                $("#n_ip").val(val.ip);
            });
        });
        $('input[name="user_id"], input[name="user_pw"]').keypress(function(event) {
            if (event.keyCode == 13 || event.which == 13) {
                event.preventDefault(); 
                login(); 
            }
        });
        function login(){
            var userData = $("#userForm").serialize(); 
            $.ajax({
                url:"/ezPublic/user/login",
                type:"post",
                dataType: "json",
                data:userData,
                success:function(result){                
                    console.log(result);
                    if(result.status == "NG"){
                        alert(result.data);    
                    }else{                
                        location.href = "/ezPublic/main";
                    }
                }
            });
        }
    </script>
</body>
</html>