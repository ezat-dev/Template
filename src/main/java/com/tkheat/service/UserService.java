package com.tkheat.service;

import java.util.List;

import com.tkheat.domain.Permission;
import com.tkheat.domain.UserMenu;
import com.tkheat.domain.Users;

public interface UserService {

	Users userMenuSelectCount(Users users);

	List<Users> usersMenuOkSelect(Users users);

	void userMenuDelete(Users users);

	void userMenuClick(Users users);

	Users getLoginUser(Users users);

	//메뉴를 선택했을 때 사용자가 선택한 메뉴를 이름, 링크로 분리해서 보여주는 메서드
	public List<Users> menuList(Users users);

	Permission userLoginPermission(Users loginUser);

	void userLoginMenuSave(UserMenu userMenu);

	List<UserMenu> userLoginMenuList(UserMenu userMenu);

	void userLoginMenuRemove(UserMenu userMenu);

	void userLoginHisSave(Users users);	
	
	void userInsertInsert(Users users);
	Users userDuplicateCheck(Users users);
	List<Users> selectUserList(Users users);
	boolean insertWorkTime(Users users);
	boolean updateMessage(Users users);
	boolean deleteWorkTime(Users users);
	boolean deviceTokenUpdate(Users users);
	List<Users> selectUserModalList(Users users);
	List<Users> getAlarmUser1(Users users);
	List<Users> getAlarmUser2(Users users);
	boolean insertGroup(Users users);
	boolean deleteGroup(Users users);
	boolean updateGroupTime(Users users);
	List<Users> getGroupUser(Users users);
	boolean insertGroupSchedule(Users users);
	List<Users> getGroupScheduleList(Users users);
	boolean updateRecieveAlarm(Users users);
	List<Users> getGroupList(Users users);
	List<Users> sendAlarmList(Users users);
	boolean updateAlarmSend(Users users);
	boolean deleteSchedule(Users users);
	boolean updateUser(Users users);
	boolean deleteUser(Users users);
	boolean updateGroupSchedule(Users users);
	List<Users> getGroupName(Users users);
	boolean updateGroupName(Users users);
	boolean deleteRecieveAlarm(Users users);
	List<Users> getGroupRecieveAlarm(Users users);
	boolean insertCompany(Users users);
	boolean insertCompanyAdmin(Users users);
	String selectNewCompanyCode(Users users);
	Users selectNewCompany(Users users);
	boolean insertNewGroup(Users users);
	boolean insertNewAlarmGroup(Users users);
	List<Users> getCompanyNames(Users users);
	boolean insertAlarmData(List<Users> datas);
}
