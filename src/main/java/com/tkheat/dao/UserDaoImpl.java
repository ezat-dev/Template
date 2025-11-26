package com.tkheat.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.tkheat.domain.Permission;
import com.tkheat.domain.UserMenu;
import com.tkheat.domain.Users;

@Repository
public class UserDaoImpl implements UserDao{

	@Resource(name="session")
	private SqlSession sqlSession;
	
	@Override
	public Users userMenuSelectCount(Users users) {
		return sqlSession.selectOne("users.userMenuSelectCount",users);
	}

	@Override
	public List<Users> usersMenuOkSelect(Users users) {
		return sqlSession.selectList("users.usersMenuOkSelect",users);
	}

	@Override
	public void userMenuDelete(Users users) {
		sqlSession.delete("users.userMenuDelete", users);
	}

	@Override
	public void userMenuClick(Users users) {
		sqlSession.insert("users.userMenuClick", users);
	}

	@Override
	public Users getLoginUser(Users users) {
		return sqlSession.selectOne("users.getLoginUser", users);
	}

	@Override
	public Permission userLoginPermission(Users loginUser) {
		return sqlSession.selectOne("users.userLoginPermission", loginUser);
	}

	@Override
	public List<UserMenu> userLoginMenuList(UserMenu userMenu) {
		
		//4. 해당 유저의 메뉴리스트 조회		
		List<UserMenu> userMenuList = sqlSession.selectList("users.userMenuList",userMenu);
		
		return userMenuList;
	}

	@Override
	public void userLoginMenuSave(UserMenu userMenu) {

		int menuValue = 0;
		String checkValue = "";
		
		//1. 해당 유저의 메뉴카운트가 10개인지		
		menuValue = sqlSession.selectOne("users.userMenuCount",userMenu);
		//2. 해당 유저에 선택한 메뉴가 Y이면서 있는지
		checkValue = sqlSession.selectOne("users.userMenuCheck",userMenu);
		//3. 1,2번 둘다 해당안될경우 저장
		if(menuValue < 10) {
			if(checkValue == null) {
				sqlSession.insert("users.userLoginMenuSave",userMenu);				
			}else if("N".equals(checkValue)) {
				sqlSession.update("users.userLoginMenuUpdate",userMenu);
			}
		}
	}

	@Override
	public void userLoginMenuRemove(UserMenu userMenu) {
		sqlSession.update("users.userLoginMenuRemove",userMenu);
	}

	@Override
	public void userLoginHisSave(Users users) {
		sqlSession.insert("users.userLoginHisSave",users);
	}
	
	@Override
	public void userInsertInsert(Users users) {
		sqlSession.insert("users.userInsertInsert",users);
	}
	@Override
	public Users userDuplicateCheck(Users users) {
		return sqlSession.selectOne("users.userDuplicateCheck",users);
	}
	@Override
	public List<Users> selectUserList(Users users) {
		return sqlSession.selectList("users.selectUserList",users);
	}

	@Override
	public boolean insertWorkTime(Users users) {
		int result = sqlSession.insert("users.insertWorkTime", users);
		if(result <= 0) {
			return false;
		}
		return true;
	}
	@Override
	public boolean updateMessage(Users users) {
		int result = sqlSession.update("users.updateMessage", users);
		if(result <= 0) {
			return false;
		}
		return true;
	}
	@Override
	public boolean deleteWorkTime(Users users) {
		int result = sqlSession.delete("users.deleteWorkTime", users);
		if(result <= 0) {
			return false;
		}
		return true;
	}
	@Override
	public boolean deviceTokenUpdate(Users users) {
		int result = sqlSession.delete("users.deviceTokenUpdate", users);
		if(result <= 0) {
			return false;
		}
		return true;
	}
	@Override
	public List<Users> selectUserModalList(Users users) {
		return sqlSession.selectList("users.selectUserModalList",users);
	}
	@Override
	public List<Users> getAlarmUser1(Users users) {
		return sqlSession.selectList("users.getAlarmUser1",users);
	}
	@Override
	public List<Users> getAlarmUser2(Users users) {
		return sqlSession.selectList("users.getAlarmUser2",users);
	}

	@Override
	public boolean insertGroup(Users users) {
		int result = sqlSession.insert("users.insertGroup", users);
		if(result <= 0) {
			return false;
		}
		return true;
	}

	@Override
	public boolean deleteGroup(Users users) {
		int result = sqlSession.delete("users.deleteGroup", users);
		if(result <= 0) {
			return false;
		}
		return true;
	}

	@Override
	public boolean updateGroupTime(Users users) {
		int result = sqlSession.update("users.updateGroupTime", users);
		if(result <= 0) {
			return false;
		}
		return true;
	}

	@Override
	public List<Users> getGroupUser(Users users) {
		return sqlSession.selectList("users.getGroupUser",users);
	}

	@Override
	public boolean insertGroupSchedule(Users users) {
		int result = sqlSession.insert("users.insertGroupSchedule", users);
		if(result <= 0) {
			return false;
		}
		return true;
	}
	@Override
	public List<Users> getGroupScheduleList(Users users) {
		return sqlSession.selectList("users.getGroupScheduleList",users);
	}
	@Override
	public boolean updateRecieveAlarm(Users users) {
		int result = sqlSession.update("users.updateRecieveAlarm", users);
		if(result <= 0) {
			return false;
		}
		return true;
	}
	@Override
	public List<Users> getGroupList(Users users) {
		return sqlSession.selectList("users.getGroupList",users);
	}
	@Override
	public List<Users> sendAlarmList(Users users) {
		return sqlSession.selectList("users.sendAlarmList",users);
	}
	@Override
	public boolean updateAlarmSend(Users users) {
		int result = sqlSession.update("users.updateAlarmSend", users);
		if(result <= 0) {
			return false;
		}
		return true;
	}
	@Override
	public boolean deleteSchedule(Users users) {
		int result = sqlSession.delete("users.deleteSchedule", users);
		if(result <= 0) {
			return false;
		}
		return true;
	}
	@Override
	public boolean updateUser(Users users) {
		int result = sqlSession.update("users.updateUser", users);
		if(result <= 0) {
			return false;
		}
		return true;
	}
	@Override
	public boolean deleteUser(Users users) {
		int result = sqlSession.delete("users.deleteUser", users);
		if(result <= 0) {
			return false;
		}
		return true;
	}
	@Override
	public boolean updateGroupSchedule(Users users) {
		int result = sqlSession.update("users.updateGroupSchedule", users);
		if(result <= 0) {
			return false;
		}
		return true;
	}
	@Override
	public List<Users> getGroupName(Users users) {
		return sqlSession.selectList("users.getGroupName",users);
	}
	@Override
	public boolean updateGroupName(Users users) {
		int result = sqlSession.update("users.updateGroupName", users);
		if(result <= 0) {
			return false;
		}
		return true;
	}
	@Override
	public boolean deleteRecieveAlarm(Users users) {
		int result = sqlSession.delete("users.deleteRecieveAlarm", users);
		if(result <= 0) {
			return false;
		}
		return true;
	}
	@Override
	public List<Users> getGroupRecieveAlarm(Users users) {
		return sqlSession.selectList("users.getGroupRecieveAlarm",users);
	}
	@Override
	public boolean insertCompany(Users users) {
		int result = sqlSession.insert("users.insertCompany", users);
		if(result <= 0) {
			return false;
		}
		return true;
	}
	@Override
	public boolean insertCompanyAdmin(Users users) {
		int result = sqlSession.insert("users.insertCompanyAdmin", users);
		if(result <= 0) {
			return false;
		}
		return true;
	}
	@Override
	public String selectNewCompanyCode(Users users) {
		return sqlSession.selectOne("users.selectNewCompanyCode",users);
	}
	@Override
	public Users selectNewCompany(Users users) {
		return sqlSession.selectOne("users.selectNewCompany",users);
	}
	@Override
	public boolean insertNewGroup(Users users) {
		int result = sqlSession.insert("users.insertNewGroup", users);
		if(result <= 0) {
			return false;
		}
		return true;
	}
	@Override
	public boolean insertNewAlarmGroup(Users users) {
		int result = sqlSession.insert("users.insertNewAlarmGroup", users);
		if(result <= 0) {
			return false;
		}
		return true;
	}
	@Override
	public List<Users> getCompanyNames(Users users) {
		return sqlSession.selectList("users.getCompanyNames",users);
	}
	@Override
	public boolean insertAlarmData(List<Users> datas) {
		int result = sqlSession.insert("users.insertAlarmData", datas);
		if(result <= 0) {
			return false;
		}
		return true;
	}
}
