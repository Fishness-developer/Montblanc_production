package com.montblanc.montblanc.Controllers;

import com.montblanc.montblanc.Clases.User;
import com.montblanc.montblanc.Repositories.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {
    @Autowired
    UserRepository userRepository;

    @PostMapping("/login")
    public String login(@RequestParam("login") String login,
                        @RequestParam("password") String password,
                        Model model, HttpSession session) {
        User user = userRepository.findByLogin(login);
        User user1 = userRepository.findByPassword(password);
        if (user != null && user.getPassword().equals(password) && user1 != null && user1.getLogin().equals(login)) {
            session.setAttribute("user", user);
            model.addAttribute("login", user.getLogin());
            return "redirect:/adminPanel";
        } else {
            model.addAttribute("error", "Incorrect login or password");
            return "/WEB-INF/views/index.jsp";
        }
    }
}
