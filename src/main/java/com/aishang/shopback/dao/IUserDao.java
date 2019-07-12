package com.aishang.shopback.dao;

import com.aishang.shopback.po.User;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IUserDao {
/**
     * 验证用户
     * @param user
     * @return
     */
    User findUser(User user);
}
