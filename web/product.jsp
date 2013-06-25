<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sx" uri="/struts-dojo-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<title><s:property value="book.bookTitle"/> - Reader's Hive</title>
		
	<meta name="description" content="<s:property value="book.bookDescription"/>" />
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
	<meta name="generator" content="PrestaShop" />
	<meta name="robots" content="index,follow" />
	
	<meta content="text/html;charset=utf-8" http-equiv="Content-Type"/>
	<meta content="utf-8" http-equiv="encoding"/>
	
	<link rel="icon" type="image/vnd.microsoft.icon" href="/img/favicon.ico" />
	<link rel="shortcut icon" type="image/x-icon" href="/img/favicon.ico" />

	<link href="/css/global.css" rel="stylesheet" type="text/css" media="all" />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css' />

    <link href="/css/jquery.fancybox-1.3.4.css" rel="stylesheet" type="text/css" media="screen" />

	<link rel="stylesheet" href="/css/style.css" type="text/css" media="screen" />
  	<link rel="stylesheet" href="/css/slide.css" type="text/css" media="screen" />
	
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.easing.1.3.js"></script>
	<%--<script type="text/javascript" src="/js/tools.js"></script>--%>
	<script type="text/javascript" src="/js/jquery/jquery.fancybox-1.3.4.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery.idTabs.modified.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery.scrollTo-1.4.2-min.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery.serialScroll-1.2.2-min.js"></script>
	<%--<script type="text/javascript" src="/js/tools2.js"></script>--%>
	<script type="text/javascript" src="/js/product.js"></script>

    <sx:head />

	<script type="text/javascript" src="/js/ajax-request.js"></script>

    <script src="/js/top-panel-input.js" type="text/javascript"></script>

    <script type="text/javascript">
        var step=Math.floor(<s:property value="suggestedBooks.size()"/>/5);
    </script>
	<script type="text/javascript" src="/js/jquery/related-carousel.js"></script>
	<script type="text/javascript">
        jQuery(document).ready(function() {
            jQuery(".ajax_block_product").hover(function() {
                jQuery(this).find(".related-img").stop().animate({ "marginLeft" : "-120px"}, 300);
			}, function() {
                jQuery(this).find("img").stop().animate({ "marginLeft":"0px"}, 200);
			});
		});
	</script>

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

    <!--ellipsis-->
    <script type="text/javascript" src="/js/jquery.dotdotdot-1.5.6.js"></script>
    <script type="text/javascript">
        $(function() {
            $(".ellipsis").dotdotdot();
        });
    </script>
    <!--/ellipsis-->

    <!--star-rating-->
    <style type="text/css">
        .rating-div{float:left;margin-right: -9px;width: 112px!important;}
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
    <style type="text/css">div.carousel-rating img {width: 14px!important;height: 14px!important;float:left;}</style>
    <!--/star-rating-->

	<script src="/js/slide.js" type="text/javascript"></script>
	<!--for lightbox forms-->
	<link rel="stylesheet" type="text/css" href="/js/lightbox/jquery.lightbox.css" />
	<!--[if IE 6]><link rel="stylesheet" type="text/css" href="/javascript/lightbox/themes/default/jquery.lightbox.ie6.css" /><![endif]-->
	<script type="text/javascript" src="/js/lightbox/jquery.lightbox.js"></script>
	<script type="text/javascript">
		jQuery(document).ready(function(){
			jQuery('.share-book').lightbox();
		});
  </script>
</head>
<body id="product">
	<!--[if lt IE 7]><div style='clear:both;height:59px;padding:0 15px 0 15px;position:relative;z-index:10000;text-align:center;'><a href="http://www.microsoft.com/windows/internet-explorer/default.aspx?ocid=ie6_countdown_bannercode"><img src="http://www.theie6countdown.com/images/upgrade.jpg" border="0" height="42" width="820" alt="You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." /></a></div><![endif]-->
	<div id="wrapper1">
		<div id="wrapper2">
			<div id="wrapper3">

            <!--Top Panel-->
            <s:include value="/top-panel.jsp"/>

            <div id="wrapper4">

            <!-- Header -->
            <jsp:include page="/header.jsp" flush="true"/>

					<div id="columns" class="center_column" style="width:720px;">
						
						<!-- Center -->
						<div id="center_column" >
							<!-- Breadcrumb -->
							<div class="breadcrumb">
								<div class="breadcrumb_inner">
									<a href="/index.jsp" title="return to Home">Home</a>
									<span class="navigation-pipe">&gt;</span>
									<a href="/category.htm" title="Books">Books</a>
									<span class="navigation-pipe">></span>
									<a href="/category_2.htm" title="Arts &amp; Photography">Arts &amp; Photography</a>
									<span class="navigation-pipe">></span>
									Sed at libero lobortis donec mauris
								</div>
							</div>
							<!-- /Breadcrumb -->
							<div id="primary_block" class="clearfix">
                                <h1>
                                    <s:property value="book.bookTitle"/>
                                    <s:if test="book.bookAuthorsesByBookId!=null && book.bookAuthorsesByBookId.size>0">
                                        <span>&nbsp;by&nbsp;</span>
                                        <s:iterator value="book.bookAuthorsesByBookId" status="iteratorStatus">
                                            <a href="javascript:{}" title="<s:property value="authorInfoByAuthorId.authorName"/>">
                                                <s:property value="authorInfoByAuthorId.authorName"/>
                                            </a>
                                            <s:if test="#iteratorStatus.last!=true">,</s:if>
                                        </s:iterator>
                                    </s:if>
                                </h1>
								<br/>
                                <s:if test="book.bookSubtitle!=null">
								    <h2 id="subtitle"><s:property value="book.bookSubtitle"/></h2>
                                </s:if>
								<br/>
								<!-- right infos-->
								<div id="pb-right-column">
									<!-- product img-->
									<div id="image-block">
										<a href='<s:if test='book.bookImgUrl==null'>/images/no-book-cover.jpg</s:if><s:else><s:property value="book.bookImgUrl"/></s:else>'
                                           rel="other-views" class="thickbox shown" title="<s:property value="book.bookTitle"/>">
											<img src='<s:if test='book.bookImgUrl==null'>/images/no-book-cover.jpg</s:if><s:else><s:property value="book.bookImgUrl"/></s:else>'
                                                    title="<s:property value="book.bookTitle"/>" alt="<s:property value="book.bookTitle"/>" id="bigpic" width="300" height="450" />
										</a>
										<div id="price-tag">
											<div>
												<a id="price-tag-a" href="#" >Price : <s:if test="book.lendsByBookId!=null && book.lendsByBookId.size()>=0"><s:property value="book.lendsByBookId.get(0).sharingPrice"/> Points</s:if><s:else>N.A.</s:else></a>
											</div>
                                            <s:if test="book.lendsByBookId!=null">
											<div id="tooltip1">
												<p>This is the <b>Lowest Price</b> among other <a href="javascript:{}" ><s:property value="book.lendsByBookId.size()"/></a> prices. <a href="javascript:{}" >More Prices</a></p>
											</div>
                                            </s:if>
										</div>

									</div>
								</div>
								<!-- left infos-->
								<div id="pb-left-column">
									<div id="short_description_block">
										<div id="short_description_content" class="rte align_justify">
                                            <div class="rating-div" id="rating-div" bookId="<s:property value="book.bookId"/>">
                                            </div>
											<%--<img src="/img/star.png"/>
											<img src="/img/star.png"/>
											<img src="/img/star.png"/>
											<img src="/img/star.png"/>
											<img src="/img/star.png"/>--%>
											<h7>&nbsp<s:property value="book.bookRatingsByBookId.size()"/> Votes</h7>
											<h2>&nbsp| <a id="review-header" href="javascript:{}"><s:if test="book.bookReviewsByBookId!=null"><s:property value="book.bookReviewsByBookId.size()"/></s:if><s:else>0</s:else> Customer Review</a> ( <a id="write-a-review"href="javascript:{}">Write a Review</a> )</h2>
											<br/>
											<h3>
												Publisher :&nbsp;
                                                <s:if test="book.bookSubTitle==null">
                                                    N.A.
                                                </s:if>
                                                <s:else>
                                                    <a id="publisher-link" href="#"><s:property value="book.publisherInfoByPublisherId.publisherName"/></a>&nbsp;
                                                    <s:if test="book.publishingDate!=null">(<s:date name="book.publishingDate" format="yyyy"/>)</s:if>
                                                </s:else>
											</h3>

											<script type="text/javascript" src="http://books.google.com/books/previewlib.js"></script>
											<script type="text/javascript">
												GBS_insertPreviewButtonPopup('ISBN:<s:if test="isbn10==null"><s:property value="isbn10"/></s:if><s:else><s:property value="isbn13"/></s:else>');
											</script>

											<br/><br/><br/>
											<h3>Genres :&nbsp;
                                                <s:if test="book.bookGenresesByBookId==null || book.bookGenresesByBookId.size==0">N.A.</s:if>
                                                <s:else>
                                                    <s:iterator value="book.bookGenresesByBookId" status="iteratorStatus">
                                                        <a href="#">
                                                            <s:property value="genresByGenreId.genreName"/>
                                                        </a>
                                                        <s:if test="#iteratorStatus.last!=true">,</s:if>
                                                    </s:iterator>
                                                </s:else>
                                            </h3>

										</div>
									</div>
									<!-- add to cart form-->
									<form id="buy_block"  action="cart.htm" method="post">


										<!-- prices -->
										<!--<p class="price">
											<span class="on_sale">Lowest Price:</span>
											<span class="our_price_display">
												<span id="our_price_display" class="price">$13.00</span>
											</span>
										</p>-->
										<br/>
										<!-- number of item in stock -->
										<p id="pQuantityAvailable">
											<b>Available :</b>&nbsp;<s:if test="book.lendsByBookId.size()>1">Yes</s:if><s:else>No</s:else>
										</p>

										<br/><br/>
										<p id="ISBN-10"><b>ISBN-10 : </b>
                                            <s:if test="book.isbn10==null">N.A.</s:if>
                                            <s:else><s:property value="book.isbn10"/></s:else>
                                        </p>
										<br/><br/>
										<p id="ISBN-13"><b>ISBN-13 : </b>
                                            <s:if test="book.isbn13==null">N.A.</s:if>
                                            <s:else><s:property value="book.isbn13"/></s:else>
                                        </p>
										<br/><br/>
										<p id="language"><b>Language : </b>
                                            <s:if test="book.bookLanguage==null">N.A.</s:if>
                                            <s:else><s:property value="book.bookLanguage"/></s:else>
                                        </p>
										<br/><br/>
										<p id="no-of-pages"><b>No. of Pages : </b>
                                            <s:if test="book.noOfPages==null">N.A.</s:if>
                                            <s:else><s:property value="book.noOfPages"/></s:else>
                                        </p>

										<div class="clearblock"></div>
									</form>

									<!-- RATINGS STATISTICS -->
									<div class="rating-stats">
										<h2>Rating Stats :</h2>
                                        <script type="text/javascript">
                                            var noOf5s=0,noOf4s=0,noOf3s=0,noOf2s=0,noOf1s=0;
                                            var totalVotes=<s:property value="book.bookRatingsByBookId.size()"/>;
                                            var totalRating=0;
                                            <s:iterator value="book.bookRatingsByBookId">
                                            totalRating+=<s:property value='rating'/>;
                                                <s:if test="rating==5 || rating==4.5">noOf5s++;</s:if>
                                                <s:if test="rating==4 || rating==3.5">noOf4s++;</s:if>
                                                <s:if test="rating==3 || rating==2.5">noOf3s++;</s:if>
                                                <s:if test="rating==2 || rating==1.5">noOf2s++;</s:if>
                                                <s:if test="rating==1 || rating==0.5">noOf1s++;</s:if>
                                            </s:iterator>

//                                            $('#rating-div').attr('averageRating',totalRating/totalVotes);
                                        </script>
										<table>
											<tr>
												<td>5 star</td>
												<td class="bar">
													<img src="/images/blank.png" id="bar5" />
												</td>
												<td name="barValue"></td>
											</tr>

											<tr>
												<td>4 star</td>
												<td class="bar">
													<img src="/images/blank.png" id="bar4" />
												</td>
												<td name="barValue"></td>
											</tr>

											<tr>
												<td>3 star</td>
												<td class="bar">
													<img src="/images/blank.png" id="bar3" />
												</td>
												<td name="barValue"></td>
											</tr>

											<tr>
												<td>2 star</td>
												<td class="bar">
													<img src="/images/blank.png" id="bar2" />
												</td>
												<td name="barValue"></td>
											</tr>

											<tr>
												<td>1 star</td>
												<td class="bar">
													<img src="/images/blank.png" id="bar1" />
												</td>
												<td name="barValue"></td>
											</tr>
										</table>
                                        <script type="text/javascript">
                                            $(document).ready(function() {
                                            $('.rating-div').raty('set',{score:totalRating/totalVotes});

                                            $("#bar5").width((noOf5s/totalVotes)*100);
                                            $("#bar4").width((noOf4s/totalVotes)*100);
                                            $("#bar3").width((noOf3s/totalVotes)*100);
                                            $("#bar2").width((noOf2s/totalVotes)*100);
                                            $("#bar1").width((noOf1s/totalVotes)*100);

                                            document.getElementsByName('barValue')[0].innerHTML = noOf5s;
                                            document.getElementsByName('barValue')[1].innerHTML = noOf4s;
                                            document.getElementsByName('barValue')[2].innerHTML = noOf3s;
                                            document.getElementsByName('barValue')[3].innerHTML = noOf2s;
                                            document.getElementsByName('barValue')[4].innerHTML = noOf1s;
                                            });
                                        </script>
									</div><!-- END Rating stats -->

									<br/><br/>


                                    <s:if test="lendList !=null && lendList.size>=1">
                                        <a id="add-to-cart-button" class="button2" href="javascript:{}" style="margin-top:15px;" onclick="addBookToCart(<s:property value="lendList.get(0).lendId"/>,'#add-to-cart-button')">Add to Cart</a>
                                    </s:if>
                                    <s:else>
                                        <a id="request-book-button" class="button2" href="javascript:{}" style="margin-top:15px;" onclick="requestBook(<s:property value="book.bookId"/>,'#request-book-button')">Request Book</a>
                                    </s:else>

									<a href="javascript:{}" id="add_to_wishlist" onclick="addBookToWishList(<s:property value="book.bookId"/>, '#add_to_wishlist')">Add to WishList</a>
									<div id="share">
										<a href="/lightbox-pages/share-book.jsp?lightbox[width]=362&lightbox[height]=338&bookId=<s:property value="book.bookId"/>" class="share-book" id="share">Share</a>
										<div id="tooltip2">
											<p>If you have same book, You can <b>Share</b> it for Free & can <b>Earn</b> some points to buy another Book using it.</p>
										</div>
									</div>
								</div>
							</div>


							<br/>


							<!-- description and features -->
							<div id="more_info_block" class="clear">
								<ul id="more_info_tabs" class="idTabs idTabsShort">
									<li><a id="more_info_tab_desc" href="/product.jsp#idTab1">Description</a></li>
									<li><a id="more_info_tab_about_author" href="/product.jsp#idTab3">About Author</a></li>
									<li>
                                        <a id="more_info_tab_data_sheet" href="/product.jsp#idTab4">
                                            Available Copies (<s:if test="lendList!=null && lendList.size()>0"><s:property value="lendList.size()"/></s:if><s:else>0</s:else>)
                                        </a>
                                    </li>
								</ul>
								<div id="more_info_sheets" class="tabs_content">
									<!-- full description -->
									<div id="idTab1"><p><s:property value="book.bookDescription"/> </p></div>
									<!-- product's features -->

									<div id="idTab3">
										<p>
                                            <s:iterator value="book.bookAuthorsesByBookId" status="iteratorStatus">
                                                <b><s:property value="authorInfoByAuthorId.authorName"/> :<br/></b>
                                                <s:property value="authorInfoByAuthorId.authorDescription"/>
                                                <s:if test="#iteratorStatus.last!=true"><br/><br/></s:if>
                                            </s:iterator>
                                        </p>
									</div>

									<div id="idTab4">
                                        <s:if test="lendList==null || lendList.size()==0"><center><b>No one has shared this Book.</b></center></s:if>
                                        <s:else>
										<table id="avail-copies">
											<tr>
												<th></th>
												<th></th>
												<th class="condition avail-header" >Condition</th>
												<th class="avail-header">Price</th>
												<th></th>
											</tr>

                                            <s:iterator value="lendList">

											<tr>
												<td class="avail-prof-pic"><img src="<s:if test="userInfoByUserId.userImg==null">/images/no-profile-pic.png</s:if><s:else><s:property value="userInfoByUserId.userImg"/></s:else>"/></td>
												<td>
													<a class="avail-user" href="/user/UserProfile.action?emailId=<s:property value="userInfoByUserId.loginInfoByEmailId.emailId"/>"><s:property value="userInfoByUserId.firstName"/> <s:property value="userInfoByUserId.lastName"/></a><br/>
													Reputation (Votes)
													<b>Books Shared</b> : <s:property value="userInfoByUserId.lendsByUserId.size()"/>
												</td>
												<td class="condition">
													<b>Condition</b> : <s:property value="conditionRating"/> stars
													<p><b>Description</b> : <s:property value="conditionDescription"/></p>
												</td>
												<td class="avail-price">
													<s:property value="sharingPrice"/> Points
												</td>
												<td id="avail-cart">
													<a id="add_to_cart" href="#">Add to cart</a>
												</td>
											</tr>
                                            </s:iterator>
										</table>
                                        </s:else>
									</div>

								</div>
							</div>
							<%--<br/>
							<br/>
                            <s:if test="suggestedBooks.size()!=0" >
							<h2 id="related-header">Users who bought this book suggested below books :</h2>
							<div id="related-products_block_center">
							<div class="related-carousel-container">

								<div class="related_btnprev" id="related_btnprev1" ><img src="/images/blank.png" width="12px" height="19px" alt="Prev" /></div>
								<div class="related_btnnext" id="related_btnnext1" ><img src="/images/blank.png" width="12px" height="19px" alt="Next" /></div>
								<div class="related_content" id="carousel1">
									<ul>
                                        <script type="text/javascript">
                                            var carouselTotalVotes= 0,carouselTotalRating=0;
                                        </script>
                                        <s:iterator value="suggestedBooks" status="carouselStatus">
										<li class="ajax_block_product">
											<div>
												<h5><a class="product_link ellipsis" style="height: 35px;width:115px;font-size:1.2em;" href="/book/GetBookInfo.action?bookId=<s:property value="bookId"/>" title="<s:property value="bookTitle"/>"><s:property value="bookTitle"/></a></h5>
												<p>
                                                    <s:if test="authorInfo.authorName==null">N.A.</s:if>
                                                    <s:else>
                                                        by,&nbsp;
                                                        <s:iterator value="bookAuthorsesByBookId" status="iteratorStatus">
                                                            <a class="product_descr ellipsis" style="float:right;width:85px;overflow:visible;height:17px;margin:2px 0 0 5px;"
                                                               href="/author/GetAuthorInfo.action?authorId=<s:property value="authorInfoByAuthorId.authorId"/>"
                                                               title="<s:property value="authorInfoByAuthorId.authorName"/>">
                                                                <s:property value="authorInfoByAuthorId.authorName"/>
                                                            </a>
                                                            <s:if test="#iteratorStatus.last!=true">,</s:if>
                                                        </s:iterator>
                                                    </s:else>
                                                </p>
												<h3>
                                                    <script type="text/javascript">
                                                        $(document).ready(function() {
                                                            carouselTotalRating=0; carouselTotalVotes=0;
                                                            carouselTotalVotes=<s:if test="bookRatingsByBookId.size()==0">1;</s:if><s:else><s:property value="bookRatingsByBookId.size()"/>;</s:else>
                                                            <s:iterator value="bookRatingsByBookId">
                                                            carouselTotalRating=carouselTotalRating+<s:property value="rating"/>;
                                                            </s:iterator>

                                                            $($('.carousel-rating').get(<s:property value="%{#carouselStatus.index}"/>)).raty('set',{score:carouselTotalRating/carouselTotalVotes});
                                                        });
                                                    </script>
                                                    <div class="carousel-rating" bookId="<s:property value="bookId"/>">
                                                    </div>
												</h3>

                                                <!--Add To Cart-->
                                                <s:set var="breakCarouselLoop" value="%{false}"/>
                                                <s:if test="lendsByBookId !=null && lendsByBookId.size>=1">
                                                    <s:iterator value="lendsByBookId">
                                                        <s:if test="%{!#breakCarouselLoop && lendStatus!=1}">
                                                            <span class="price"><s:property value="sharingPrice"/> Points</span>
                                                            <a id="carousel-cart-button<s:property value="%{#carouselStatus.index}"/>" class="button2" href="javascript:{}" style="margin-top:15px;" onclick="addBookToCart(<s:property value="lendId"/>,'#carousel-cart-button<s:property value="%{#carouselStatus.index}"/>')">Add to Cart</a>
                                                            <s:set var="breakCarouselLoop" value="%{true}"/>
                                                        </s:if>
                                                    </s:iterator>
                                                    <s:if test="%{!#breakCarouselLoop}">
                                                        <span class="price">Not Avail.</span>
                                                        <a id="carousel-request-button<s:property value="%{#carouselStatus.index}"/>" class="button2" href="javascript:{}" style="margin-top:15px;" onclick="requestBook(<s:property value="bookId"/>,'#carousel-request-book<s:property value="%{#carouselStatus.index}"/>')">Request Book</a>
                                                    </s:if>
                                                </s:if>
                                                <s:else>
                                                    <span class="price">Not Avail.</span>
                                                    <a id="carousel-request-button<s:property value="%{#carouselStatus.index}"/>" class="button2" href="javascript:{}" style="margin-top:15px;" onclick="requestBook(<s:property value="bookId"/>,'#carousel-request-book<s:property value="%{#carouselStatus.index}"/>')">Request Book</a>
                                                </s:else>

											</div>
											<img class="related-img" src='<s:if test='book.bookImgUrl==null'>/images/no-book-cover.jpg</s:if><s:else><s:property value="book.bookImgUrl"/></s:else>'
                                                 id="pro_img" alt="<s:property value="bookTitle"/>"/>
										</li>
                                        </s:iterator>
									</ul>
									<div class="clearblock"></div>
								</div>
							</div>
							</div>
                            </s:if>--%>
						</div>
						<div id="center_column" style="border-radius:10px;">
							<!--COMMENTS-->
                            <s:if test="bookReviews!=null && bookReviews.size()!=0">
                                <h1 id="review">Book's Reviews :</h1>
                                <s:iterator value="bookReviews">
                                    <table class="comments_container">
                                        <tr class="comment_container">
                                            <td rowspan="3" class="gravatar"><img
                                                    alt='<s:property value="userInfoByUserId.firstName"/> <s:property value="userInfoByUserId.lastName"/>'
                                                    src='<s:if test='userInfoByUserId.userImg==null'>/images/no-profile-pic.png</s:if>
                                                        <s:else><s:property value="userInfoByUserId.userImg"/></s:else>'
                                                    class='avatar avatar-80 photo' height='80' width='80'/></td>
                                            <td>
                                                <a href="/user/UserProfile.action?emailId=<s:property value="userInfoByUserId.loginInfoByEmailId.emailId"/>"
                                                   title="<s:property value="userInfoByUserId.firstName"/> <s:property value="userInfoByUserId.lastName"/>">
                                                   <s:property value="userInfoByUserId.firstName"/> <s:property value="userInfoByUserId.lastName"/>
                                                </a> :
                                            </td>
                                            <td class="comment_date"><s:date name="timeOfReview" format="E','d MMM','yyyy" /></td>
                                        </tr>
                                        <tr>
                                            <td class="comment_title"><h2><s:property value="reviewTitle"/></h2></td>
                                            <td class="comment_ratings">
                                                Rated it :
                                                <img src="/img/star.png"/>
                                                <img src="/img/star.png"/>
                                                <img src="/img/star.png"/>
                                                <img src="/img/star.png"/>
                                                <img src="/img/star.png"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="comment" colspan="2">
                                                <s:property value="review"/>
                                            </td>
                                        </tr>
                                        <s:if test="bookInfoBySuggestedBookId.bookId!=null">
                                            <tr>
                                                <td>&nbsp;</td>
                                                <td class="comment" colspan="2">
                                                    <%--Suggested the Book : <a href="/book/GetBookInfo?bookId=<s:property value='bookInfoBySuggestedBookId.bookId'/>"><s:property value="bookInfoBySuggestedBookId.bookTitle" /></a>--%>
                                                </td>
                                            </tr>
                                        </s:if>
                                       <tr class="comment_bottom">
                                            <td></td>
                                            <td><%--2 of 3 users found this review helpful. <br/>Was the abover review
                                                useful to you? <a href="#">Yes</a> / <a href="#">No</a>--%></td>
                                            <td><%--<br/><a href="#">Report Abuse</a>--%></td>
                                        </tr>
                                    </table>
                                </s:iterator>
                            </s:if>
                            <s:else>
                                <br/>
                                <h2>No Reviews yet. Be the first to write review for this book.</h2>
                            </s:else>

							<!--Write Comment Table-->
							<form name="comment" action="/book/review/SaveBookReview.action" method="POST">
                                <input type="hidden" name="bookId" value="<s:property value="book.bookId"/>"/>
								<table class="write-comment">
									<tr>
										<td class="write-comment" colspan="2">
											<h2>Write your Review here :</h2>
										</td>
									</tr>
									<tr>
										<td class="write-comment-title" colspan="2">
											<h2>Title&nbsp:&nbsp</h2>
											<input type="text" name="reviewTitle" class="write-comment-title" />
										</td>
									</tr>
									<tr>
										<td class="write-comment-ratings" colspan="2">
											<h2>Your Rating :&nbsp</h2>
                                            <div class="rating-div" bookId="<s:property value="book.bookId"/>">
                                            </div>
											<%--<img src="/img/star.png"/>
											<img src="/img/star.png"/>
											<img src="/img/star.png"/>
											<img src="/img/star.png"/>
											<img src="/img/star.png"/>--%>
										</td>
									</tr>
									<%--<tr>
										<td class="suggest-a-book" colspan="2">
											<h2>Suggest a Book</h2><h4>&nbsp(optional) :&nbsp</h4>
											<input name="suggestedBookId" type="text" />
										</td>
									</tr>--%>
									<tr>
										<td colspan="2">
											<h2>Your Review :</h2>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<textarea name="review" cols="110" rows="5" ></textarea>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<input id="submit-comment" type="submit" value="SUBMIT" />
										</td>
									</tr>
								</table>
							</form>

							<!-- Customizable products -->
						</div>
						<div class="clearblock"></div>
					</div>
					
					<%--<div class="right-column">
						<h2>Suggested Books</h2>
						
							<a href="#" class="suggestions">
								<img src="/img/p/1-1-large.jpg" /><br/>
								<p>Sed at libero lobortis donec mauris</p>
							</a>
						
						
							<a href="#" class="suggestions">
								<img src="/img/p/3-7-home.jpg" /><br/>
								<p>Aliquam tempor venenatis</p>
							</a>
						
							<a href="#" class="suggestions">
								<img src="/img/p/19-55-home.jpg" /><br/>
								<p>Adipiscing tristique</p>
							</a>
							
							<a href="#" class="suggestions">
								<img src="/img/p/18-52-home.jpg" /><br/>
								<p>Proin lacus purus</p>
							</a>
							<a href="#" class="suggestions">
								<img src="/img/p/17-49-home.jpg" /><br/>
								<p>Elementum nec risus</p>
							</a>
					</div>--%>
					
					<div class="right-column-ad">
						<a href="#"><img src="/images/ad-banner.jpg" /></a>
					</div>
					
					<div class="right-column-top10">
						<h2>Popular Books</h2>
						<ol type="1">
							<a href="#"><li>Sed at libero lobortis donec mauris</li></a>
							<a href="#"><li>Aliquam tempor venenatis</li></a>
							<a href="#"><li>Adipiscing tristique</li></a>
							<a href="#"><li>Proin lacus purus</li></a>
							<a href="#"><li>Elementum nec risus</li></a>
							<a href="#"><li>Sed at libero lobortis donec mauris</li></a>
							<a href="#"><li>Aliquam tempor venenatis</li></a>
							<a href="#"><li>Adipiscing tristique</li></a>
							<a href="#"><li>Proin lacus purus</li></a>
							<a href="#"><li>Elementum nec risus</li></a>
						</ol>
					</div>
					
				</div><!--/wrapper4-->
				<!-- Footer -->
				<div id="footer_wrapper">
					<div id="footer">
						<div id="tmfooterlinks">
							<div>
								<h4>Information</h4>
								<ul>
									<li><a href="contact-form.htm">Contact</a></li>
									<li><a href="cms.htm">Delivery</a></li>
									<li><a href="cms_2.htm">Legal Notice</a></li>
									<li><a href="cms_3.htm">Terms and conditions</a></li>
									<li><a href="cms_4.htm">About us</a></li>
								</ul>
							</div>
							<div>
								<h4>Our offers</h4>
								<ul>
									<li><a href="new-products.htm">New products</a></li>
									<li><a href="best-sales.htm">Top sellers</a></li>
									<li><a href="search.jsp">Specials</a></li>
									<li><a href="manufacturer.htm">Manufacturers</a></li>
									<li><a href="supplier.htm">Suppliers</a></li>
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
							<a class="banner2" href='http://facebook.com'><img src='/modules/tmsocial/slides/slide_01.png'alt="" title="" /></a>
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