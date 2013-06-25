package com.action.search;

import com.opensymphony.xwork2.ActionSupport;
import com.pojo.hibernate.BookGenres;
import com.pojo.hibernate.BookInfo;
import com.pojo.hibernate.Lend;
import com.service.BookService;
import org.hibernate.criterion.*;
import org.hibernate.transform.Transformers;

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
    private String filterGenre;
    private String filterLanguage;
    private Integer filterPriceRange;
    private boolean excludeOutOfStock;

    public Double possibleResults=0.0;

    private BookService bookService;

    private List<BookInfo> bookList;
    private Map<String,Integer> availGenres = new HashMap<String, Integer>(0);
    private Map<String,Integer> availLanguages = new HashMap<String, Integer>(0);
    private List<Integer> availPriceRanges = new ArrayList<Integer>(5);
    private Integer totalPages;

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

    public Integer getTotalPages() {
        return totalPages;
    }

    public String loadSearchResults(){

        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(BookInfo.class);
        detachedCriteria.createAlias("bookAuthorsesByBookId","authors");
        detachedCriteria.createAlias("authors.authorInfoByAuthorId","author");
        detachedCriteria.createAlias("publisherInfoByPublisherId","publisher");

        detachedCriteria.setResultTransformer(DetachedCriteria.DISTINCT_ROOT_ENTITY);
        /*detachedCriteria.setProjection(Projections.projectionList()
                .add(Projections.distinct(Projections.property("bookId")))
                .add(Projections.property("bookTitle"))
        );*/

//        detachedCriteria.setResultTransformer(Transformers.aliasToBean(BookInfo.class));

        Disjunction disjunction = Restrictions.disjunction();
        Conjunction filterConjunction = Restrictions.conjunction();

        disjunction
                .add(Restrictions.like("bookTitle", searchQuery, MatchMode.ANYWHERE))
                .add(Restrictions.like("author.authorName", searchQuery, MatchMode.ANYWHERE))
                .add(Restrictions.like("publisher.publisherName", searchQuery, MatchMode.ANYWHERE))
                .add(Restrictions.like("isbn10", searchQuery, MatchMode.ANYWHERE))
                .add(Restrictions.like("isbn13", searchQuery, MatchMode.ANYWHERE))
        ;

        //Genre Filter
        if(filterGenre!=null && !filterGenre.equals("")) {
            detachedCriteria.createAlias("bookGenresesByBookId","genres");
            detachedCriteria.createAlias("genres.genresByGenreId","genre");
            filterConjunction.add(Restrictions.like("genre.genreName", filterGenre));
        }

        //Language Filter
        if(filterLanguage!=null && !filterLanguage.equals("")) {
            filterConjunction.add(Restrictions.like("bookLanguage", filterLanguage));
        }

        if((filterPriceRange!=null && filterPriceRange<5) || excludeOutOfStock) {
            detachedCriteria.createAlias("lendsByBookId","lend");
        }

        //Price Range Filter
        if (filterPriceRange!=null && filterPriceRange<5) {
            switch (filterPriceRange) {
                case 0 :
                    filterConjunction.add(Restrictions.lt("lend.sharingPrice",200));
                    break;
                case 1 :
                    filterConjunction.add(Restrictions.between("lend.sharingPrice",201,500));
                    break;
                case 2 :
                    filterConjunction.add(Restrictions.between("lend.sharingPrice",501,700));
                    break;
                case 3 :
                    filterConjunction.add(Restrictions.between("lend.sharingPrice",701,1000));
                    break;
                case 4 :
                    filterConjunction.add(Restrictions.gt("lend.sharingPrice",1001));
                    break;
                default : break;
            }
        }

        //Exclude out of stock
        if (excludeOutOfStock) {
            filterConjunction.add(Restrictions.not(Restrictions.like("lend.lendStatus",1)));
        }

        detachedCriteria.add(Restrictions.conjunction()
                .add(disjunction)
                .add(filterConjunction)
        );

        List<BookInfo> allBooksList = new ArrayList<BookInfo>(0);
        allBooksList = bookService.getSearchResults(detachedCriteria);

        if (newRequest){
            if(allBooksList!=null) {
                possibleResults = (double) allBooksList.size();
            } else {
                possibleResults = (double) 0;
            }
//            possibleResults = Double.valueOf(bookService.getNoOfPossibleResults(detachedCriteria));
//            possibleResults = Double.valueOf(bookService.getNoOfPossibleResults(detachedCriteria.setProjection(Projections.countDistinct("bookId"))));
            totalPages = (int)Math.ceil(possibleResults/maxResults);
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

        return SUCCESS;
    }

    public void setBookService(BookService bookService) {
        this.bookService=bookService;
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

}
