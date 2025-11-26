package com.tkheat.domain;

public class Users {

	//USERT테이블(작업자 등록)
	private int user_code;
	private String user_no;
	private String user_name;
	private String user_buso;
	private String user_jick;
	private String user_bigo;
	private String user_jdate;
	private String user_odate;
	private String user_ret;
	private String user_seq;
	private String user_add;
	private String user_id;
	private String user_pwd;
	private String user_phone;
	private String user_sms;
	private String user_chigu;
	private String user_chkfac;
	private String user_suri;
	private String user_coilchk;
	private String user_plugchk;
	private String user_ip;
	private String user_pw;
	private String user_level;
	private String user_busu;
	private String user_yn;
	private String st_day;
	private String message_yn;
	private String message_yn2;
	private String user_company;
	private String user_role;
	private String work_day;
	private String work_time;
	private String no;
	private String device_token;
	
	//그룹
	private String group_id;
	private String group_name;
	private Integer user_group_id;
	private String user_groups;
	private String userGroups;
	private String start_time;
	private String end_time;
	private String start_date;
	private String end_date;
	private String recieve_a;
	private String recieve_b;
	private String recieve_c;
	private String recieve_d;
	private String recieve_e;
	private String recieve_f;
	private String recieve_g;
	private String recieve_h;
	private String recieve_i;
	private String recieve_j;
	private String fieldName;
	private String newValue;
	private String alarm_address;
	private String comment;
	private String a_hogi;
	private String regtime;
	private String schedule_id;
	
	
	//공지사항
	private int notice_code;
	private String notice_name;
	private String notice_memo;
	private String notice_user;
	private String notice_date;
	private int notice_views;
	private String notice_dates;
	private String notice_datee;
	
	private String company_code;
	private String alarm_group_id;
	private String recieve_alarm;
	private String company_name;
	

	public String getCompany_name() {
		return company_name;
	}
	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}
	public String getRecieve_alarm() {
		return recieve_alarm;
	}
	public void setRecieve_alarm(String recieve_alarm) {
		this.recieve_alarm = recieve_alarm;
	}
	public String getAlarm_group_id() {
		return alarm_group_id;
	}
	public void setAlarm_group_id(String alarm_group_id) {
		this.alarm_group_id = alarm_group_id;
	}
	public String getCompany_code() {
		return company_code;
	}
	public void setCompany_code(String company_code) {
		this.company_code = company_code;
	}
	public String getSchedule_id() {
		return schedule_id;
	}
	public void setSchedule_id(String schedule_id) {
		this.schedule_id = schedule_id;
	}
	public String getRegtime() {
		return regtime;
	}
	public void setRegtime(String regtime) {
		this.regtime = regtime;
	}
	public String getAlarm_address() {
		return alarm_address;
	}
	public void setAlarm_address(String alarm_address) {
		this.alarm_address = alarm_address;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getA_hogi() {
		return a_hogi;
	}
	public void setA_hogi(String a_hogi) {
		this.a_hogi = a_hogi;
	}
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	public String getNewValue() {
		return newValue;
	}
	public void setNewValue(String newValue) {
		this.newValue = newValue;
	}
	public String getRecieve_a() {
		return recieve_a;
	}
	public void setRecieve_a(String recieve_a) {
		this.recieve_a = recieve_a;
	}
	public String getRecieve_b() {
		return recieve_b;
	}
	public void setRecieve_b(String recieve_b) {
		this.recieve_b = recieve_b;
	}
	public String getRecieve_c() {
		return recieve_c;
	}
	public void setRecieve_c(String recieve_c) {
		this.recieve_c = recieve_c;
	}
	public String getRecieve_d() {
		return recieve_d;
	}
	public void setRecieve_d(String recieve_d) {
		this.recieve_d = recieve_d;
	}
	public String getRecieve_e() {
		return recieve_e;
	}
	public void setRecieve_e(String recieve_e) {
		this.recieve_e = recieve_e;
	}
	public String getRecieve_f() {
		return recieve_f;
	}
	public void setRecieve_f(String recieve_f) {
		this.recieve_f = recieve_f;
	}
	public String getRecieve_g() {
		return recieve_g;
	}
	public void setRecieve_g(String recieve_g) {
		this.recieve_g = recieve_g;
	}
	public String getRecieve_h() {
		return recieve_h;
	}
	public void setRecieve_h(String recieve_h) {
		this.recieve_h = recieve_h;
	}
	public String getRecieve_i() {
		return recieve_i;
	}
	public void setRecieve_i(String recieve_i) {
		this.recieve_i = recieve_i;
	}
	public String getRecieve_j() {
		return recieve_j;
	}
	public void setRecieve_j(String recieve_j) {
		this.recieve_j = recieve_j;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public String getUserGroups() {
		return userGroups;
	}
	public void setUserGroups(String userGroups) {
		this.userGroups = userGroups;
	}
	public String getUser_groups() {
		return user_groups;
	}
	public void setUser_groups(String user_groups) {
		this.user_groups = user_groups;
	}
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public Integer getUser_group_id() {
		return user_group_id;
	}
	public void setUser_group_id(Integer user_group_id) {
		this.user_group_id = user_group_id;
	}
	public String getDevice_token() {
		return device_token;
	}
	public void setDevice_token(String device_token) {
		this.device_token = device_token;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getWork_day() {
		return work_day;
	}
	public void setWork_day(String work_day) {
		this.work_day = work_day;
	}
	public String getWork_time() {
		return work_time;
	}
	public void setWork_time(String work_time) {
		this.work_time = work_time;
	}
	public String getUser_company() {
		return user_company;
	}
	public void setUser_company(String user_company) {
		this.user_company = user_company;
	}
	public String getUser_role() {
		return user_role;
	}
	public void setUser_role(String user_role) {
		this.user_role = user_role;
	}
	public String getMessage_yn2() {
		return message_yn2;
	}
	public void setMessage_yn2(String message_yn2) {
		this.message_yn2 = message_yn2;
	}
	public String getUser_level() {
		return user_level;
	}
	public void setUser_level(String user_level) {
		this.user_level = user_level;
	}
	public String getUser_busu() {
		return user_busu;
	}
	public void setUser_busu(String user_busu) {
		this.user_busu = user_busu;
	}
	public String getUser_yn() {
		return user_yn;
	}
	public void setUser_yn(String user_yn) {
		this.user_yn = user_yn;
	}
	public String getSt_day() {
		return st_day;
	}
	public void setSt_day(String st_day) {
		this.st_day = st_day;
	}
	public String getMessage_yn() {
		return message_yn;
	}
	public void setMessage_yn(String message_yn) {
		this.message_yn = message_yn;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public int getUser_code() {
		return user_code;
	}
	public void setUser_code(int user_code) {
		this.user_code = user_code;
	}
	public String getUser_no() {
		return user_no;
	}
	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_buso() {
		return user_buso;
	}
	public void setUser_buso(String user_buso) {
		this.user_buso = user_buso;
	}
	public String getUser_jick() {
		return user_jick;
	}
	public void setUser_jick(String user_jick) {
		this.user_jick = user_jick;
	}
	public String getUser_bigo() {
		return user_bigo;
	}
	public void setUser_bigo(String user_bigo) {
		this.user_bigo = user_bigo;
	}
	public String getUser_jdate() {
		return user_jdate;
	}
	public void setUser_jdate(String user_jdate) {
		this.user_jdate = user_jdate;
	}
	public String getUser_odate() {
		return user_odate;
	}
	public void setUser_odate(String user_odate) {
		this.user_odate = user_odate;
	}
	public String getUser_ret() {
		return user_ret;
	}
	public void setUser_ret(String user_ret) {
		this.user_ret = user_ret;
	}
	public String getUser_seq() {
		return user_seq;
	}
	public void setUser_seq(String user_seq) {
		this.user_seq = user_seq;
	}
	public String getUser_add() {
		return user_add;
	}
	public void setUser_add(String user_add) {
		this.user_add = user_add;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pwd() {
		return user_pwd;
	}
	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_sms() {
		return user_sms;
	}
	public void setUser_sms(String user_sms) {
		this.user_sms = user_sms;
	}
	public String getUser_chigu() {
		return user_chigu;
	}
	public void setUser_chigu(String user_chigu) {
		this.user_chigu = user_chigu;
	}
	public String getUser_chkfac() {
		return user_chkfac;
	}
	public void setUser_chkfac(String user_chkfac) {
		this.user_chkfac = user_chkfac;
	}
	public String getUser_suri() {
		return user_suri;
	}
	public void setUser_suri(String user_suri) {
		this.user_suri = user_suri;
	}
	public String getUser_coilchk() {
		return user_coilchk;
	}
	public void setUser_coilchk(String user_coilchk) {
		this.user_coilchk = user_coilchk;
	}
	public String getUser_plugchk() {
		return user_plugchk;
	}
	public void setUser_plugchk(String user_plugchk) {
		this.user_plugchk = user_plugchk;
	}
	public String getUser_ip() {
		return user_ip;
	}
	public void setUser_ip(String user_ip) {
		this.user_ip = user_ip;
	}
	public int getNotice_code() {
		return notice_code;
	}
	public void setNotice_code(int notice_code) {
		this.notice_code = notice_code;
	}
	public String getNotice_name() {
		return notice_name;
	}
	public void setNotice_name(String notice_name) {
		this.notice_name = notice_name;
	}
	public String getNotice_memo() {
		return notice_memo;
	}
	public void setNotice_memo(String notice_memo) {
		this.notice_memo = notice_memo;
	}
	public String getNotice_user() {
		return notice_user;
	}
	public void setNotice_user(String notice_user) {
		this.notice_user = notice_user;
	}
	public String getNotice_date() {
		return notice_date;
	}
	public void setNotice_date(String notice_date) {
		this.notice_date = notice_date;
	}
	public int getNotice_views() {
		return notice_views;
	}
	public void setNotice_views(int notice_views) {
		this.notice_views = notice_views;
	}
	public String getNotice_dates() {
		return notice_dates;
	}
	public void setNotice_dates(String notice_dates) {
		this.notice_dates = notice_dates;
	}
	public String getNotice_datee() {
		return notice_datee;
	}
	public void setNotice_datee(String notice_datee) {
		this.notice_datee = notice_datee;
	}
}
