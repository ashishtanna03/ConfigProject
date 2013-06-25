package com.dao.login;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;

public class CustomUser implements Serializable, UserDetails {

    private static final long serialVersionUID = 1201392234549297485L;
    private long id;
    private String password;
    private String username;
    private GrantedAuthority[] authorities = null;

    /**
     * Instantiates a new custom user.
     *
     * @param username    the username
     * @param password    the password
     * @param authorities the authorities
     */
    public CustomUser(String username, String password, GrantedAuthority[] authorities) {
//
        this.password = password;
        this.username = username;
        this.authorities = authorities;
    }

    public Collection<GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();
        for (int i = 0; i < authorities.length; i++) {
            auth.add(authorities[i]);
        }
        return auth;
    }

    public String getPassword() {
        return this.password;
    }

    public String getUsername() {
        return this.username;
    }

    /**
     * For convenience the below methods return all true; In a real application it is not desired, however.
     */
    public boolean isAccountNonExpired() {
        return true;
    }

    public boolean isAccountNonLocked() {
        return true;
    }

    public boolean isCredentialsNonExpired() {
        return true;
    }

    public boolean isEnabled() {
        return true;
    }
}