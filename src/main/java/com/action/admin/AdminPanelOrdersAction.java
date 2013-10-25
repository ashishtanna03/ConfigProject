package com.action.admin;

import com.EmailService;
import com.opensymphony.xwork2.ActionSupport;
import com.pojo.hibernate.BorrowBook;
import com.pojo.hibernate.OrderInfo;
import com.pojo.hibernate.UserInfo;
import com.service.BorrowService;
import com.service.LendService;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 9/5/13
 * Time: 6:08 PM
 * To change this template use File | Settings | File Templates.
 */
public class AdminPanelOrdersAction extends ActionSupport {

    private BorrowService borrowService;
    private EmailService emailService;

    public void setBorrowService(BorrowService borrowService) {
        this.borrowService = borrowService;
    }

    public void setEmailService(EmailService emailService) {
        this.emailService = emailService;
    }

    private List<BorrowBook> toBePickedUpList;

    public List<BorrowBook> getToBePickedUpList() {
        return toBePickedUpList;
    }

    public String toBePickedUpList() {

        toBePickedUpList = borrowService.getListOfToBePickedUp();

        return SUCCESS;
    }

    private List<BorrowBook> inPickUpProcessList;

    public List<BorrowBook> getInPickUpProcessList() {
        return inPickUpProcessList;
    }

    public String inPickUpProcessList() {

        inPickUpProcessList = borrowService.getListOfInPickUpProcess();

        return SUCCESS;
    }

    private List<Integer> selectedBorrowIds;

    private String result;

    public void setSelectedBorrowIds(List<Integer> selectedBorrowIds) {
        this.selectedBorrowIds = selectedBorrowIds;
    }

    public String getResult() {
        return result;
    }

    public String markSelectedAsPickedUp() {
        List<BorrowBook> selectedBorrowBooks = new ArrayList<BorrowBook>(0);
        for (Integer borrowId : selectedBorrowIds) {
            BorrowBook borrowBook = borrowService.getBorrowBookById(borrowId);
            selectedBorrowBooks.add(borrowBook);
        }
        if(borrowService.markSelectedAsPickedUp(selectedBorrowBooks)) {
            result="success";

            //sending mail to the sharer that his book got picked up
            String fromAddress = "notifications@readershive.com";
            String toName = null;
            String toAddress = null;
            String mailSubject = "Thank you for sharing your book";
            String mailMessage = null;
            for (BorrowBook borrowBook : selectedBorrowBooks) {
                UserInfo userInfo = borrowBook.getLendByLendId().getUserInfoByUserId();
                toName = userInfo.getFirstName()+" "+userInfo.getLastName();
                toAddress = userInfo.getLoginInfoByEmailId().getEmailId();
                mailMessage = "We have picked up the book \""+borrowBook.getBookInfoByBookId().getBookTitle()+"\" shared by you. Thank you for sharing your book with Readers' Hive Members. " +
                        "If you have any problem regarding the pick-up, you can contact us. Your Pick-up id is <b>"+borrowBook.getLendByLendId().getLendId()+"</b>." +
                        "<br/>And, we have transferred the "+borrowBook.getLendByLendId().getSharingPrice()+" points to your account." +
                        "<br/>Now, your current balance is <b>"+userInfo.getUserBalance()+"</b> Points.";
                emailService.sendEmail(fromAddress, mailSubject, mailMessage, toName, toAddress);
            }
        }
        else
            result="error";
        return SUCCESS;
    }

    public String markSelectedAsNotAvailable() {
        List<BorrowBook> selectedBorrowBooks = new ArrayList<BorrowBook>(0);
        for (Integer borrowId : selectedBorrowIds) {
            BorrowBook borrowBook = borrowService.getBorrowBookById(borrowId);
            selectedBorrowBooks.add(borrowBook);
        }
        if(borrowService.markSelectedAsNotAvailable(selectedBorrowBooks)) {
            result="success";

            String fromAddress = "notifications@readershive.com";
            String toName = null;
            String toAddress = null;
            String mailSubject = null;
            String mailMessage = null;

            for(BorrowBook borrowBook : selectedBorrowBooks) {

                //sending mail to buyer that the book he bought is not available
                UserInfo buyer = borrowBook.getUserInfoByUserId();
                toName = buyer.getFirstName()+" "+buyer.getLastName();
                toAddress = buyer.getLoginInfoByEmailId().getEmailId();
                mailSubject = "The book you ordered is not available";
                mailMessage = "The book \""+borrowBook.getBookInfoByBookId().getBookTitle()+"\" which you ordered is not available now. " +
                        "The user - who shared the book, might not have the book with him/her right now or he/she might not want to share his/her book now." +
                        "<br/>We have added the "+borrowBook.getLendByLendId().getSharingPrice()+" points back to your account. We apologize for any inconvenience this may have caused to you. ";
                emailService.sendEmail(fromAddress, mailSubject, mailMessage, toName, toAddress);

                //sending mail to buyer if all books of the order are not available
                Boolean allNotAvail = true;
                for(BorrowBook orderBook : borrowBook.getOrderInfoByOrderId().getBorrowBooksesByOrderId()) {
                    if (orderBook.getBorrowStatus()!=0) {
                        allNotAvail=false;
                    }
                }
                if (allNotAvail) {
                    mailSubject = "Your order has no books available";
                    mailMessage = "Your order has no books available. So, do not expect any courier from our side." +
                            "<br/>The user(s) - who shared the book, might not have the book with him/her right now or he/she might not want to share his/her book now." +
                            "<br/>We have added the points back to your account. We apologize for any inconvenience this may have caused to you.";
                    emailService.sendEmail(fromAddress, mailSubject, mailMessage, toName, toAddress);
                }

                //sending mail to the sharer that we didn't get the book
                UserInfo sharer = borrowBook.getLendByLendId().getUserInfoByUserId();
                toName = sharer.getFirstName()+" "+sharer.getLastName();
                toAddress = sharer.getLoginInfoByEmailId().getEmailId();
                mailSubject = "We didn't get your Book";
                mailMessage = "It seems that the book \""+borrowBook.getBookInfoByBookId().getBookTitle()+"\" is not available with you right now. So, we have removed it from the available list. But, you can re-share it when you have it.";
                emailService.sendEmail(fromAddress, mailSubject, mailMessage, toName, toAddress);
            }
        }
        else
            result="error";
        return SUCCESS;
    }

    private List<BorrowBook> pickUpOrders;

    public List<BorrowBook> getPickUpOrders() {
        return pickUpOrders;
    }

    public String printPickUpList() {

        pickUpOrders = borrowService.printAndGetPickUpOrders();

        String fromAddress = "notifications@readershive.com";
        String toName = null;
        String toAddress = null;
        String mailSubject = null;
        String mailMessage = null;

        for(BorrowBook borrowBook : pickUpOrders) {

            //sending mail to sharer to keep the shaed book ready
            UserInfo sharer = borrowBook.getLendByLendId().getUserInfoByUserId();
            toName = sharer.getFirstName()+" "+sharer.getLastName();
            toAddress = sharer.getLoginInfoByEmailId().getEmailId();
            mailSubject = "Keep your Book ready";
            mailMessage = "Congratulations, the book you shared,  \""+borrowBook.getBookInfoByBookId().getBookTitle()+"\", is bought by a Readers' Hive member. " +
                    "<br/>We will pick-up the book from the address you have given in 2-3 days, so we request you to keep the book ready." +
                    "<br/>As soon as we get your book, we will transfer the respective points to your account." +
                    "<br/><br/><br/>The address for pick-up :" +
                    "<br/>"+sharer.getUserAddress();
            emailService.sendEmail(fromAddress, mailSubject, mailMessage, toName, toAddress);
        }
        return SUCCESS;
    }

    private List<OrderInfo> pickedUpList;

    public List<OrderInfo> getPickedUpList() {
        return pickedUpList;
    }

    public String pickedUpList() {

        Boolean allPickedUp;
        Boolean allNotAvail;
        pickedUpList = new ArrayList<OrderInfo>(0);

        for(OrderInfo orderInfo : borrowService.getListOfPickedUp()) {
            allPickedUp=true;
            allNotAvail=true;
            for(BorrowBook borrowBook : orderInfo.getBorrowBooksesByOrderId()) {
                if(borrowBook.getBorrowStatus()!=3 && borrowBook.getBorrowStatus()!=0) {
                    allPickedUp=false; //adding only those orders in which all books are either picked up or are not available
                } else if(borrowBook.getBorrowStatus()==3) {
                    allNotAvail = false; //adding only those orders in which atleast a single book have status = 3 (picked up)
                }
            }

            //if all books are picked up then add order into the o/p list
            if(allPickedUp && !allNotAvail) {
                pickedUpList.add(orderInfo);
            }
        }

        return SUCCESS;
    }

    private List<OrderInfo> deliveryOrders;

    public List<OrderInfo> getDeliveryOrders() {
        return deliveryOrders;
    }

    public String printDeliveryList() {

        deliveryOrders = borrowService.printAndGetDeliveryOrders();

        String fromAddress = "notifications@readershive.com";
        String toName = null;
        String toAddress = null;
        String mailSubject = null;
        String mailMessage = null;

        for(OrderInfo orderInfo : deliveryOrders) {

            //sending mail to buyer that his bought books are getting shipped
            UserInfo buyer = orderInfo.getUserInfoByBuyerId();
            toName = buyer.getFirstName()+" "+buyer.getLastName();
            toAddress = buyer.getLoginInfoByEmailId().getEmailId();
            mailSubject = "Your order has been shipped";
            mailMessage = "The books you ordered have been shipped. You will receive the books in 2-3 days.";
            emailService.sendEmail(fromAddress, mailSubject, mailMessage, toName, toAddress);
        }

        return SUCCESS;
    }

    private List<OrderInfo> inDeliveryProcessList;

    public List<OrderInfo> getInDeliveryProcessList() {
        return inDeliveryProcessList;
    }

    public String inDeliveryProcessList() {

        inDeliveryProcessList = borrowService.getListOfInDeliveryProcess();

        return SUCCESS;
    }

    private List<Integer> selectedOrderIds;

    public void setSelectedOrderIds(List<Integer> selectedOrderIds) {
        this.selectedOrderIds = selectedOrderIds;
    }

    public String markSelectedAsDelivered() {

        if(borrowService.markSelectedAsDelivered(selectedOrderIds)) {
            result = "success";
        } else {
            result = "error";
        }

        return SUCCESS;
    }

}