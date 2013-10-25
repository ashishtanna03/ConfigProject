package com.action.book;

import com.FTPUploader;
import com.action.UploadImageAction;
import com.action.admin.AdminPanelAction;
import com.opensymphony.xwork2.ActionSupport;
import com.pojo.hibernate.BookInfo;
import com.pojo.hibernate.PublisherInfo;
import com.service.BookService;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 7/31/13
 * Time: 3:17 AM
 * To change this template use File | Settings | File Templates.
 */
public class AddBookAction extends ActionSupport implements ServletRequestAware{

    private String bookTitle;
    private File bookImg;
    private String bookImgFileName;
    private Integer imageX;
    private Integer imageY;
    private Integer imageW;
    private Integer imageH;
    private String isbn;
    private Integer bookMrp;
    private Integer publishingYear;
    private String bookDescription;

    private BookService bookService;

    private String resultHeader;
    private String resultMessage;
    private Integer bookId;

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    public void setBookImg(File bookImg) {
        this.bookImg = bookImg;
    }

    public void setBookImgFileName(String bookImgFileName) {
        this.bookImgFileName = bookImgFileName;
    }

    public void setImageX(Integer imageX) {
        this.imageX = imageX;
    }

    public void setImageY(Integer imageY) {
        this.imageY = imageY;
    }

    public void setImageW(Integer imageW) {
        this.imageW = imageW;
    }

    public void setImageH(Integer imageH) {
        this.imageH = imageH;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public void setBookMrp(Integer bookMrp) {
        this.bookMrp = bookMrp;
    }

    public void setPublishingYear(Integer publishingYear) {
        this.publishingYear = publishingYear;
    }

    public void setBookDescription(String bookDescription) {
        this.bookDescription = bookDescription;
    }

    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    public String getResultHeader() {
        return resultHeader;
    }

    public String getResultMessage() {
        return resultMessage;
    }

    public Integer getBookId() {
        return bookId;
    }

    public String addBook() {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {

            //checking if any book exists of given isbn
            if(isbn==null || (isbn.length()!=10 && isbn.length()!=13) ||
                    bookTitle==null || bookTitle.equals("") ||
                    publishingYear==null || bookMrp==null) {
                return ERROR;
            } else if (bookService.checkIfBookExists(isbn)) {
                resultHeader = "The book already exists";
                resultMessage = "The details of the book you provided already exists in our database." +
                        "\nTry to search the book using ISBN No.";
                return SUCCESS;
            }

            //getting date from year's value
            Date publishingDate = null;
            if(publishingYear!=null && publishingYear.toString().length()==4) {
                Calendar calendar = Calendar.getInstance();
                calendar.set(Calendar.YEAR, publishingYear);
                publishingDate = calendar.getTime();
            } else {
                return ERROR;
            }

            BookInfo bookInfo = new BookInfo();
            bookInfo.setBookTitle(bookTitle);
            if(isbn.length()==10)
                bookInfo.setIsbn10(isbn);
            else
                bookInfo.setIsbn13(isbn);
            bookInfo.setPublisherInfoByPublisherId(bookService.getPublisherInfoById(1));
            bookInfo.setPublishingDate(new java.sql.Date(publishingDate.getTime()));
            bookInfo.setBookMrp(bookMrp);
            bookInfo.setVerified(false);
            if(bookDescription!=null)
                bookInfo.setBookDescription(bookDescription);

            if (bookService.addBook(bookInfo)) {

                //saving image
                if(bookImg!=null) {
                    bookInfo.setBookImgUrl(saveImage(bookImg,bookImgFileName, bookInfo.getBookId(), "book-covers", imageX, imageY, imageW, imageH ));
                    if(!bookService.saveBookImage(bookInfo))
                        return ERROR;
                }

                resultHeader = "Book is added Successfully";
                resultMessage = "The book is added to our database successfully." +
                        "\n<a href=\"/book/GetBookInfo.action?bookId="+bookInfo.getBookId()+"\">Click Here</a> to view book & share.";
                return SUCCESS;
            } else {
                return ERROR;
            }

        } else {
            resultHeader = "Not Logged in";
            resultMessage = "You must be logged in to add book." +
                    "/nPlease, Login and try again.";
            return SUCCESS;
        }
    }

    private static final Integer fixedImageWidth=190;
    private static final Integer fixedImageHeight=285;

    private HttpServletRequest servletRequest;

    public void setServletRequest(HttpServletRequest servletRequest) {
        this.servletRequest = servletRequest;
    }

    private String saveImage(File uploadedImage, String uploadedImageFileName, Integer id, String uploadDirectory, Integer imgX, Integer imgY, Integer imgW, Integer imgH) {
        try {

            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {

                //getting server's path and creating file name as user id
                String serverPath = servletRequest.getSession().getServletContext().getRealPath("/");
                String outputFileName = id+"."+ FilenameUtils.getExtension(uploadedImageFileName).toLowerCase();
                String imageToBeSaved=serverPath+"uploads\\"+outputFileName;

                //copying uploaded file to server as a image (uploaded file will be as .tmp)
                File imageToCrop = new File(serverPath, uploadedImageFileName);
                FileUtils.copyFile(uploadedImage, imageToCrop);

                BufferedImage image= ImageIO.read(imageToCrop);

                //getting original image's dimension and boundary value of the div
                Dimension imageSize = new Dimension(image.getWidth(), image.getHeight());
                Dimension boundary = new Dimension(229, 350);

                //getting scaled dimensions of image according to its boundary
                Dimension scaledDimension = UploadImageAction.getScaledDimension(imageSize, boundary);

                //scaling image according to its boundary
                image = UploadImageAction.toBufferedImage(UploadImageAction.resizeImage(image, (int) scaledDimension.width, (int) scaledDimension.getHeight(), true));

                //Get the sub image (crop)
                BufferedImage out=image.getSubimage(imgX,imgY,imgW,imgH);

                //resize image to standard width and height
                out = UploadImageAction.toBufferedImage(UploadImageAction.resizeImage(out,AddBookAction.fixedImageWidth,AddBookAction.fixedImageHeight,true));

                //Store the cropped image to a new file
                File croppedImage = new File(imageToBeSaved);
                ImageIO.write(out,"jpg",croppedImage);

                try {
                    FTPUploader ftpUploader = new FTPUploader("ftp.jusdias.com", "rh_images", "Ganesha@03");
                    //home directory for rh_images is jusidas.com/readershive/images/
                    //FTP server path is relative. So if FTP account HOME directory is "/home/pankaj/public_html/" and you need to upload
                    // files to "/home/pankaj/public_html/wp-content/uploads/image2/", you should pass directory parameter as "/wp-content/uploads/image2/"
                    ftpUploader.uploadFile(imageToBeSaved,outputFileName, "/"+uploadDirectory+"/");
                    ftpUploader.disconnect();
                } catch (Exception e) {
                    e.printStackTrace();
                }

                image.flush();
                out.flush();

                System.gc();

                try {
                    FileUtils.forceDelete(imageToCrop);
                } catch (IOException e) {
                    //e.printStackTrace();
                    FileUtils.forceDeleteOnExit(imageToCrop);
                }
                try {
                    FileUtils.forceDelete(croppedImage);
                } catch (IOException e) {
                    //e.printStackTrace();
                    FileUtils.forceDeleteOnExit(croppedImage);
                }

                //returning image url to be saved in db
                return "http://images.readershive.com/"+uploadDirectory+"/"+outputFileName;

            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
