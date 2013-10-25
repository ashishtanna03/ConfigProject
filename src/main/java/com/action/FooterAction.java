package com.action;

import com.opensymphony.xwork2.ActionSupport;
import com.pojo.custom.LendDetails;
import com.pojo.hibernate.BookInfo;
import com.pojo.hibernate.Lend;
import com.service.BookService;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 8/28/13
 * Time: 2:39 PM
 * To change this template use File | Settings | File Templates.
 */
public class FooterAction extends ActionSupport {

    private BookService bookService;

    private List<LendDetails> lendDetailsList = new ArrayList<LendDetails>(0);

    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    public List<LendDetails> getLendDetailsList() {
        return lendDetailsList;
    }

    public String getRecentlySharedBooks() {

        Integer counter=0;

        for(BookInfo book : bookService.getRecentlySharedBooks()) {
            LendDetails lendDetails = new LendDetails();
            lendDetails.setBookId(book.getBookId());
            lendDetails.setBookTitle(book.getBookTitle());
            lendDetails.setBookImgUrl(book.getBookImgUrl());

            //getting details of lend with lowest price
            for (Lend lend : book.getLendsByBookId()) {
                if(lend.getLendStatus()!=1) {
                    lendDetails.setSharingPrice(lend.getSharingPrice());
                    lendDetails.setUserId(lend.getUserInfoByUserId().getUserId());
                    lendDetails.setUserName(lend.getUserInfoByUserId().getFirstName() + " " + lend.getUserInfoByUserId().getLastName());

                    break;
                }
            }

            lendDetailsList.add(lendDetails);
            counter++;
            if(counter>=8)
                break;
        }

        return SUCCESS;
    }

}
