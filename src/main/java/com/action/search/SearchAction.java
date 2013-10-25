package com.action.search;

import com.opensymphony.xwork2.ActionSupport;
import com.pojo.hibernate.*;
import com.service.BookService;
import com.service.UserService;
import org.hibernate.FetchMode;
import org.hibernate.criterion.*;
import org.hibernate.transform.Transformers;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/24/13
 * Time: 4:45 PM
 * To change this template use File | Settings | File Templates.
 */
public class SearchAction extends ActionSupport {

    private String searchQuery;
    private boolean newRequest;
    private Integer maxResults = 7;
    private Integer pageNo = 0;
    private Integer sortBy;
    private String filterGenre;
    private String filterLanguage;
    private Integer filterPriceRange;
    private boolean excludeOutOfStock;

    public Double possibleResults=0.0;
    private Boolean sortByRating=false;
    private Boolean sortByPrice=false;
    private Boolean priceLowestFirst=false;

    private BookService bookService;
    private UserService userService;

    private List<BookInfo> bookList;
    private Map<String,Integer> availGenres = new HashMap<String, Integer>(0);
    private Map<String,Integer> availLanguages = new HashMap<String, Integer>(0);
    private List<Integer> availPriceRanges = new ArrayList<Integer>(5);
    private Integer totalResults;
    private Integer totalPages;
    private Integer userId;
    private String userAddress;
    private String userContact;

    public void setSearchQuery(String searchQuery) {
        this.searchQuery = searchQuery;
    }

    public void setNewRequest(boolean newRequest) {
        this.newRequest = newRequest;
    }

    public void setMaxResults(Integer maxResults) {
        if(maxResults!=0)
            this.maxResults = maxResults;
    }

    public void setPageNo(Integer pageNo) {
            this.pageNo = pageNo;
    }

    public void setSortBy(Integer sortBy) {
        this.sortBy = sortBy;
    }

    public void setFilterGenre(String filterGenre) {
        this.filterGenre = filterGenre;
    }

    public void setFilterLanguage(String filterLanguage) {
        this.filterLanguage = filterLanguage;
    }

    public void setFilterPriceRange(Integer filterPriceRange) {
        this.filterPriceRange = filterPriceRange;
    }

    public void setExcludeOutOfStock(boolean excludeOutOfStock) {
        this.excludeOutOfStock = excludeOutOfStock;
    }

    public void setBookService(BookService bookService) {
        this.bookService=bookService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setTotalResults(Integer totalResults) {
        this.totalResults = totalResults;
    }

    public void setTotalPages(Integer totalPages) {
        this.totalPages = totalPages;
    }

    public String getSearchQuery() {
        return searchQuery;
    }

    public List<BookInfo> getBookList() {
        return bookList;
    }

    public Map<String, Integer> getAvailGenres() {
        return availGenres;
    }

    public Map<String, Integer> getAvailLanguages() {
        return availLanguages;
    }

    public List<Integer> getAvailPriceRanges() {
        return availPriceRanges;
    }

    public Integer getTotalResults() {
        return totalResults;
    }

    public Integer getTotalPages() {
        return totalPages;
    }

    public Integer getUserId() {
        return userId;
    }

    public String getUserContact() {
        return userContact;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public String loadSearchResults(){

        String query = null;
        String filterQuery = "";
        String orderBy = "";
        String innerJoinLend = ""; //if to be filtered by price range join with lend table

        if((filterPriceRange!=null && filterPriceRange<5) || excludeOutOfStock) {
//            detachedCriteria.createAlias("bookInfo.lendsByBookId","lend");
            innerJoinLend = "   INNER JOIN book.lend lend" +
                    "           ON bookinfo.book_id = lend.book_id";
        }

        query = "SELECT DISTINCT bookinfo.* " +
                "FROM   book.book_info bookinfo" +
                "   INNER JOIN book.publisher_info publisher" +
                "           ON bookinfo.publisher_id = publisher.publisher_id" +
                innerJoinLend +
                "   INNER JOIN book.book_authors bookauthors" +
                "           ON bookinfo.book_id = bookauthors.book_id" +
                "   INNER JOIN book.author_info authorinfo" +
                "           ON bookauthors.author_id = authorinfo.author_id" +
                "   INNER JOIN book.book_genres bookgenres" +
                "           ON bookinfo.book_id = bookgenres.book_id" +
                "   INNER JOIN book.genres genre" +
                "           ON bookgenres.genre_id = genre.genre_id " +
                "WHERE  ( ( ";

       /* DetachedCriteria detachedCriteria = DetachedCriteria.forClass(BookInfo.class,"bookInfo");

//        detachedCriteria.setFetchMode("bookInfo.bookAuthorsesByBookId", FetchMode.JOIN);
        detachedCriteria.setFetchMode("bookInfo.bookAuthorsesByBookId",FetchMode.JOIN);
        detachedCriteria.createAlias("bookInfo.bookAuthorsesByBookId","bookAuthorses",CriteriaSpecification.INNER_JOIN);
        detachedCriteria.setFetchMode("bookAuthorses.authorInfoByAuthorId", FetchMode.JOIN);

        detachedCriteria.createCriteria("bookInfo.bookAuthorsesByBookId.authorInfoByAuthorId", "authorInfo", CriteriaSpecification.INNER_JOIN);
//        detachedCriteria.createAlias("bookAuthorses.authorInfoByAuthorId", "authorInfo", CriteriaSpecification.FULL_JOIN);
        detachedCriteria.createAlias("bookInfo.publisherInfoByPublisherId","publisher");

        detachedCriteria.setResultTransformer(DetachedCriteria.DISTINCT_ROOT_ENTITY); */
        /*detachedCriteria.setProjection(Projections.projectionList()
                .add(Projections.distinct(Projections.property("bookId")))
                .add(Projections.property("bookTitle"))
        );*/

//        detachedCriteria.setResultTransformer(Transformers.aliasToBean(BookInfo.class));

        Disjunction disjunction = Restrictions.disjunction();
        Conjunction filterConjunction = Restrictions.conjunction();

        disjunction
                .add(Restrictions.like("bookInfo.bookTitle", searchQuery, MatchMode.ANYWHERE))
//                .add(detachedCriteria.createCriteria().add())
                .add(Restrictions.like("authorInfo.authorName", searchQuery, MatchMode.ANYWHERE))
                .add(Restrictions.like("publisher.publisherName", searchQuery, MatchMode.ANYWHERE))
                .add(Restrictions.like("bookInfo.isbn10", searchQuery, MatchMode.ANYWHERE))
                .add(Restrictions.like("bookInfo.isbn13", searchQuery, MatchMode.ANYWHERE))
        ;

        query += "bookinfo.book_title LIKE '%"+searchQuery+"%'";
        query += " OR authorinfo.author_name LIKE '%"+searchQuery+"%'";
        query += " OR publisher.publisher_name LIKE '%"+searchQuery+"%'";
        query += " OR bookinfo.isbn_10 LIKE '%"+searchQuery+"%'";
        query += " OR bookinfo.isbn_13 LIKE '%"+searchQuery+"%' )";

        //Sort By
        if(sortBy!=null) {
            switch (sortBy) {
                case 0:
                    sortByRating = true;
                    break;
                case 1:
                    sortByPrice=true;
                    priceLowestFirst=true;
                    break;
                case 2:
                    sortByPrice=true;
                    priceLowestFirst=false;
                    break;
                case 3 :
//                    detachedCriteria.addOrder(Order.asc("bookInfo.bookTitle"));
                    orderBy = " ORDER BY bookinfo.book_title ASC";
                    break;
                case 4:
//                    detachedCriteria.addOrder(Order.desc("bookInfo.bookTitle"));
                    orderBy = " ORDER BY bookinfo.book_title DESC";
                    break;
                default:
                    sortByRating = true;
                    break;

            }
        }

        //Genre Filter
        if(filterGenre!=null && !filterGenre.equals("")) {
//            detachedCriteria.createAlias("bookInfo.bookGenresesByBookId","genres");
//            detachedCriteria.createAlias("genres.genresByGenreId","genre");
//            filterConjunction.add(Restrictions.like("genre.genreName", filterGenre));
            filterQuery += " genre.genre_name LIKE '"+filterGenre+"' AND";
        }

        //Language Filter
        if(filterLanguage!=null && !filterLanguage.equals("")) {
//            filterConjunction.add(Restrictions.like("bookInfo.bookLanguage", filterLanguage));
            filterQuery += " bookinfo.book_language LIKE '"+filterLanguage+"' AND";
        }



        //Price Range Filter
        if (filterPriceRange!=null && filterPriceRange<5) {
            switch (filterPriceRange) {
                case 0 :
//                    filterConjunction.add(Restrictions.lt("lend.sharingPrice",200));
                    filterQuery += " lend.sharing_price<201 AND";
                    break;
                case 1 :
//                    filterConjunction.add(Restrictions.between("lend.sharingPrice",201,500));
                    filterQuery += " lend.sharing_price BETWEEN 201 AND 500 AND";
                    break;
                case 2 :
//                    filterConjunction.add(Restrictions.between("lend.sharingPrice",501,700));
                    filterQuery += " lend.sharing_price BETWEEN 501 AND 700 AND";
                    break;
                case 3 :
//                    filterConjunction.add(Restrictions.between("lend.sharingPrice",701,1000));
                    filterQuery += " lend.sharing_price BETWEEN 701 AND 1000 AND";
                    break;
                case 4 :
//                    filterConjunction.add(Restrictions.gt("lend.sharingPrice",1001));
                    filterQuery += " lend.sharing_price>1000 AND";
                    break;
                default : break;
            }
        }

        //Exclude out of stock
        if (excludeOutOfStock) {
//            filterConjunction.add(Restrictions.not(Restrictions.like("lend.lendStatus",1)));
            filterQuery += " lend.lend_status!=1 AND";
        }

//        detachedCriteria.add(Restrictions.conjunction()
//                .add(disjunction)
//                .add(filterConjunction)
//        );

        query += " AND (" + filterQuery + " 1=1 )) " + orderBy;

        List<BookInfo> allBooksList = new ArrayList<BookInfo>(0);
//        allBooksList = bookService.getSearchResults(detachedCriteria);
        allBooksList = bookService.getSearchResults(query);

        //Sorting list by rating
        if(sortByRating && allBooksList!=null && allBooksList.size()>0) {
            allBooksList = this.sortBooksByRating(allBooksList);
        }

        //sorting list by price
        if(sortByPrice && allBooksList!=null && allBooksList.size()>0) {
            allBooksList = this.sortBooksByPrice(priceLowestFirst, allBooksList);
        }

        if (newRequest){
            if(allBooksList!=null) {
                possibleResults = (double) allBooksList.size();
            } else {
                possibleResults = (double) 0;
            }
//            possibleResults = Double.valueOf(bookService.getNoOfPossibleResults(detachedCriteria));
//            possibleResults = Double.valueOf(bookService.getNoOfPossibleResults(detachedCriteria.setProjection(Projections.countDistinct("bookId"))));
            totalPages = (int)Math.ceil(possibleResults/maxResults);
            totalResults = possibleResults.intValue();
        }

        Integer firstResult = pageNo * maxResults;

        //Set<BookInfo> bookInfos = new HashSet<BookInfo>(bookList);
        //bookList.get(0).getBookAuthorsesByBookId().iterator().next().getAuthorInfoByAuthorId().getAuthorName();

        //Setting initially all price ranges to 0
        for(int i=0;i<5;i++) {
            availPriceRanges.add(i,0);
        }

        //Filter Info
        bookList = new ArrayList<BookInfo>(0);
        if (allBooksList != null && allBooksList.size() > 0) {
            int listSize = allBooksList.size();
            for (int j=0; j<listSize;j++) {
                //search results
                BookInfo bookInfo = allBooksList.get(j);
                if (bookInfo!=null && j>=firstResult && bookList.size()<maxResults) {
                    bookList.add(bookInfo);
                }

                //genre filters
                for (BookGenres bookGenres : bookInfo.getBookGenresesByBookId()) {
                    String genreName = null;
                    genreName = bookGenres.getGenresByGenreId().getGenreName();
                    if (availGenres.containsKey(genreName)) {
                        availGenres.put(genreName, availGenres.get(genreName)+1);
                    } else {
                        availGenres.put(genreName, 1);
                    }
                }
                availGenres = sortByComparator(availGenres);

                //language filters
                String language = bookInfo.getBookLanguage();
                if (availLanguages.containsKey(language)) {
                    availLanguages.put(language, availLanguages.get(language) + 1);
                } else {
                    availLanguages.put(language, 1);
                }
                availLanguages = sortByComparator(availLanguages);

                //Price Range Filters

                for(Lend lend : bookInfo.getLendsByBookId()) {
                    if(lend.getLendStatus()!=1) {
                        if(lend.getSharingPrice()<=200) {
                            availPriceRanges.set(0,availPriceRanges.get(0)+1);
                        } else if (lend.getSharingPrice()<=500) {
                            availPriceRanges.set(1,availPriceRanges.get(1)+1);
                        } else if (lend.getSharingPrice()<=700) {
                            availPriceRanges.set(2,availPriceRanges.get(2)+1);
                        } else if (lend.getSharingPrice()<=1000) {
                            availPriceRanges.set(3,availPriceRanges.get(3)+1);
                        } else {
                            availPriceRanges.set(4,availPriceRanges.get(4)+1);
                        }
                    }
                }

            }
        }

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
            UserInfo user = userService.getUserById(authentication.getName());
            userId = user.getUserId();
            userAddress = user.getUserAddress();
            userContact = user.getUserContact();
        }

        return SUCCESS;
    }

    //To Sort the availGenres Map
    private static Map sortByComparator(Map availGenres) {

        List list = new LinkedList(availGenres.entrySet());

        // sort list based on comparator
        Collections.sort(list, new Comparator() {
            public int compare(Object o1, Object o2) {
                return ((Comparable) ((Map.Entry) (o2)).getValue())
                        .compareTo(((Map.Entry) (o1)).getValue());
            }
        });

        // put sorted list into map again
        //LinkedHashMap make sure order in which keys were inserted
        Map sortedMap = new LinkedHashMap();
        for (Object aList : list) {
            Map.Entry entry = (Map.Entry) aList;
            sortedMap.put(entry.getKey(), entry.getValue());
        }
        return sortedMap;
    }

    private List<BookInfo> sortBooksByRating(List<BookInfo> allBooksList) {
        Map<Integer,Float> bookHashMap = new HashMap<Integer, Float>(0); //key will be book id and value will be average ratings

        //getting average rating of all books and adding them into the hashmap
        Float averageRating = new Float(0.0);
        for(BookInfo bookInfo:allBooksList) {
            if(bookInfo.getBookRatingsByBookId()!=null && bookInfo.getBookRatingsByBookId().size()>0) {
                for(BookRating bookRating:bookInfo.getBookRatingsByBookId()) {
                    averageRating += bookRating.getRating();
                }
                averageRating /= bookInfo.getBookRatingsByBookId().size();
            }
            //setting bookId as a key and average rating as value
            bookHashMap.put(bookInfo.getBookId(), averageRating);
            averageRating = new Float(0.0);
        }

        //sorting the hashmap by average ratings of all books
        bookHashMap = sortByComparator(bookHashMap);

        //arranging the original list as sorted ratings
        List<BookInfo> sortedList =new ArrayList<BookInfo>(0);
        if(bookHashMap!=null && bookHashMap.size()>0) {
            for(Integer bookId : bookHashMap.keySet()) {
                for(BookInfo bookInfo : allBooksList) {
                    if(bookId.equals(bookInfo.getBookId())) {
                        sortedList.add(bookInfo);
                        break;
                    }
                }
            }
        }
        return sortedList;
    }

    private List<BookInfo> sortBooksByPrice(Boolean priceLowestFirst, List<BookInfo> allBooksList) {

        Map<Integer,Integer> bookHashMap = new HashMap<Integer, Integer>(0); //key will be book id and value will be lowest price

        //getting lowest price of all books and adding them into the hashmap
        Integer lowestPrice = 100000; //MAX value for comparison
        for(BookInfo bookInfo:allBooksList) {
            if(bookInfo.getLendsByBookId()!=null && bookInfo.getLendsByBookId().size()>0) {
                for(Lend lend:bookInfo.getLendsByBookId()) {
                    if(lend.getLendStatus()!=1) {
                        lowestPrice=lend.getSharingPrice();
                        break;
                    }
                }
            }

            if(priceLowestFirst) {
                lowestPrice*=-1; //to sort array in ascending order converting the lowest price to negative
            } else if(lowestPrice.equals(100000))
                lowestPrice=0; //to sort list as highest first change the lowest value to 0

            //setting bookId as a key and average rating as value
            bookHashMap.put(bookInfo.getBookId(), lowestPrice);
            lowestPrice=100000;
        }

        //sorting the hashmap by price of all books
        bookHashMap = sortByComparator(bookHashMap);

        //arranging the original list as sorted price list
        List<BookInfo> sortedList =new ArrayList<BookInfo>(0);
        if(bookHashMap!=null && bookHashMap.size()>0) {
            for(Integer bookId : bookHashMap.keySet()) {
                for(BookInfo bookInfo : allBooksList) {
                    if(bookId.equals(bookInfo.getBookId())) {
                        sortedList.add(bookInfo);
                        break;
                    }
                }
            }
        }

        return sortedList;
    }

}
