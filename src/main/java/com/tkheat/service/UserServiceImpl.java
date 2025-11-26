package com.tkheat.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tkheat.dao.UserDao;
import com.tkheat.domain.Permission;
import com.tkheat.domain.UserMenu;
import com.tkheat.domain.Users;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	private UserDao userDao;

	@Override
	public Users userMenuSelectCount(Users users) {
		return userDao.userMenuSelectCount(users);
	}

	@Override
	public List<Users> usersMenuOkSelect(Users users) {
		return userDao.usersMenuOkSelect(users);
	}

	@Override
	public void userMenuDelete(Users users) {
		userDao.userMenuDelete(users);
	}

	@Override
	public void userMenuClick(Users users) {
		userDao.userMenuClick(users);
	}

	@Override
	public Users getLoginUser(Users users) {
		return userDao.getLoginUser(users);
	}
	
	//_로 구분해서 사용자가 선택한 메뉴의 이름과 링크를 분리
	public List<Users> menuList(Users users){
		List<Users> tabList = usersMenuOkSelect(users);
		List<Users> menuList = new ArrayList<>();
		for(int i=0; i<tabList.size(); i++) {
			Users tempMap = new Users();
			/*
//			String[] temp = tabList.get(i).getMenu_name().split("_");
//			String name = temp[0];
//			String link = temp[1];
			
			String[] tempLink = link.split("/");

			tempMap.setMenu_name(name);
			tempMap.setMenu_url(link);
			tempMap.setTab_id(tempLink[1]+tempLink[2]); 
			tempMap.setTab_idx(i);
*/
			menuList.add(tempMap);
		}
		
		
		return menuList;
	}

	@Override
	public Permission userLoginPermission(Users loginUser) {
		return userDao.userLoginPermission(loginUser);
	}

	@Override
	public void userLoginMenuSave(UserMenu userMenu) {
		userDao.userLoginMenuSave(userMenu);
	}

	@Override
	public List<UserMenu> userLoginMenuList(UserMenu userMenu) {
		return userDao.userLoginMenuList(userMenu);
	}

	@Override
	public void userLoginMenuRemove(UserMenu userMenu) {
		userDao.userLoginMenuRemove(userMenu);
	}

	@Override
	public void userLoginHisSave(Users users) {
		userDao.userLoginHisSave(users);
	}
	
    @Override
    public void userInsertInsert(Users users) {
        userDao.userInsertInsert(users);
    }
    @Override
    public Users userDuplicateCheck(Users users) {
        return userDao.userDuplicateCheck(users);
    }
    @Override
    public List<Users> selectUserList(Users users) {
        return userDao.selectUserList(users);
    }

	@Override
	public boolean insertWorkTime(Users users) {
		return userDao.insertWorkTime(users);
	}
	@Override
	public boolean updateMessage(Users users) {
		return userDao.updateMessage(users);
	}
	@Override
	public boolean deleteWorkTime(Users users) {
		return userDao.deleteWorkTime(users);
	}
	@Override
	public boolean deviceTokenUpdate(Users users) {
		return userDao.deviceTokenUpdate(users);
	}
	@Override
	public List<Users> selectUserModalList(Users users) {
		return userDao.selectUserModalList(users);
	}
	@Override
	public List<Users> getAlarmUser1(Users users) {
		return userDao.getAlarmUser1(users);
	}
	@Override
	public List<Users> getAlarmUser2(Users users) {
		return userDao.getAlarmUser2(users);
	}

	@Override
	public boolean insertGroup(Users users) {
		return userDao.insertGroup(users);
	}

	@Override
	public boolean deleteGroup(Users users) {
		return userDao.deleteGroup(users);
	}

	@Override
	public boolean updateGroupTime(Users users) {
		return userDao.updateGroupTime(users);
	}

	@Override
	public List<Users> getGroupUser(Users users) {
		return userDao.getGroupUser(users);
	}

	@Override
	public boolean insertGroupSchedule(Users users) {
		return userDao.insertGroupSchedule(users);
	}
	@Override
	public List<Users> getGroupScheduleList(Users users) {
		return userDao.getGroupScheduleList(users);
	}
	@Override
	public boolean updateRecieveAlarm(Users users) {
		return userDao.updateRecieveAlarm(users);
	}
	@Override
	public List<Users> getGroupList(Users users) {
		return userDao.getGroupList(users);
	}

	@Override
	public List<Users> sendAlarmList(Users users) {
		return userDao.sendAlarmList(users);
	}
	@Override
	public boolean updateAlarmSend(Users users) {
		return userDao.updateAlarmSend(users);
	}
	@Override
	public boolean deleteSchedule(Users users) {
		return userDao.deleteSchedule(users);
	}
	@Override
	public boolean updateUser(Users users) {
		return userDao.updateUser(users);
	}
	@Override
	public boolean deleteUser(Users users) {
		return userDao.deleteUser(users);
	}
	@Override
	public boolean updateGroupSchedule(Users users) {
		return userDao.updateGroupSchedule(users);
	}
	@Override
	public List<Users> getGroupName(Users users) {
		return userDao.getGroupName(users);
	}
	@Override
	public boolean updateGroupName(Users users) {
		return userDao.updateGroupName(users);
	}
	@Override
	public boolean deleteRecieveAlarm(Users users) {
		return userDao.deleteRecieveAlarm(users);
	}
	@Override
	public List<Users> getGroupRecieveAlarm(Users users) {
		return userDao.getGroupRecieveAlarm(users);
	}
	@Override
	public boolean insertCompany(Users users) {
		return userDao.insertCompany(users);
	}
	@Override
	public boolean insertCompanyAdmin(Users users) {
		return userDao.insertCompanyAdmin(users);
	}
	@Override
	public String selectNewCompanyCode(Users users) {
		return userDao.selectNewCompanyCode(users);
	}
	@Override
	public Users selectNewCompany(Users users) {
		return userDao.selectNewCompany(users);
	}
	@Override
	public boolean insertNewGroup(Users users) {
		return userDao.insertNewGroup(users);
	}
	@Override
	public boolean insertNewAlarmGroup(Users users) {
		return userDao.insertNewAlarmGroup(users);
	}
	@Override
	public List<Users> getCompanyNames(Users users) {
		return userDao.getCompanyNames(users);
	}
	@Override
	public boolean insertAlarmData(List<Users> datas) {
		return userDao.insertAlarmData(datas);
	}
}
