package com.aishang.shopback.service;

import com.aishang.shopback.po.User;

/**
 * 验证用户
 */
public interface IUserService {
    User findUser(User user);
}
