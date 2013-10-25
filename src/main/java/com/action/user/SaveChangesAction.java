package com.action.user;

import com.opensymphony.xwork2.ActionSupport;
import com.pojo.hibernate.Genres;
import com.pojo.hibernate.UserInfo;
import com.service.AuthorService;
import com.service.UserService;
import org.springframework.security.core.context.SecurityContextHolder;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/17/13
 * Time: 6:38 PM
 * To change this template use File | Settings | File Templates.
 */
public class SaveChangesAction extends ActionSupport {

    private String firstName;
    private String lastName;
    private String userGender;
    private Date userBirthdate;
    private String userCity;
    private Integer userPostalCode;
    private String userOccupation;
    private String userQualification;
    private List<Integer> userFavGenres;
    private String userWebsite;
    private String userAddress;
    private String userContact;

    private UserService userService;
    private AuthorService authorService;

    private String result;

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setUserGender(String userGender) {
        this.userGender = userGender;
    }

    public void setUserBirthdate(String userBirthdate) {
        try{
            this.userBirthdate = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(userBirthdate);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public void setUserCity(String userCity) {
        this.userCity = userCity;
    }

    public void setUserPostalCode(Integer userPostalCode) {
        this.userPostalCode = userPostalCode;
    }

    public void setUserOccupation(String userOccupation) {
        this.userOccupation = userOccupation;
    }

    public void setUserQualification(String userQualification) {
        this.userQualification = userQualification;
    }

    public void setUserFavGenres(List<Integer> userFavGenres) {
        this.userFavGenres = userFavGenres;
    }

    public void setUserWebsite(String userWebsite) {
        this.userWebsite = userWebsite;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    public void setUserContact(String userContact) {
        this.userContact = userContact;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setAuthorService(AuthorService authorService) {
        this.authorService = authorService;
    }

    public String getResult() {
        return result;
    }

    public String saveProfileChanges(){
        UserInfo userInfo = userService.getUserById(SecurityContextHolder.getContext().getAuthentication().getName());
        userInfo.setFirstName(firstName);
        userInfo.setLastName(lastName);
        userInfo.setUserGender(userGender);
        userInfo.setUserBirthdate(userBirthdate);
        userInfo.setUserCity(userCity);
        userInfo.setUserPostalCode(userPostalCode);
        userInfo.setUserOccupation(userOccupation);
        userInfo.setUserQualification(userQualification);
        userInfo.setUserWebsite(userWebsite);
        userInfo.setUserContact(userContact);
        userInfo.setUserAddress(userAddress);

        List<Genres> userGenres = new ArrayList<Genres>(0);

        for(Integer genreId : userFavGenres) {
            userGenres.add(authorService.getGenreById(genreId));
        }

        if(userService.update(userInfo, userGenres)){
            result=SUCCESS;
        }
        else{
            result=ERROR;
        }
        return SUCCESS;

    }

}
