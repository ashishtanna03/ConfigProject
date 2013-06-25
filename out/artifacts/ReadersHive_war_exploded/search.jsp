<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.opensymphony.xwork2.ActionContext" %>
<%@ page import="com.opensymphony.xwork2.util.ValueStack" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sx" uri="/struts-dojo-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <%--<meta content="text/html;charset=utf-8" http-equiv="Content-Type">--%>
    <%--<meta content="utf-8" http-equiv="encoding">--%>

    <title>Search Results - BOOKS STORE</title>


	<meta name="description" content="Our special products" />
	<meta name="keywords" content="special, prices drop" />
	<meta name="generator" content="PrestaShop" />
	<meta name="robots" content="index,follow" />
	<link rel="icon" type="image/vnd.microsoft.icon" href="/img/favicon.ico" />
	<link rel="shortcut icon" type="image/x-icon" href="/img/favicon.ico" />
	
	<link href="/css/global.css" rel="stylesheet" type="text/css" media="all" />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css' />

    <link rel="stylesheet" href="/css/style.css" type="text/css" media="screen" />
  	<link rel="stylesheet" href="/css/slide.css" type="text/css" media="screen" />
	
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	
	<script type="text/javascript" src="/js/jquery/jquery.easing.1.3.js"></script>
	<script type="text/javascript" src="/js/tools.js"></script>
	<script type="text/javascript" src="/js/ajax-request.js"></script>

    <script src="/js/top-panel-input.js" type="text/javascript"></script>

    <sx:head />

    <!--ellipsis-->
    <script type="text/javascript" src="/js/jquery.dotdotdot-1.5.6.js"></script>
    <script type="text/javascript">
        $(function() {
            $(".ellipsis").dotdotdot();
        });
    </script>
		
	<script type="text/javascript" src="/js/tog.js"></script>
	<script src="/js/slide.js" type="text/javascript"></script>
	<!--for lightbox forms-->
	<link rel="stylesheet" type="text/css" href="/js/lightbox/jquery.lightbox.css" />
	<!--[if IE 6]><link rel="stylesheet" type="text/css" href="/javascript/lightbox/themes/default/jquery.lightbox.ie6.css" /><![endif]-->
	<script type="text/javascript" src="/js/lightbox/jquery.lightbox.js"></script>
	<script type="text/javascript">
		jQuery(document).ready(function(){
			jQuery('.share-book').lightbox();
			jQuery('.add-book').lightbox();
		});
  </script>
        <!--star-rating-->
        <style type="text/css">
            .rating-div{float:left;margin-right: -9px;width: 103px!important;}
        </style>
        <script type="text/javascript" src="/js/rating/jquery.raty.min.js"></script>
        <script type="text/javascript">
            $(function(){
                $('.rating-div').raty({
                    half: true,
                    click: function(score, evt) {
                        rateBook(score,$(this).attr('bookId'));
                    }
                });
            });
        </script>
        <!--/star-rating-->

        <!--Tootip-->
        <link href="/css/tooltipster/tooltipster.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="/js/tooltipster/jquery.tooltipster.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                $('.tooltip').tooltipster({
                    animation: 'fade',
                    timer:2000,
                    trigger:'custom'
                });

            });
        </script>
        <!--/Tootip-->

</head>

<body id="prices-drop">

<!--[if lt IE 7]><div style='clear:both;height:59px;padding:0 15px 0 15px;position:relative;z-index:10000;text-align:center;'><a href="http://www.microsoft.com/windows/internet-explorer/default.aspx?ocid=ie6_countdown_bannercode"><img src="http://www.theie6countdown.com/images/upgrade.jpg" border="0" height="42" width="820" alt="You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." /></a></div><![endif]-->
	<div id="wrapper1">
		<div id="wrapper2">
			<div id="wrapper3">

            <!--Top Panel-->
            <s:include value="/top-panel.jsp"/>
			
				<div id="wrapper4">

                <%!
                    Integer maxResults=0;
                    //Integer totalPages=0;
                    Integer pageNo=0;
                    Integer filterPriceRange = 5;
                    String filterGenre="", filterLanguage="";
                    boolean excludeOutOfStock;
                    String searchQuery="";
                    ActionContext actionContext = ActionContext.getContext();
                    ValueStack valueStack = actionContext.getValueStack();
                %>
                <%--<s:set var="totalPages" value="totalPages"/>--%>
                <%
                    //totalPages = (Integer)this.actionContext.getActionInvocation().getStack().getContext().get("totalPages");
                    maxResults = Integer.parseInt(request.getParameter("maxResults"));
//                                        totalPages = (Integer)application.getAttribute("totalPages");
                    //totalPages = (Integer)valueStack.findValue("totalPages");
//                                        pageNo = (Integer)valueStack.findValue("pageNo");
                    pageNo = Integer.parseInt(request.getParameter("pageNo"));

                    filterGenre = request.getParameter("filterGenre");
                    filterLanguage = request.getParameter("filterLanguage");
                    filterPriceRange = Integer.parseInt(request.getParameter("filterPriceRange"));
                    excludeOutOfStock = Boolean.parseBoolean(request.getParameter("excludeOutOfStock"));

                    searchQuery=request.getParameter("searchQuery");
                %>

                <!-- Header -->
                <jsp:include page="/header.jsp" flush="true"/>

					<div id="columns">
						<!-- Left -->
						<div id="left-side-menu1" >
							<h3 >Filter Results</h3>
							<p onclick="slideUpDown('toggleMe');return false;"><a id="toggleMeheader" href="#" >By Genre [-]</a></p>
							<div id="toggleMe" > 
			
								<ul>
                                    <s:iterator value="availGenres">
									    <li>
                                            <a href="/search/LoadSearchResults.action?newRequest=true&pageNo=0&maxResults=<%=maxResults%>&filterGenre=<s:property value="key"/>&filterLanguage=<%=filterLanguage%>&filterPriceRange=<%=filterPriceRange%>&excludeOutOfStock=<%=excludeOutOfStock%>&searchQuery=<s:property value="searchQuery"/>">
                                                <s:property value="key"/> (<s:property value="value"/>)
                                            </a>
                                        </li>
                                    </s:iterator>
                                    <!--<li><a>Education</a></li>
                                    <li><a>computers</a></li>
                                    <li><a>History</a></li>
                                    <li><a>fiction</a></li>
                                    <li><a>Science</a></li>
                                    <li><a>Medical</a></li>
                                    <li><a >Education</a></li>
                                    <li><a >Computers </a></li>
                                    <li><a >Others </a></li>
                                    <li><a >History </a></li>
                                    <li><a >Literary Collections</a></li>
                                    <li><a >Social Science</a></li>
                                    <li><a >Business And Economics </a></li>
                                    <li><a >Fiction </a></li>
                                    <li><a >Science</a></li>
                                    <li><a >Mathematics </a></li>
                                    <li><a >Medical </a></li>
                                    <li><a >Biography And Autobiography </a></li>
                                    <li><a >Technology </a></li>
                                    <li><a >Technology And Engineering</a></li>
                                    <li><a >Travel </a></li>
                                    <li><a >Language Arts And Disciplines </a></li>
                                    <li><a >Nature </a></li>
                                    <li><a >Religion </a></li>
                                    <li><a >Sports And Recreation </a></li>
                                    <li><a >Foreign Language Study </a></li>
                                    <li><a >Juvenile Nonfiction </a></li>
                                    <li><a >Psychology </a></li>
                                    <li><a >Law </a></li>
                                    <li><a >Computer Engineering </a></li>
                                    <li><a >Art </a></li>
                                    <li><a >Poetry </a></li>
                                    <li><a >Programming Languages </a></li>
                                    <li><a >Political Science </a></li>
                                    <li><a >Architecture </a></li>
                                    <li><a >Cooking </a></li>
                                    <li><a >Literary Criticism</a></li>
                                    <li><a >Music </a></li>
                                    <li><a >Study Aids</a></li>
                                    <li><a >Body Mind And Spirit </a></li>
                                    <li><a >Health And Fitness </a></li>
                                    <li><a >Philosophy </a></li>
                                    <li><a >Family And Relationships </a></li>
                                    <li><a >Games </a></li>
                                    <li><a >House And Home </a></li>
                                    <li><a >Humor </a></li>
                                    <li><a >Juvenile Fiction </a></li>
                                    <li><a >Crafts And Hobbies </a></li>
                                    <li><a >Drama </a></li>
                                    <li><a >Non Classifiable </a></li>
                                    <li><a >Reference </a></li>
                                    <li><a >Comics And Graphic Novels </a></li>
                                    <li><a >Computer Science </a></li>
                                    <li><a >Design </a></li>
                                    <li><a >Gardening </a></li>
                                    <li><a >Performing Arts </a></li>
                                    <li><a >Photography </a></li>
                                    <li><a >Self Help </a></li>
                                    <li><a >Antiques And Collectibles </a></li>
                                    <li><a >General </a></li>
                                    <li><a >Management Information Systems </a></li>
                                    <li><a >Programming </a></li>
                                    <li><a >True Crime </a></li>-->

								</ul>
							</div>
							<p onclick="slideUpDown('toggleMe1');return false;"><a href="#" id="toggleMe1header" >By Languages [+]</a></p>
							<div id="toggleMe1" > 
								<ul>
									<s:iterator value="availLanguages">
                                        <li>
                                            <a href="/search/LoadSearchResults.action?newRequest=true&pageNo=0&maxResults=<%=maxResults%>&filterGenre=<%=filterGenre%>&filterLanguage=<s:property value="key"/>&filterPriceRange=<%=filterPriceRange%>&excludeOutOfStock=<%=excludeOutOfStock%>&searchQuery=<s:property value="searchQuery"/>">
                                                <s:property value="key"/> (<s:property value="value"/>)
                                            </a>
                                        </li>
                                    </s:iterator>
									<%--<li><a>Hindi</a></li>
									<li><a>English</a></li>
									<li><a>Tamil</a></li>
									<li><a>Telugu</a></li>
									<li><a>Bengali</a></li>
									<li><a>Punjabi</a></li>
									<li><a>Marathi</a></li>
									<li><a>Bhojpuri</a></li>
									<li><a>Malayalam</a></li>
									<li><a>Kannada</a></li>
									<li><a>All Languages </a></li>--%>
								</ul>
							</div>
							<p onclick="slideUpDown('toggleMe2');return false;"><a href="#" id="toggleMe2header" > By Price[+]</a></p>
							<div id="toggleMe2" >
								<ul>
									<li>
                                        <a href="/search/LoadSearchResults.action?newRequest=true&pageNo=0&maxResults=<%=maxResults%>&filterGenre=<%=filterGenre%>&filterLanguage=<%=filterLanguage%>&filterPriceRange=0&excludeOutOfStock=<%=excludeOutOfStock%>&searchQuery=<s:property value="searchQuery"/>">
                                            Below 200 (<s:property value="availPriceRanges.get(0)"/>)
                                        </a>
                                    </li>
									<li>
                                        <a href="/search/LoadSearchResults.action?newRequest=true&pageNo=0&maxResults=<%=maxResults%>&filterGenre=<%=filterGenre%>&filterLanguage=<%=filterLanguage%>&filterPriceRange=1&excludeOutOfStock=<%=excludeOutOfStock%>&searchQuery=<s:property value="searchQuery"/>">
                                            200-500 (<s:property value="availPriceRanges.get(1)"/>)
                                        </a>
                                    </li>
									<li>
                                        <a href="/search/LoadSearchResults.action?newRequest=true&pageNo=0&maxResults=<%=maxResults%>&filterGenre=<%=filterGenre%>&filterLanguage=<%=filterLanguage%>&filterPriceRange=2&excludeOutOfStock=<%=excludeOutOfStock%>&searchQuery=<s:property value="searchQuery"/>">
                                            500-700  (<s:property value="availPriceRanges.get(2)"/>)
                                        </a>
                                    </li>
									<li>
                                        <a href="/search/LoadSearchResults.action?newRequest=true&pageNo=0&maxResults=<%=maxResults%>&filterGenre=<%=filterGenre%>&filterLanguage=<%=filterLanguage%>&filterPriceRange=3&excludeOutOfStock=<%=excludeOutOfStock%>&searchQuery=<s:property value="searchQuery"/>">
                                            700-1000 (<s:property value="availPriceRanges.get(3)"/>)
                                        </a>
                                    </li>
									<li>
                                        <a href="/search/LoadSearchResults.action?newRequest=true&pageNo=0&maxResults=<%=maxResults%>&filterGenre=<%=filterGenre%>&filterLanguage=<%=filterLanguage%>&filterPriceRange=4&excludeOutOfStock=<%=excludeOutOfStock%>&searchQuery=<s:property value="searchQuery"/>">
                                            Above 1000 (<s:property value="availPriceRanges.get(4)"/>)
                                        </a>
                                    </li>
								</ul>
							</div>
							<p onclick="slideUpDown('toggleMe3');return false;"><a href="#" id="toggleMe3header">Availability[+]</a></p>
							<div id="toggleMe3" >
								<ul>
									<li>
                                        <%
                                            if(!excludeOutOfStock) {
                                        %>
                                        <a href="/search/LoadSearchResults.action?newRequest=true&excludeOutOfStock=true&pageNo=0&maxResults=<%=maxResults%>&filterGenre=<%=filterGenre%>&filterLanguage=<%=filterLanguage%>&filterPriceRange=<%=filterPriceRange%>&searchQuery=<s:property value="searchQuery"/>">
                                            Exclude out of Stock
                                        </a>
                                        <%
                                            } else {
                                        %>
                                        <a href="/search/LoadSearchResults.action?newRequest=true&excludeOutOfStock=false&pageNo=0&maxResults=<%=maxResults%>&filterGenre=<%=filterGenre%>&filterLanguage=<%=filterLanguage%>&filterPriceRange=<%=filterPriceRange%>&searchQuery=<s:property value="searchQuery"/>">
                                            Include out of Stock
                                        </a>
                                        <%
                                            }
                                        %>
                                    </li>
								</ul>
							</div>
						</div><!-- /MODULE Block cart -->
							<!-- Center -->
						<div id="center_column" class="center_column search-center-column">
							<!-- Breadcrumb -->
							<div class="breadcrumb">
								<div class="breadcrumb_inner">
									<a href="/prestashop_37364.html" title="return to Home">Home</a><span class="navigation-pipe">&gt;</span><span class="navigation_page">Search Results</span>
								</div>
							</div>
							<!-- /Breadcrumb --><h1>Search Results for "<s:property value="searchQuery"/>"</h1>
							<a title="Add Book" id="share" class="add-book" href="/lightbox-pages/add-book.htm?lightbox[width]=362&lightbox[height]=403">Add Book</a>
							<form id="productsSortForm" action="search.jsp">
								<select id="selectPrductSort">
									<option value="position:asc" selected="selected">--</option>
									<option value="price:asc" >Price: lowest first</option>
									<option value="price:desc" >Price: highest first</option>
									<option value="name:asc" >Product Name: A to Z</option>
									<option value="name:desc" >Product Name: Z to A</option>
									<option value="quantity:desc" >In-stock first</option>
								</select>
								<label for="selectPrductSort">Sort by</label>
							</form>
							<!-- /Sort products -->
									<!-- Products list -->
									<ul id="product_list" class="clear">
                                        <script type="text/javascript">
                                            var totalVotes= 0,totalRating=0;
                                        </script>
                                       <s:iterator value="bookList" status="iteratorStatus">
                                           <script type="text/javascript">
                                               //totalRating=0;
                                               //totalVotes=1;
                                           </script>
										<li class="ajax_block_product first_item item clearfix">
											<a href="/book/GetBookInfo.action?bookId=<s:property value='bookId'/>" class="product_img_link" title="<s:property value='bookTitle'/> "><img src='<s:if test='bookImgUrl==null'>/images/no-book-cover.jpg</s:if><s:else><s:property value="bookImgUrl"/></s:else>' alt="<s:property value="bookTitle"/>"  width="146" height="226" /></a>
											
											<div class="center_block">
												<p class="search-title" style="height:46px;">
                                                    <a class="product_link ellipsis" style="height:17px;width: 320px;" href="/book/GetBookInfo.action?bookId=<s:property value='bookId'/>" title="<s:property value='bookTitle'/>"><s:property value='bookTitle'/></a><br/>
                                                    <span style="float:left;">&nbspby&nbsp&nbsp</span>
                                                    <s:iterator value="bookAuthorsesByBookId" status="authorIteratorStatus">
                                                        <a class="author_link ellipsis" style="overflow: hidden;" href="/author/GetAuthorInfo.action?authorId=<s:property value="authorInfoByAuthorId.authorId"/>">
                                                            <s:property value="authorInfoByAuthorId.authorName"/>
                                                        </a>
                                                        <s:if test="#authorIteratorStatus.last!=true">,</s:if>
                                                    </s:iterator>
                                                </p>
                                                <%--<p class="search-title ellipsis" style="height:46px;overflow: hidden;">
                                                    <a class="product_link" href="/book/GetBookInfo.action?bookId=<s:property value='bookId'/>" title="<s:property value='bookTitle'/>"><s:property value="bookTitle"/>adgh adgah adsgh </a>
                                                    <span style="float:left;">&nbsp&nbsp by &nbsp&nbsp</span>
                                                    <a class="author_link" href="#"><s:property value="authorInfo.authorName"/></a>
                                                </p>--%>



												<div id="short_description_block">
													<div id="short_description_content" >
                                                        <div class="rating-div" bookId="<s:property value="bookId"/>">
                                                        </div>
                                                        <script type="text/javascript">
                                                            $(document).ready(function() {
                                                                totalRating=0;totalVotes=0;
                                                            totalVotes=<s:if test="bookRatingsByBookId.size()==0">1;</s:if><s:else><s:property value="bookRatingsByBookId.size()"/>;</s:else>
                                                            <s:iterator value="bookRatingsByBookId">
                                                                totalRating=totalRating+<s:property value="rating"/>;
                                                            </s:iterator>

                                                                $($('.rating-div').get(<s:property value="%{#iteratorStatus.index}"/>)).raty('set',{score:totalRating/totalVotes});
                                                            });
                                                        </script>
														<h3>&nbsp(<s:property value="bookRatingsByBookId.size()"/> votes)</h3>
														<h2>&nbsp|&nbsp<a id="search-header" href="javascript:{}"><s:property value="bookReviewsByBookId.size()"/> Reviews</a></h2>
														<br/>
														<p>
															<b>Publisher : </b><s:property value='publisherInfoByPublisherId.publisherName'/>(<s:date name="publishingDate" format="yyyy"/>)<br/>
															<b>ISBN-10 : </b><s:property value='isbn10'/><br/>
															<b>ISBN-13 : </b><s:property value='isbn13'/><br/>
															<b>Format : </b><s:property value="bookFormat"/><br/>
															<b>Language : </b><s:property value='bookLanguage'/><br/>
															<b>No. of Pages : </b><s:property value='noOfPages'/>
															<br/><br/>
														</p>
													</div>
												</div>
												<div class="product_flags">
                                                    <s:set var="breakAvailLoop" value="%{false}"/>
                                                    <s:if test="lendsByBookId !=null && lendsByBookId.size>=1">
                                                        <s:iterator value="lendsByBookId">
                                                            <s:if test="%{!#breakAvailLoop && lendStatus!=1}">
													            <span class="available">Available</span>
                                                                <s:set var="breakAvailLoop" value="%{true}"/>
                                                            </s:if>
                                                        </s:iterator>
                                                        <s:if test="%{!#breakAvailLoop}">
                                                            <span class="not-avail">Not Available</span>
                                                        </s:if>
                                                    </s:if>
                                                    <s:else>
													    <span class="not-avail">Not Available</span>
                                                    </s:else>
												</div>
												
											</div>
											<div class="right_block">
											
												<span class="lowest-price-header">Lowest Price</span>
                                                <span class="price">
                                                <s:set var="breakPointsLoop" value="%{false}"/>
                                                    <s:if test="lendsByBookId !=null && lendsByBookId.size>=1">
                                                        <s:iterator value="lendsByBookId">
                                                            <s:if test="%{!#breakPointsLoop && lendStatus!=1}">
                                                                <s:property value="lendsByBookId.get(0).sharingPrice"/> points
                                                                <s:set var="breakPointsLoop" value="%{true}"/>
                                                            </s:if>
                                                        </s:iterator>
                                                        <s:if test="%{!#breakPointsLoop}">
                                                            N.A.
                                                        </s:if>
                                                    </s:if>
                                                    <s:else>N.A.</s:else>
                                                </span>
												<br/><br/>
                                                <s:set var="breakLoop" value="%{false}"/>
                                                <s:if test="lendsByBookId !=null && lendsByBookId.size>=1">
                                                    <s:iterator value="lendsByBookId">
                                                        <s:if test="%{!#breakLoop && lendStatus!=1}">
												            <a id="add-to-cart-button<s:property value="%{#iteratorStatus.index}"/>" class="avail-button" href="javascript:{}" title="Add To Cart" onclick="addBookToCart(<s:property value="lendId"/>,'#add-to-cart-button<s:property value="%{#iteratorStatus.index}"/>')">Add To Cart</a>
                                                            <s:set var="breakLoop" value="%{true}"/>
                                                        </s:if>
                                                    </s:iterator>
                                                    <s:if test="%{!#breakLoop}">
                                                        <a class="avail-button" href="#" title="Request Book">Request Book</a>
                                                    </s:if>
                                                </s:if>
                                                <s:else>
												    <a class="avail-button" href="#" title="Request Book">Request Book</a>
                                                </s:else>
												<a class="avail-button" href="#" title="Add to Wishlist">Add to Wishlist</a>
												<a class="avail-button share-book"  title="Share book" href="/lightbox-pages/share-book.jsp?lightbox[width]=362&lightbox[height]=338&bookId=<s:property value="bookId"/>">Share</a>
											</div>
										</li>
                                        </s:iterator>

									</ul>
									<!-- /Products list -->

							<!-- Pagination -->
                            <div id="pagination" class="pagination">

                                <s:set var="searchQuery" value="searchQuery"/>
                                 <ul id="page-list" class="pagination">

                                     <script type="text/javascript">
                                         var maxResults = <%=maxResults%>;
                                         var pageNo = <%=pageNo%>;
                                         var totalPages = <s:property value="totalPages"/>;

                                         var pageList = '';


                                         if(pageNo==0) {
                                             pageList += '<li id="pagination_previous" class="disabled"><span>&laquo;&nbsp;Previous</span></li>';
                                         } else {
                                             pageList += '<li id="pagination_previous"><a href="/search/LoadSearchResults.action?pageNo='+(pageNo-1)+'&maxResults='+maxResults+'&totalPages='+totalPages+'&filterGenre=<%=filterGenre%>&filterLanguage=<%=filterLanguage%>&filterPriceRange=<%=filterPriceRange%>&excludeOutOfStock=<%=excludeOutOfStock%>&searchQuery=<s:property value="searchQuery"/>">&laquo;&nbsp;Previous</a></li>';
                                         }
                                         for(var i=0; i <totalPages ; i++) {
                                             if(i==pageNo) {
                                                 pageList += '<li class="current"><span>'+(pageNo+1)+'</span></li>';
                                             } else {
                                                 pageList += '<li><a href="/search/LoadSearchResults.action?pageNo='+i+'&maxResults='+maxResults+'&totalPages='+totalPages+'&filterGenre=<%=filterGenre%>&filterLanguage=<%=filterLanguage%>&filterPriceRange=<%=filterPriceRange%>&excludeOutOfStock=<%=excludeOutOfStock%>&searchQuery=<s:property value="searchQuery"/>">'+(i+1)+'</a></li>';
                                             }
                                         }

                                         if(pageNo+1==totalPages) {
                                             pageList += '<li id="pagination_next" class="disabled"><span>Next&nbsp;&raquo;</span></li>';
                                         } else {
                                             pageList += '<li id="pagination_next"><a href="/search/LoadSearchResults.action?pageNo='+(pageNo+1)+'&maxResults='+maxResults+'&totalPages='+totalPages+'&filterGenre=<%=filterGenre%>&filterLanguage=<%=filterLanguage%>&filterPriceRange=<%=filterPriceRange%>&excludeOutOfStock=<%=excludeOutOfStock%>&searchQuery=<s:property value="searchQuery"/>">Next&nbsp;&raquo;</a></li>';
                                         }

                                         document.getElementById('page-list').innerHTML = pageList;
                                     </script>

                                     <%--<%
                                         if(pageNo==0){
                                     %>
                                         <li id="pagination_previous" class="disabled">
                                             <span>&laquo;&nbsp;Previous</span>
                                         </li>
                                     <%
                                         }
                                         else{
                                     %>
                                         <li id="pagination_previous">
                                             <a href="/search/LoadSearchResults.action?pageNo=<%=pageNo-1%>&maxResults=<%=maxResults%>&totalPages=<s:property value="totalPages"/>&filterGenre=<%=filterGenre%>&filterLanguage=<%=filterLanguage%>&filterPriceRange=<%=filterPriceRange%>&searchQuery=<s:property value="searchQuery"/>">&laquo;&nbsp;Previous</a>
                                         </li>
                                     <% } %>
                                     <s:iterator begin="0" end="%{#totalPages-1}" status="forLoopStatus">
                                     <s:if test="%{#forLoopStatus==pageNo}">
                                         <li class="current">
                                         <span>
                                             <%=pageNo+1%>
                                         </span>
                                         </li>
                                     </s:if>
                                     <s:else>

                                     <li>
                                         <a href="/search/LoadSearchResults.action?pageNo=<s:property value="forLoopStatus"/>&maxResults=<%=maxResults%>&totalPages=<s:property value="totalPages"/>&filterGenre=<%=filterGenre%>&filterLanguage=<%=filterLanguage%>&filterPriceRange=<%=filterPriceRange%>&searchQuery=<s:property value="searchQuery"/>">
                                             <s:property value="%{#totalPages+1}"/>
                                         </a>
                                     </li>
                                     </s:else>
                                     </s:iterator>
                                     <s:if test="%{#pageNo+1==totalPages}">
                                     <li id="pagination_next" class="disabled">
                                         <span>Next&nbsp;&raquo;</span>
                                     </li>
                                     </s:if>
                                     <s:else>
                                     <li id="pagination_next">
                                         <a href="/search/LoadSearchResults.action?pageNo=<%=pageNo+1%>&maxResults=<%=maxResults%>&totalPages=<s:property value="totalPages"/>&filterGenre=<%=filterGenre%>&filterLanguage=<%=filterLanguage%>&filterPriceRange=<%=filterPriceRange%>&searchQuery=<s:property value="searchQuery"/>">Next&nbsp;&raquo;</a>
                                     </li>
                                     </s:else>--%>
                                 </ul>
                                <form id="pagination_form"
                                      action="/search/LoadSearchResults.action"
                                      method="get" class="pagination">

                                    <input type="hidden" name="searchQuery" value="<s:property value="searchQuery"/>" />
                                    <input type="hidden" name="pageNo" value="<%=pageNo%>" />
                                    <input type="hidden" name="newRequest" value="true" />
                                    <input type="hidden" name="filterGenre" value="<%=filterGenre%>" />
                                    <input type="hidden" name="filterLanguage" value="<%=filterLanguage%>" />
                                    <input type="hidden" name="filterPriceRange" value="<%=filterPriceRange%>" />

                                    <a class="button_mini"
                                       href="javascript:document.getElementById('pagination_form').submit();">Ok</a>
                                    <label for="nb_item">items:</label>
                                    <select name="maxResults" id="nb_item">
                                        <option value="7" selected="selected">7</option>
                                        <option value="10">10</option>
                                    </select>
                                </form>
                            </div>
							<!-- /Pagination -->
		
		
						</div>
								<div class="clearblock"></div>
							</div>
						</div>
				<!-- Footer -->
				<div id="footer_wrapper">
					<div id="footer">
						<div id="tmfooterlinks">
							<div>
								<h4>Information</h4>
								<ul>
									<li><a href="/contact-form.htm">Contact</a></li>
									<li><a href="/cms.htm">Delivery</a></li>
									<li><a href="/cms_2.htm">Legal Notice</a></li>
									<li><a href="/cms_3.htm">Terms and conditions</a></li>
									<li><a href="/cms_4.htm">About us</a></li>
								</ul>
							</div>
							<div>
								<h4>Our offers</h4>
								<ul>
									<li><a href="/new-products.htm">New products</a></li>
									<li><a href="/best-sales.htm">Top sellers</a></li>
									<li><a href="/search.jsp">Specials</a></li>
									<li><a href="/manufacturer.htm">Manufacturers</a></li>
									<li><a href="/supplier.htm">Suppliers</a></li>
								</ul>
							</div>
							<div>
								<h4>Your Account</h4>
								<ul>
									<li><a href="http://livedemo00.template-help.com/prestashop_37364/my-account.php">Your Account</a></li>
									<li><a href="http://livedemo00.template-help.com/prestashop_37364/identity.php">Personal information</a></li>
									<li><a href="http://livedemo00.template-help.com/prestashop_37364/addresses.php">Addresses</a></li>
									<li><a href="http://livedemo00.template-help.com/prestashop_37364/discount.php">Discount</a></li>
									<li><a href="http://livedemo00.template-help.com/prestashop_37364/history.php">Order history</a></li>
								</ul>
							</div>
							<p>&copy; 2012 Powered by <a href="#">JUSDIAS Inc</a>. All rights reserved</p>
						</div><!-- tmsocial -->
						<div id="tmsocial">
							<a class="banner1" href='http://livedemo00.template-help.com/twitter.com/twitter_default_2.html'><img src='/modules/tmsocial/slides/slide_00.png'alt="" title="" /></a>
							<a class="banner2" href='http://facebook.com'><img src='/modules/tmsocial/slides/slide_01.png' alt="" title="" /></a>
						</div>
						<!-- /tmsocial -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="/js/ga.js"></script>
</body>
</html>
