package com.aishang.shopback.service.Impl;

import com.aishang.shopback.dao.IUserDao;
import com.aishang.shopback.po.User;
import com.aishang.shopback.service.IUserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class UserService implements IUserService {
    @Resource
    private IUserDao userDao;

    /**
     * 验证用户
     * @param user
     * @return
     */
    @Override
    public User findUser(User user) {
        return userDao.findUser(user);
    }
}
