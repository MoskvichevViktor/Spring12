package shop.services;

import shop.entities.Role;
import shop.entities.User;
import shop.repositories.RoleRepository;
import shop.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import java.security.Principal;
import java.util.Collection;
import java.util.Random;
import java.util.stream.Collectors;

@Component
public class UserService implements UserDetailsService {
    @Autowired
    UserRepository userRepository;

    @Autowired
    RoleRepository roleRepository;

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        User user = userRepository.getFirstByLogin(s);
        if(user == null || !user.getEnabled()){
            throw new UsernameNotFoundException("Invalid username or password");
        }
        return new org.springframework.security.core.userdetails.User(user.getLogin(), user.getPassword(), mapRolesToAuthorities(user.getRoles()));
    }

    private Collection<? extends GrantedAuthority> mapRolesToAuthorities(Collection<Role> roles) {
        return roles.stream()
                .map(
                        role -> new SimpleGrantedAuthority(role.getName())
                )
                .collect(Collectors.toList());
    }

    // Creates disabled anonymous user for ordering without registration
    public User createAnonymous(){
        User u = new User(
                "anon" + System.currentTimeMillis(),
                String.valueOf(new Random().nextInt(Integer.MAX_VALUE)),
                "1@2.3",
                "anon",
                "anon",
                "1111111",
                "addr");
        u.setEnabled(false);
        return userRepository.save(u);
    }

    public User getCurrentUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String name = ((org.springframework.security.core.userdetails.User) auth.getPrincipal()).getUsername();
        return this.userRepository.getFirstByLogin(name);
    }
}
