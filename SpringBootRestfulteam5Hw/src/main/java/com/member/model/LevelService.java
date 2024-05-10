package com.member.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class LevelService {

	@Autowired
	public LevelRepository levRepos;
	/*------------------------------------------------基本資料操作-----------------------------------------------------*/

	/* 新增等級 */
	public boolean insert(LevelBean LeBean) {
		try {
			levRepos.save(LeBean);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	/* 更新等級 */
	public boolean update(LevelBean LeBean) {
		try {
			levRepos.save(LeBean);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	/* 刪除等級 */
	public void deleteById(Integer id) {
		levRepos.deleteById(id);
	}

	/* 查詢等級 */
	public List<LevelBean> getAll() {
		return levRepos.findAll();
	}

}
