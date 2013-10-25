package com.action.admin;

import com.FTPUploader;
import com.JpegReader;
import com.action.UploadImageAction;
import com.opensymphony.xwork2.ActionSupport;
import com.pojo.custom.AuthorDetails;
import com.pojo.hibernate.AuthorInfo;
import com.pojo.hibernate.BookInfo;
import com.pojo.hibernate.Genres;
import com.pojo.hibernate.PublisherInfo;
import com.service.*;
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
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 8/12/13
 * Time: 3:49 PM
 * To change this template use File | Settings | File Templates.
 */
public class AdminPanelAction extends ActionSupport implements ServletRequestAware {

    private UserService userService;
    private BookService bookService;
    private BookReviewService bookReviewService;
    private LendService lendService;
    private AuthorService authorService;
    private AuthorReviewService authorReviewService;
    private JpegReader jpegReader;

    private String result;

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    public void setBookReviewService(BookReviewService bookReviewService) {
        this.bookReviewService = bookReviewService;
    }

    public void setLendService(LendService lendService) {
        this.lendService = lendService;
    }

    public void setAuthorService(AuthorService authorService) {
        this.authorService = authorService;
    }

    public void setAuthorReviewService(AuthorReviewService authorReviewService) {
        this.authorReviewService = authorReviewService;
    }

    public void setJpegReader(JpegReader jpegReader) {
        this.jpegReader = jpegReader;
    }

    public String getResult() {
        return result;
    }

    /*--------------Add New Book------------------*/

    /*Add New Book Variables*/
    private String bookTitle;
    private String bookSubTitle;

    private File bookImg;
    private String bookImgFileName;
    private Integer imageX;                //Also used for author image imageX,y,w,h
    private Integer imageY;
    private Integer imageW;
    private Integer imageH;

    private String isbn10;
    private String isbn13;
    private String bookDescription;
    private Integer noOfPages;
    private Integer bookMrp;
    private String bookLanguage;
    private String bookFormat;
    private List<Integer> authorIds;
    private List<Integer> genreIds; // also used for add author page
    private Integer publisherId;
    private Date publishingDate;
    private Boolean verified;

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    public void setBookSubTitle(String bookSubTitle) {
        this.bookSubTitle = bookSubTitle;
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

    public void setIsbn10(String isbn10) {
        this.isbn10 = isbn10;
    }

    public void setIsbn13(String isbn13) {
        this.isbn13 = isbn13;
    }

    public void setBookDescription(String bookDescription) {
        this.bookDescription = bookDescription;
    }

    public void setNoOfPages(Integer noOfPages) {
        this.noOfPages = noOfPages;
    }

    public void setBookMrp(Integer bookMrp) {
        this.bookMrp = bookMrp;
    }

    public void setBookLanguage(String bookLanguage) {
        this.bookLanguage = bookLanguage;
    }

    public void setBookFormat(String bookFormat) {
        this.bookFormat = bookFormat;
    }

    public void setAuthorIds(List<Integer> authorIds) {
        this.authorIds = authorIds;
    }

    public void setGenreIds(List<Integer> genreIds) {  // also used for add author page
        this.genreIds = genreIds;
    }

    public void setPublisherId(Integer publisherId) {
        this.publisherId = publisherId;
    }

    public void setPublishingDate(java.util.Date publishingDate) {
        if(publishingDate!=null)
            this.publishingDate = new Date(publishingDate.getTime());
    }

    public void setVerified(Boolean verified) {
        this.verified = verified;
    }

    public String addNewBook() {
        BookInfo bookInfo = new BookInfo();
        bookInfo.setBookTitle(bookTitle);
        bookInfo.setBookSubtitle(bookSubTitle);
        bookInfo.setIsbn10(isbn10);
        bookInfo.setIsbn13(isbn13);
        bookInfo.setBookDescription(bookDescription);
        bookInfo.setNoOfPages(noOfPages);
        bookInfo.setBookMrp(bookMrp);
        bookInfo.setBookLanguage(bookLanguage);
        bookInfo.setBookFormat(bookFormat);
        bookInfo.setPublishingDate(publishingDate);
        bookInfo.setVerified(verified);

        List<AuthorInfo> bookAuthors = new ArrayList<AuthorInfo>(0);

        for(Integer authorId : authorIds) {
            bookAuthors.add(authorService.getAuthorById(authorId));
        }

        List<Genres> bookGenres = new ArrayList<Genres>(0);

        for(Integer genreId : genreIds) {
            bookGenres.add(authorService.getGenreById(genreId));
        }

        if(bookService.addNewBook(bookInfo, bookAuthors, bookGenres, publisherId)) {
            if (bookImg!=null && (bookInfo.getBookId()!=null || !bookInfo.getBookId().equals(0))) {
                bookInfo.setBookImgUrl(saveImage(bookImg,bookImgFileName,bookInfo.getBookId(), "book-covers", imageX, imageY, imageW, imageH));
                if(bookService.saveBookImage(bookInfo))
                    return SUCCESS;
                else
                    return ERROR;
            }
            return SUCCESS;
        } else {
            return ERROR;
        }

    }
    /*--------------/Add New Book------------------*/

    /*--------------Add New Author------------------*/

    /*Add New Author Variables*/
    private String authorName;
    private String authorPenName;
    private String authorGender;
    private String authorDescription;
    private String authorBlogLink;
    private File authorImg;
    private String authorImgFileName;
    private String authorLives;
    private Date authorBorn;
    private Date authorDied;
//    private String authorNotableWorks;

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public void setAuthorPenName(String authorPenName) {
        this.authorPenName = authorPenName;
    }

    public void setAuthorGender(String authorGender) {
        this.authorGender = authorGender;
    }

    public void setAuthorDescription(String authorDescription) {
        this.authorDescription = authorDescription;
    }

    public void setAuthorBlogLink(String authorBlogLink) {
        this.authorBlogLink = authorBlogLink;
    }

    public void setAuthorImg(File authorImg) {
        this.authorImg = authorImg;
    }

    public void setAuthorImgFileName(String authorImgFileName) {
        this.authorImgFileName = authorImgFileName;
    }

    public void setAuthorLives(String authorLives) {
        this.authorLives = authorLives;
    }

    public void setAuthorBorn(java.util.Date authorBorn) {
        if(authorBorn!=null)
            this.authorBorn = new Date(authorBorn.getTime());
    }

    public void setAuthorDied(java.util.Date authorDied) {
        if(authorDied!=null)
            this.authorDied = new Date(authorDied.getTime());
    }

    public String addNewAuthor() {
        AuthorInfo authorInfo = new AuthorInfo();
        authorInfo.setAuthorName(authorName);
        authorInfo.setAuthorPenName(authorPenName);
        authorInfo.setAuthorGender(authorGender);
        authorInfo.setAuthorDescription(authorDescription);
        authorInfo.setAuthorBlogLink(authorBlogLink);
        authorInfo.setAuthorLives(authorLives);
        authorInfo.setAuthorBorn(authorBorn);
        authorInfo.setAuthorDied(authorDied);

        List<Genres> authorGenres = new ArrayList<Genres>(0);

        for(Integer genreId : genreIds) {
            authorGenres.add(authorService.getGenreById(genreId));
        }

        if(authorService.addNewAuthor(authorInfo, authorGenres)) {
            if (authorImg!=null && (authorInfo.getAuthorId()!=null || !authorInfo.getAuthorId().equals(0))) {
                authorInfo.setAuthorImg(saveImage(authorImg,authorImgFileName,authorInfo.getAuthorId(), "authors", imageX, imageY, imageW, imageH));
                if(authorService.saveAuthorImage(authorInfo))
                    return SUCCESS;
                else
                    return ERROR;
            }
            return SUCCESS;
        } else {
            return ERROR;
        }

    }
    /*--------------/Add New Author------------------*/

    /*--------------Add New Publisher------------------*/

    /*Add New Publisher Variables*/
    private String publisherName;

    public void setPublisherName(String publisherName) {
        this.publisherName = publisherName;
    }

    public String addNewPublisher(){

        PublisherInfo publisherInfo = new PublisherInfo();
        publisherInfo.setPublisherName(publisherName);

        if(authorService.addNewPublisher(publisherInfo)) {
            return SUCCESS;
        } else {
            return ERROR;
        }
    }
    /*--------------/Add New Publisher------------------*/

    /*--------------Add New Publisher------------------*/

    /*Add New Genre Variables*/
    private String genreName;

    public void setGenreName(String genreName) {
        this.genreName = genreName;
    }

    public String addNewGenre(){

        Genres genre = new Genres();
        genre.setGenreName(genreName);

        if(authorService.addNewGenre(genre)) {
            return SUCCESS;
        } else {
            return ERROR;
        }
    }
    /*--------------/Add New Publisher------------------*/

    /*--------------Authors, Genres and Publisher List-------------------*/

    private List<AuthorDetails> authorList;
    private List<Genres> genreList;
    private List<PublisherInfo> publisherList;

    public List<PublisherInfo> getPublisherList() {
        return publisherList;
    }

    public List<AuthorDetails> getAuthorList() {
        return authorList;
    }

    public List<Genres> getGenreList() {
        return genreList;
    }

    //for add book page
    public String getAllLists(){

        getAuthorsList();
        getGenresList();
        getPublishersList();

        return SUCCESS;
    }

    public String getAuthorsList() {
        authorList = authorService.getAuthorList();
        return SUCCESS;
    }

    //for add new author page
    public String getGenresList() {
        genreList = authorService.getGenreList();
        return SUCCESS;
    }

    public String getPublishersList() {
        publisherList = authorService.getPublisherList();
        return SUCCESS;
    }

   /*--------------/Authors, Genres and Publisher List-------------------*/

    /*---------------Upload Image------------*/

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

//                BufferedImage image= ImageIO.read(imageToCrop);
                BufferedImage image = jpegReader.readImage(imageToCrop);

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
                out = UploadImageAction.toBufferedImage(UploadImageAction.resizeImage(out,AdminPanelAction.fixedImageWidth,AdminPanelAction.fixedImageHeight,true));

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
    /*---------------Upload Image------------*/


}
