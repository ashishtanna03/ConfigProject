package com.service.login;

import org.springframework.security.core.GrantedAuthority;

public class UserGrantedAuthority implements GrantedAuthority {

    /**
     * The Constant serialVersionUID.
     */
    private static final long serialVersionUID = -3786297951121082647L;

    /**
     * The authority.
     */
    private String authority = null;

    /**
     * Instantiates a new user granted authority.
     *
     * @param auth the auth
     */
    public UserGrantedAuthority(String auth) {
        authority = auth;
    }

    /*
     * (non-Javadoc)
     *
     * @see org.springframework.security.core.GrantedAuthority#getAuthority()
     */
    public String getAuthority() {
        return authority;
    }

}