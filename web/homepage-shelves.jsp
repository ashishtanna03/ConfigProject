<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


    <!--Rating-->
    <script type="text/javascript" src="/js/rating/jquery.raty.min.js"></script>
    <style type="text/css">
        div.rating-div {position:relative!important;height: auto!important;width: 112px!important;float:left!important;}
        .rating-div img {height: 18px!important;width: 18px!important;float: left;padding-right: 0!important;}
    </style>

<!--Left Genres Menu-->
<div id="left-side-menu">
    <a style="padding: 0" href="/search/LoadSearchResults.action?newRequest=true&excludeOutOfStock=false&pageNo=0&maxResults=7&sortBy=0&filterGenre=&filterLanguage=&filterPriceRange=5&searchQuery=">
        <h3 style="margin-bottom:13px;">All Categories</h3>
    </a>
    <s:iterator value="genresList">
        <p>
            <a href="/search/LoadSearchResults.action?newRequest=true&excludeOutOfStock=false&pageNo=0&maxResults=7&sortBy=0&filterGenre=<s:property />&filterLanguage=&filterPriceRange=5&searchQuery=">
                <s:property />
            </a>
        </p>
    </s:iterator>
</div>

<div id="featured-products_block_center">

<script type="text/javascript">
    var stepsCarousel1 = Math.floor((<s:property value="recentlyShared.size()"/>/4)-0.0001);
    var stepsCarousel2 = Math.floor((<s:property value="booksInDemand.size()"/>/4)-0.0001);
    var stepsCarousel3 = Math.floor((<s:property value="recentlyBought.size()"/>/4)-0.0001);
    var stepsCarousel4 = Math.floor((<s:property value="mostSharedBooks.size()"/>/4)-0.0001);
</script>
<%!
    Integer buttonId=0;
%>

<!--Recently Shared Books-->
<div class="carousel-container">
    <div class="btnprev" id="btnprev1" ><img src="img/previous_button.png" alt="Prev" /></div>
    <div class="btnnext" id="btnnext1" ><img src="img/next_button.png" alt="Next" /></div>
    <div class="block_content" id="carousel1">
        <ul>
            <s:iterator value="recentlyShared" >
            <li class="ajax_block_product">
                <div>
                    <h5><a class="product_link ellipsis" style="height: 30px;width:127px;" href="/book/GetBookInfo.action?bookId=<s:property value="bookId"/>" title="<s:property value="bookTitle"/>"><s:property value="bookTitle"/></a></h5>

                    <p style="padding: 8px 0 0 0;">
                        <s:if test="bookAuthorsesByBookId==null || bookAuthorsesByBookId.size()==0">N.A.</s:if>
                        <s:else>
                            <span>by,&nbsp;</span>
                            <s:iterator value="bookAuthorsesByBookId" status="authorIteratorStatus">
                                <a class="product_descr" style="height:3.5em;overflow: visible;"
                                   href="/author/GetAuthorInfo.action?authorId=<s:property value="authorInfoByAuthorId.authorId"/>"
                                   title="<s:property value="authorInfoByAuthorId.authorName"/>">
                                    <s:property value="authorInfoByAuthorId.authorName"/>
                                </a>
                                <s:if test="#authorIteratorStatus.last!=true">,</s:if>
                            </s:iterator>
                        </s:else>
                    </p>

                    <p style="padding: 0px;">
                        <s:if test="bookGenresesByBookId==null || bookGenresesByBookId.size==0">Genres : N.A.</s:if>
                        <s:else>
                            <s:iterator value="bookGenresesByBookId" status="genresStatus">
                                <a href="/search/LoadSearchResults.action?newRequest=true&excludeOutOfStock=false&pageNo=0&maxResults=7&sortBy=0&filterGenre=<s:property value="genresByGenreId.genreName"/>&filterLanguage=&filterPriceRange=5&searchQuery=">
                                    <s:property value="genresByGenreId.genreName"/>
                                </a>
                                <s:if test="#genresStatus.last!=true">,</s:if>
                            </s:iterator>
                        </s:else>
                    </p>

                    <div class="rating-div" id="rating-div<%=buttonId%>" bookId="<s:property value="bookId"/>">
                    </div>
                    <script type="text/javascript">

                        $(document).ready(function() {
                            var userRating='0';

                            var totalRating=0;
                            var totalVotes=<s:property value="bookRatingsByBookId.size()"/>;
                            <s:iterator value="bookRatingsByBookId">
                                totalRating=totalRating+<s:property value="rating"/>;

                                //For user's rating
                                <s:if test="userId!=null && userInfoByUserId.userId.equals(userId)">
                                    userRating = '<s:property value="rating"/>';
                                </s:if>
                            </s:iterator>

                            if(userRating=='0')
                                userRating = 'N.A.';

                            var avgRating=(0.0).toFixed(1);
                            if(totalVotes!=0) {
                                avgRating=(totalRating/totalVotes).toFixed(1);
                            }

                            $('#rating-div<%=buttonId%>').tooltipster({
                                animation: 'fade',
                                trigger:'hover',
                                content:'Avg. Rating : '+avgRating+'<br/>Total Votes : '+totalVotes<s:if test="userId!=null">+'<br/>Your Rating : '+userRating</s:if>
                            });

                            $('#rating-div<%=buttonId%>').raty({
                                half: true,
                                readOnly : true,
                                hints : ['Bad','OK','Good','Nice','Superb'],
                                score:avgRating,
                                click: function(score, evt) {
                                    rateBook(score,$(this).attr('bookId'),'#rating-div<%=buttonId%>');
                                }
                            });

                        });
                    </script>

                    <br/>

                    <span class="price" style="padding-left: 8px;">
                        <s:set var="breakPointsLoop" value="%{false}"/>
                        <s:if test="lendsByBookId !=null && lendsByBookId.size>=1">
                            <s:iterator value="lendsByBookId">
                                <s:if test="%{!#breakPointsLoop && lendStatus!=1}">
                                    <s:property value="sharingPrice"/> Points
                                    <s:set var="breakPointsLoop" value="%{true}"/>
                                </s:if>
                            </s:iterator>
                            <s:if test="%{!#breakPointsLoop}">
                                N.A.
                            </s:if>
                        </s:if>
                        <s:else>N.A.</s:else>
                    </span>


                    <s:set var="breakLoop" value="%{false}"/>
                    <s:if test="lendsByBookId !=null && lendsByBookId.size>=1">
                        <s:iterator value="lendsByBookId">
                            <s:if test="%{!#breakLoop && lendStatus!=1}">
                                <a id="add-to-cart-button<%=buttonId%>" class="button2" style="margin-left: 10px;" href="javascript:{}" title="Add To Cart" onclick="addBookToCart(<s:property value="lendId"/>,'#add-to-cart-button<%=buttonId%>')">Add To Cart</a>
                                <s:set var="breakLoop" value="%{true}"/>
                            </s:if>
                        </s:iterator>
                        <s:if test="%{!#breakLoop}">
                            <a id="request-book-button<%=buttonId%>" class="button2" style="margin-left: 10px;" href="javascript:{}" title="Request Book" onclick="requestBook(<s:property value="bookId"/>,'#request-book-button<%=buttonId%>')" >Request Book</a>
                        </s:if>
                    </s:if>
                    <s:else>
                        <a id="request-book-button<%=buttonId%>" class="button2" style="margin-left: 10px;" href="javascript:{}" title="Request Book" onclick="requestBook(<s:property value="bookId"/>,'#request-book-button<%=buttonId%>')" >Request Book</a>
                    </s:else>

                </div>
                <img src="<s:if test='bookImgUrl==null'>/images/no-book-cover.jpg</s:if><s:else><s:property value="bookImgUrl"/></s:else>"
                     id="pro_img" class="book-image" width="146" height="226" alt="<s:property value="bookTitle"/>" title="<s:property value="bookTitle"/>" />
            </li>
            <%buttonId++;%>
            </s:iterator>
        </ul>
        <div class="clearblock"></div>
    </div>
    <h3>Recently Shared Books</h3>
</div>

<!--Books In Demand-->
<div class="carousel-container">
    <!-- 2nd Carousel -->
    <div class="btnprev" id="btnprev2" ><img src="img/previous_button.png" alt="Prev" /></div>
    <div class="btnnext" id="btnnext2" ><img src="img/next_button.png" alt="Next" /></div>
    <div class="block_content" id="carousel2">
        <ul>
            <s:iterator value="booksInDemand" >
                <li class="ajax_block_product">
                    <div>
                        <h5><a class="product_link ellipsis multiline" style="height: 46px;width:127px;" href="/book/GetBookInfo.action?bookId=<s:property value="bookId"/>" title="<s:property value="bookTitle"/>"><s:property value="bookTitle"/></a></h5>

                        <p class="ellipsis" style="padding: 8px 0 0 0;height: 15px;width: 127px;">
                            <s:if test="bookAuthorsesByBookId==null || bookAuthorsesByBookId.size()==0">N.A.</s:if>
                            <s:else>
                                <span>by,&nbsp;</span>
                                <s:iterator value="bookAuthorsesByBookId" status="authorIteratorStatus">
                                    <a class="product_descr" style="height:3.5em;overflow: visible;"
                                       href="/author/GetAuthorInfo.action?authorId=<s:property value="authorInfoByAuthorId.authorId"/>"
                                       title="<s:property value="authorInfoByAuthorId.authorName"/>">
                                        <s:property value="authorInfoByAuthorId.authorName"/>
                                    </a>
                                    <s:if test="#authorIteratorStatus.last!=true">,</s:if>
                                </s:iterator>
                            </s:else>
                        </p>

                        <p class="ellipsis" style="padding: 0;">
                            <s:if test="bookGenresesByBookId==null || bookGenresesByBookId.size==0">Genres : N.A.</s:if>
                            <s:else>
                                <s:iterator value="bookGenresesByBookId" status="genresStatus">
                                    <a href="/search/LoadSearchResults.action?newRequest=true&excludeOutOfStock=false&pageNo=0&maxResults=7&sortBy=0&filterGenre=<s:property value="genresByGenreId.genreName"/>&filterLanguage=&filterPriceRange=5&searchQuery=">
                                        <s:property value="genresByGenreId.genreName"/>
                                    </a>
                                    <s:if test="#genresStatus.last!=true">,</s:if>
                                </s:iterator>
                            </s:else>
                        </p>

                        <div class="rating-div" id="rating-div<%=buttonId%>" bookId="<s:property value="bookId"/>">
                        </div>
                        <script type="text/javascript">

                            $(document).ready(function() {
                                var userRating='0';

                                var totalRating=0;
                                var totalVotes=<s:property value="bookRatingsByBookId.size()"/>;
                                <s:iterator value="bookRatingsByBookId">
                                totalRating=totalRating+<s:property value="rating"/>;

                                //For user's rating
                                <s:if test="userId!=null && userInfoByUserId.userId.equals(userId)">
                                userRating = '<s:property value="rating"/>';
                                </s:if>
                                </s:iterator>

                                if(userRating=='0')
                                    userRating = 'N.A.';

                                var avgRating=(0.0).toFixed(1);
                                if(totalVotes!=0) {
                                    avgRating=(totalRating/totalVotes).toFixed(1);
                                }

                                $('#rating-div<%=buttonId%>').tooltipster({
                                    animation: 'fade',
                                    trigger:'hover',
                                    content:'Avg. Rating : '+avgRating+'<br/>Total Votes : '+totalVotes<s:if test="userId!=null">+'<br/>Your Rating : '+userRating</s:if>
                                });

                                $('#rating-div<%=buttonId%>').raty({
                                    half: true,
                                    readOnly : true,
                                    hints : ['Bad','OK','Good','Nice','Superb'],
                                    score:avgRating,
                                    click: function(score, evt) {
                                        rateBook(score,$(this).attr('bookId'),'#rating-div<%=buttonId%>');
                                    }
                                });

                            });
                        </script>

                        <br/>

                    <span class="price" style="padding-left: 8px;">
                        <s:set var="breakPointsLoop" value="%{false}"/>
                        <s:if test="lendsByBookId !=null && lendsByBookId.size>=1">
                            <s:iterator value="lendsByBookId">
                                <s:if test="%{!#breakPointsLoop && lendStatus!=1}">
                                    <s:property value="sharingPrice"/> Points
                                    <s:set var="breakPointsLoop" value="%{true}"/>
                                </s:if>
                            </s:iterator>
                            <s:if test="%{!#breakPointsLoop}">
                                N.A.
                            </s:if>
                        </s:if>
                        <s:else>N.A.</s:else>
                    </span>


                        <s:set var="breakLoop" value="%{false}"/>
                        <s:if test="lendsByBookId !=null && lendsByBookId.size>=1">
                            <s:iterator value="lendsByBookId">
                                <s:if test="%{!#breakLoop && lendStatus!=1}">
                                    <a id="add-to-cart-button<%=buttonId%>" class="button2" style="margin-left: 10px;" href="javascript:{}" title="Add To Cart" onclick="addBookToCart(<s:property value="lendId"/>,'#add-to-cart-button<%=buttonId%>')">Add To Cart</a>
                                    <s:set var="breakLoop" value="%{true}"/>
                                </s:if>
                            </s:iterator>
                            <s:if test="%{!#breakLoop}">
                                <a id="request-book-button<%=buttonId%>" class="button2" style="margin-left: 10px;" href="javascript:{}" title="Request Book" onclick="requestBook(<s:property value="bookId"/>,'#request-book-button<%=buttonId%>')" >Request Book</a>
                            </s:if>
                        </s:if>
                        <s:else>
                            <a id="request-book-button<%=buttonId%>" class="button2" style="margin-left: 10px;" href="javascript:{}" title="Request Book" onclick="requestBook(<s:property value="bookId"/>,'#request-book-button<%=buttonId%>')" >Request Book</a>
                        </s:else>

                    </div>
                    <img src="<s:if test='bookImgUrl==null'>/images/no-book-cover.jpg</s:if><s:else><s:property value="bookImgUrl"/></s:else>"
                         id="pro_img" class="book-image" width="146" height="226" alt="<s:property value="bookTitle"/>" title="<s:property value="bookTitle"/>" />
                </li>
                <%buttonId++;%>
            </s:iterator>
        </ul>
        <div class="clearblock"></div>
    </div>
    <h3>Books in Demand</h3>
</div>

<!--Recently Bought Books-->
<div class="carousel-container">
    <div class="btnprev" id="btnprev3" ><img src="img/previous_button.png" alt="Prev" /></div>
    <div class="btnnext" id="btnnext3" ><img src="img/next_button.png" alt="Next" /></div>
    <div class="block_content" id="carousel3">
        <ul>
            <s:iterator value="recentlyBought" >
                <li class="ajax_block_product">
                    <div>
                        <h5><a class="product_link ellipsis" style="height: 30px;width:127px;" href="/book/GetBookInfo.action?bookId=<s:property value="bookId"/>" title="<s:property value="bookTitle"/>"><s:property value="bookTitle"/></a></h5>

                        <p style="padding: 8px 0 0 0;">
                            <s:if test="bookAuthorsesByBookId==null || bookAuthorsesByBookId.size()==0">N.A.</s:if>
                            <s:else>
                                <span>by,&nbsp;</span>
                                <s:iterator value="bookAuthorsesByBookId" status="authorIteratorStatus">
                                    <a class="product_descr" style="height:3.5em;overflow: visible;"
                                       href="/author/GetAuthorInfo.action?authorId=<s:property value="authorInfoByAuthorId.authorId"/>"
                                       title="<s:property value="authorInfoByAuthorId.authorName"/>">
                                        <s:property value="authorInfoByAuthorId.authorName"/>
                                    </a>
                                    <s:if test="#authorIteratorStatus.last!=true">,</s:if>
                                </s:iterator>
                            </s:else>
                        </p>

                        <p style="padding: 0px;">
                            <s:if test="bookGenresesByBookId==null || bookGenresesByBookId.size==0">Genres : N.A.</s:if>
                            <s:else>
                                <s:iterator value="bookGenresesByBookId" status="genresStatus">
                                    <a href="/search/LoadSearchResults.action?newRequest=true&excludeOutOfStock=false&pageNo=0&maxResults=7&sortBy=0&filterGenre=<s:property value="genresByGenreId.genreName"/>&filterLanguage=&filterPriceRange=5&searchQuery=">
                                        <s:property value="genresByGenreId.genreName"/>
                                    </a>
                                    <s:if test="#genresStatus.last!=true">,</s:if>
                                </s:iterator>
                            </s:else>
                        </p>

                        <div class="rating-div" id="rating-div<%=buttonId%>" bookId="<s:property value="bookId"/>">
                        </div>
                        <script type="text/javascript">

                            $(document).ready(function() {
                                var userRating='0';

                                var totalRating=0;
                                var totalVotes=<s:property value="bookRatingsByBookId.size()"/>;
                                <s:iterator value="bookRatingsByBookId">
                                totalRating=totalRating+<s:property value="rating"/>;

                                //For user's rating
                                <s:if test="userId!=null && userInfoByUserId.userId.equals(userId)">
                                userRating = '<s:property value="rating"/>';
                                </s:if>
                                </s:iterator>

                                if(userRating=='0')
                                    userRating = 'N.A.';

                                var avgRating=(0.0).toFixed(1);
                                if(totalVotes!=0) {
                                    avgRating=(totalRating/totalVotes).toFixed(1);
                                }

                                $('#rating-div<%=buttonId%>').tooltipster({
                                    animation: 'fade',
                                    trigger:'hover',
                                    content:'Avg. Rating : '+avgRating+'<br/>Total Votes : '+totalVotes<s:if test="userId!=null">+'<br/>Your Rating : '+userRating</s:if>
                                });

                                $('#rating-div<%=buttonId%>').raty({
                                    half: true,
                                    readOnly : true,
                                    hints : ['Bad','OK','Good','Nice','Superb'],
                                    score:avgRating,
                                    click: function(score, evt) {
                                        rateBook(score,$(this).attr('bookId'),'#rating-div<%=buttonId%>');
                                    }
                                });

                            });
                        </script>

                        <br/>

                    <span class="price" style="padding-left: 8px;">
                        <s:set var="breakPointsLoop" value="%{false}"/>
                        <s:if test="lendsByBookId !=null && lendsByBookId.size>=1">
                            <s:iterator value="lendsByBookId">
                                <s:if test="%{!#breakPointsLoop && lendStatus!=1}">
                                    <s:property value="sharingPrice"/> Points
                                    <s:set var="breakPointsLoop" value="%{true}"/>
                                </s:if>
                            </s:iterator>
                            <s:if test="%{!#breakPointsLoop}">
                                N.A.
                            </s:if>
                        </s:if>
                        <s:else>N.A.</s:else>
                    </span>


                        <s:set var="breakLoop" value="%{false}"/>
                        <s:if test="lendsByBookId !=null && lendsByBookId.size>=1">
                            <s:iterator value="lendsByBookId">
                                <s:if test="%{!#breakLoop && lendStatus!=1}">
                                    <a id="add-to-cart-button<%=buttonId%>" class="button2" style="margin-left: 10px;" href="javascript:{}" title="Add To Cart" onclick="addBookToCart(<s:property value="lendId"/>,'#add-to-cart-button<%=buttonId%>')">Add To Cart</a>
                                    <s:set var="breakLoop" value="%{true}"/>
                                </s:if>
                            </s:iterator>
                            <s:if test="%{!#breakLoop}">
                                <a id="request-book-button<%=buttonId%>" class="button2" style="margin-left: 10px;" href="javascript:{}" title="Request Book" onclick="requestBook(<s:property value="bookId"/>,'#request-book-button<%=buttonId%>')" >Request Book</a>
                            </s:if>
                        </s:if>
                        <s:else>
                            <a id="request-book-button<%=buttonId%>" class="button2" style="margin-left: 10px;" href="javascript:{}" title="Request Book" onclick="requestBook(<s:property value="bookId"/>,'#request-book-button<%=buttonId%>')" >Request Book</a>
                        </s:else>

                    </div>
                    <img src="<s:if test='bookImgUrl==null'>/images/no-book-cover.jpg</s:if><s:else><s:property value="bookImgUrl"/></s:else>"
                         id="pro_img" class="book-image" width="146" height="226" alt="<s:property value="bookTitle"/>" title="<s:property value="bookTitle"/>" />
                </li>
                <%buttonId++;%>
            </s:iterator>
        </ul>
        <div class="clearblock"></div>
    </div>
    <h3>Recently Bought Books</h3>
</div>

<!--Most Shared Books-->
<div class="carousel-container">
    <div class="btnprev" id="btnprev4" ><img src="img/previous_button.png" alt="Prev" /></div>
    <div class="btnnext" id="btnnext4" ><img src="img/next_button.png" alt="Next" /></div>
    <div class="block_content" id="carousel4">
        <ul>
            <s:iterator value="mostSharedBooks" >
                <li class="ajax_block_product">
                    <div>
                        <h5><a class="product_link ellipsis" style="height: 30px;width:127px;" href="/book/GetBookInfo.action?bookId=<s:property value="bookId"/>" title="<s:property value="bookTitle"/>"><s:property value="bookTitle"/></a></h5>

                        <p style="padding: 8px 0 0 0;">
                            <s:if test="bookAuthorsesByBookId==null || bookAuthorsesByBookId.size()==0">N.A.</s:if>
                            <s:else>
                                <span>by,&nbsp;</span>
                                <s:iterator value="bookAuthorsesByBookId" status="authorIteratorStatus">
                                    <a class="product_descr" style="height:3.5em;overflow: visible;"
                                       href="/author/GetAuthorInfo.action?authorId=<s:property value="authorInfoByAuthorId.authorId"/>"
                                       title="<s:property value="authorInfoByAuthorId.authorName"/>">
                                        <s:property value="authorInfoByAuthorId.authorName"/>
                                    </a>
                                    <s:if test="#authorIteratorStatus.last!=true">,</s:if>
                                </s:iterator>
                            </s:else>
                        </p>

                        <p style="padding: 0px;">
                            <s:if test="bookGenresesByBookId==null || bookGenresesByBookId.size==0">Genres : N.A.</s:if>
                            <s:else>
                                <s:iterator value="bookGenresesByBookId" status="genresStatus">
                                    <a href="/search/LoadSearchResults.action?newRequest=true&excludeOutOfStock=false&pageNo=0&maxResults=7&sortBy=0&filterGenre=<s:property value="genresByGenreId.genreName"/>&filterLanguage=&filterPriceRange=5&searchQuery=">
                                        <s:property value="genresByGenreId.genreName"/>
                                    </a>
                                    <s:if test="#genresStatus.last!=true">,</s:if>
                                </s:iterator>
                            </s:else>
                        </p>

                        <div class="rating-div" id="rating-div<%=buttonId%>" bookId="<s:property value="bookId"/>">
                        </div>
                        <script type="text/javascript">

                            $(document).ready(function() {
                                var userRating='0';

                                var totalRating=0;
                                var totalVotes=<s:property value="bookRatingsByBookId.size()"/>;
                                <s:iterator value="bookRatingsByBookId">
                                totalRating=totalRating+<s:property value="rating"/>;

                                //For user's rating
                                <s:if test="userId!=null && userInfoByUserId.userId.equals(userId)">
                                userRating = '<s:property value="rating"/>';
                                </s:if>
                                </s:iterator>

                                if(userRating=='0')
                                    userRating = 'N.A.';

                                var avgRating=(0.0).toFixed(1);
                                if(totalVotes!=0) {
                                    avgRating=(totalRating/totalVotes).toFixed(1);
                                }

                                $('#rating-div<%=buttonId%>').tooltipster({
                                    animation: 'fade',
                                    trigger:'hover',
                                    content:'Avg. Rating : '+avgRating+'<br/>Total Votes : '+totalVotes<s:if test="userId!=null">+'<br/>Your Rating : '+userRating</s:if>
                                });

                                $('#rating-div<%=buttonId%>').raty({
                                    half: true,
                                    readOnly : true,
                                    hints : ['Bad','OK','Good','Nice','Superb'],
                                    score:avgRating,
                                    click: function(score, evt) {
                                        rateBook(score,$(this).attr('bookId'),'#rating-div<%=buttonId%>');
                                    }
                                });

                            });
                        </script>

                        <br/>

                    <span class="price" style="padding-left: 8px;">
                        <s:set var="breakPointsLoop" value="%{false}"/>
                        <s:if test="lendsByBookId !=null && lendsByBookId.size>=1">
                            <s:iterator value="lendsByBookId">
                                <s:if test="%{!#breakPointsLoop && lendStatus!=1}">
                                    <s:property value="sharingPrice"/> Points
                                    <s:set var="breakPointsLoop" value="%{true}"/>
                                </s:if>
                            </s:iterator>
                            <s:if test="%{!#breakPointsLoop}">
                                N.A.
                            </s:if>
                        </s:if>
                        <s:else>N.A.</s:else>
                    </span>


                        <s:set var="breakLoop" value="%{false}"/>
                        <s:if test="lendsByBookId !=null && lendsByBookId.size>=1">
                            <s:iterator value="lendsByBookId">
                                <s:if test="%{!#breakLoop && lendStatus!=1}">
                                    <a id="add-to-cart-button<%=buttonId%>" class="button2" style="margin-left: 10px;" href="javascript:{}" title="Add To Cart" onclick="addBookToCart(<s:property value="lendId"/>,'#add-to-cart-button<%=buttonId%>')">Add To Cart</a>
                                    <s:set var="breakLoop" value="%{true}"/>
                                </s:if>
                            </s:iterator>
                            <s:if test="%{!#breakLoop}">
                                <a id="request-book-button<%=buttonId%>" class="button2" style="margin-left: 10px;" href="javascript:{}" title="Request Book" onclick="requestBook(<s:property value="bookId"/>,'#request-book-button<%=buttonId%>')" >Request Book</a>
                            </s:if>
                        </s:if>
                        <s:else>
                            <a id="request-book-button<%=buttonId%>" class="button2" style="margin-left: 10px;" href="javascript:{}" title="Request Book" onclick="requestBook(<s:property value="bookId"/>,'#request-book-button<%=buttonId%>')" >Request Book</a>
                        </s:else>

                    </div>
                    <img src="<s:if test='bookImgUrl==null'>/images/no-book-cover.jpg</s:if><s:else><s:property value="bookImgUrl"/></s:else>"
                         id="pro_img" class="book-image" width="146" height="226" alt="<s:property value="bookTitle"/>" title="<s:property value="bookTitle"/>" />
                </li>
                <%buttonId++;%>
            </s:iterator>
        </ul>
        <div class="clearblock"></div>
    </div>
    <h3>Most Shared Books</h3>
</div>

</div>