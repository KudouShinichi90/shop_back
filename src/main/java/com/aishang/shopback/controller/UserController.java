package com.aishang.shopback.controller;

import com.aishang.shopback.po.User;
import com.aishang.shopback.service.IUserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

@RequestMapping("/user")
@Controller
public class UserController {
    @Resource
    private IUserService userService;
    @Resource
    private HttpSession session;

    /**
     * login
     */
    @RequestMapping("/login")
    public String login() {
        return "login";
    }

    /**
     * 验证用户
     */
    @RequestMapping("/dologin")
    public String doLogin(User user, Model model, String remember, HttpServletResponse response) throws UnsupportedEncodingException {
        // 判断是否存在此用户
        User u = userService. findUser(user);
        if (u == null) {
            model.addAttribute("errlogin", "用户名、密码错误！");
            model.addAttribute("errname", user.getUsername());
            model.addAttribute("errpass", user.getPassword());
            return "login";
        }
        // 存session、Cookie
        session.setAttribute("user", u);
        String username = URLEncoder.encode(u.getUsername(), "utf-8");
        String password = URLEncoder.encode(u.getPassword(), "utf-8");
        Cookie cookie1 = new Cookie("backname", username);
        Cookie cookie2 = new Cookie("backpass", password);
        if (remember != null) {
            cookie1.setMaxAge(60 * 60 * 24 * 7);
            cookie2.setMaxAge(60 * 60 * 24 * 7);
        } else {
            cookie1.setMaxAge(0);
            cookie2.setMaxAge(0);
        }
        cookie1.setPath("/");
        cookie2.setPath("/");
        response.addCookie(cookie1);
        response.addCookie(cookie2);
        return "main";
    }

    @RequestMapping("/main")
    public String main() { return "main";}
}
