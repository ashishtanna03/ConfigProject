package com.pojo.hibernate;

import java.io.Serializable;
import java.sql.Date;
import java.util.Collection;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/13/13
 * Time: 8:47 PM
 * To change this template use File | Settings | File Templates.
 */
public class AuthorInfo implements Serializable {
    private Integer authorId;

    public Integer getAuthorId() {
        return authorId;
    }

    public void setAuthorId(Integer authorId) {
        this.authorId = authorId;
    }

    private String authorName;

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    private String authorPenName;

    public String getAuthorPenName() {
        return authorPenName;
    }

    public void setAuthorPenName(String authorPenName) {
        this.authorPenName = authorPenName;
    }

    private String authorGender;

    public String getAuthorGender() {
        return authorGender;
    }

    public void setAuthorGender(String authorGender) {
        this.authorGender = authorGender;
    }

    private String authorDescription;

    public String getAuthorDescription() {
        return authorDescription;
    }

    public void setAuthorDescription(String authorDescription) {
        this.authorDescription = authorDescription;
    }

    private String authorBlogLink;

    public String getAuthorBlogLink() {
        return authorBlogLink;
    }

    public void setAuthorBlogLink(String authorBlogLink) {
        this.authorBlogLink = authorBlogLink;
    }

    private String authorImg;

    public String getAuthorImg() {
        return authorImg;
    }

    public void setAuthorImg(String authorImg) {
        this.authorImg = authorImg;
    }

    private String authorLives;

    public String getAuthorLives() {
        return authorLives;
    }

    public void setAuthorLives(String authorLives) {
        this.authorLives = authorLives;
    }

    private Date authorBorn;

    public Date getAuthorBorn() {
        return authorBorn;
    }

    public void setAuthorBorn(Date authorBorn) {
        this.authorBorn = authorBorn;
    }

    private Date authorDied;

    public Date getAuthorDied() {
        return authorDied;
    }

    public void setAuthorDied(Date authorDied) {
        this.authorDied = authorDied;
    }

    private String authorNotableWorks;

    public String getAuthorNotableWorks() {
        return authorNotableWorks;
    }

    public void setAuthorNotableWorks(String authorNotableWorks) {
        this.authorNotableWorks = authorNotableWorks;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        AuthorInfo that = (AuthorInfo) o;

        if (authorBlogLink != null ? !authorBlogLink.equals(that.authorBlogLink) : that.authorBlogLink != null)
            return false;
        if (authorBorn != null ? !authorBorn.equals(that.authorBorn) : that.authorBorn != null) return false;
        if (authorDescription != null ? !authorDescription.equals(that.authorDescription) : that.authorDescription != null)
            return false;
        if (authorDied != null ? !authorDied.equals(that.authorDied) : that.authorDied != null) return false;
        if (authorGender != null ? !authorGender.equals(that.authorGender) : that.authorGender != null) return false;
        if (authorId != null ? !authorId.equals(that.authorId) : that.authorId != null) return false;
        if (authorImg != null ? !authorImg.equals(that.authorImg) : that.authorImg != null) return false;
        if (authorLives != null ? !authorLives.equals(that.authorLives) : that.authorLives != null) return false;
        if (authorName != null ? !authorName.equals(that.authorName) : that.authorName != null) return false;
        if (authorNotableWorks != null ? !authorNotableWorks.equals(that.authorNotableWorks) : that.authorNotableWorks != null)
            return false;
        if (authorPenName != null ? !authorPenName.equals(that.authorPenName) : that.authorPenName != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = authorId != null ? authorId.hashCode() : 0;
        result = 31 * result + (authorName != null ? authorName.hashCode() : 0);
        result = 31 * result + (authorPenName != null ? authorPenName.hashCode() : 0);
        result = 31 * result + (authorGender != null ? authorGender.hashCode() : 0);
        result = 31 * result + (authorDescription != null ? authorDescription.hashCode() : 0);
        result = 31 * result + (authorBlogLink != null ? authorBlogLink.hashCode() : 0);
        result = 31 * result + (authorImg != null ? authorImg.hashCode() : 0);
        result = 31 * result + (authorLives != null ? authorLives.hashCode() : 0);
        result = 31 * result + (authorBorn != null ? authorBorn.hashCode() : 0);
        result = 31 * result + (authorDied != null ? authorDied.hashCode() : 0);
        result = 31 * result + (authorNotableWorks != null ? authorNotableWorks.hashCode() : 0);
        return result;
    }
    private Collection<AuthorFollow> authorFollowsByAuthorId;

    public Collection<AuthorFollow> getAuthorFollowsByAuthorId() {
        return authorFollowsByAuthorId;
    }

    public void setAuthorFollowsByAuthorId(Collection<AuthorFollow> authorFollowsByAuthorId) {
        this.authorFollowsByAuthorId = authorFollowsByAuthorId;
    }

    private Collection<AuthorGenres> authorGenresesByAuthorId;

    public Collection<AuthorGenres> getAuthorGenresesByAuthorId() {
        return authorGenresesByAuthorId;
    }

    public void setAuthorGenresesByAuthorId(Collection<AuthorGenres> authorGenresesByAuthorId) {
        this.authorGenresesByAuthorId = authorGenresesByAuthorId;
    }

    private Collection<AuthorReview> authorReviewsByAuthorId;

    public Collection<AuthorReview> getAuthorReviewsByAuthorId() {
        return authorReviewsByAuthorId;
    }

    public void setAuthorReviewsByAuthorId(Collection<AuthorReview> authorReviewsByAuthorId) {
        this.authorReviewsByAuthorId = authorReviewsByAuthorId;
    }

    private Collection<BookAuthors> bookAuthorsesByAuthorId;

    public Collection<BookAuthors> getBookAuthorsesByAuthorId() {
        return bookAuthorsesByAuthorId;
    }

    public void setBookAuthorsesByAuthorId(Collection<BookAuthors> bookAuthorsesByAuthorId) {
        this.bookAuthorsesByAuthorId = bookAuthorsesByAuthorId;
    }
}
