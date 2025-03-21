package com.montblanc.montblanc.Repositories;

import com.montblanc.montblanc.Clases.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByLogin(String login);
    User findByPassword(String password);
}
