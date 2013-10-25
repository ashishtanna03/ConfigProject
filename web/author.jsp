<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sx" uri="/struts-dojo-tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<title><s:property value="author.authorName"/> - Reader's Hive</title>
	<meta name="description" content="<s:property value="author.Description"/>"/>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
	<meta name="generator" content="PrestaShop" />
	<meta name="robots" content="index,follow" />
	<link rel="shortcut icon" type="image/x-icon" href="/img/favicon.ico" />
	
	<link rel="stylesheet" href="/css/global.css" type="text/css" media="all" />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css' />
	<link rel="stylesheet" href="/css/jquery.fancybox-1.3.4.css" type="text/css" media="screen" />

    <script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery.easing.1.3.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery.fancybox-1.3.4.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery.idTabs.modified.js"></script>
    <script type="text/javascript" src="/js/product.js"></script><!--For image preview-->

    <sx:head />

	<!--Carousel-->
    <script type="text/javascript">
        var noOfBooks = <s:property value="authorBooks.size()"/>;
        var step=Math.floor((noOfBooks/5)-0.0001);
    </script>
	<script type="text/javascript" src="/js/jquery/related-carousel.js"></script>

    <!--Scrollbar-->
    <link rel="stylesheet" href="css/jquery.jscrollpane.css" type="text/css" media="screen"/>
    <script src="js/jquery/jquery.mousewheel.js" type="text/javascript"></script>
    <script src="js/jquery/jquery.jscrollpane.min.js" type="text/javascript"></script>

    <!--Rating-->
    <script type="text/javascript" src="/js/rating/jquery.raty.min.js"></script>
    <style type="text/css">
        .rating-div img {height: 16px!important;width: 16px!important;float: left;}
        #author-rating div { width:102px!important; float:right; display: inline;}
        @media screen and (-webkit-min-device-pixel-ratio:0) {#author-rating div {margin-top: -20px;} } /*for chrome and safari*/
        #author-rating div img {float: left;}
    </style>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".ajax_block_product").hover(function() {
				$(this).find(".author-books").stop().animate({ "marginLeft" : "-120px"}, 300);
			}, function() {
				$(this).find(".author-books").stop().animate({ "marginLeft":"0px"}, 200);
			});

            var sessionVar="<s:property value="%{#session}"/>";
            if(sessionVar.length>2){
                var isLoggedIn = "<s:property value="%{#session.isLoggedIn}"/>";
                if(isLoggedIn=="true"){
                    getLoggedInInfo();
                }
            }
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

					<div id="columns" class="center_column" style="width:720px">


							<!-- Center -->
							<div id="center_column" class="center_column">
								<!-- Breadcrumb -->
								<div class="breadcrumb">
									<div class="breadcrumb_inner">
										<a href="/index.jsp" title="Return to Home">Home</a>
										<span class="navigation-pipe">&gt;</span>
										<span class="navigation_page">Authors</span>
										<span class="navigation-pipe">&gt;</span>
										<span class="navigation_end"><s:property value="author.authorName"/></span>
									</div>
								</div>
								<!-- /Breadcrumb -->

								<div id="primary_block" class="clearfix">
									<h1>
                                        <s:property value="author.authorName"/>&nbsp;
                                        <s:if test='author.authorPenName!=null && !author.authorPenName.equals("")'>(<s:property value="author.authorPenName"/>)</s:if>
                                    </h1>
									<br/>
									<!-- right infos-->
									<div id="pb-right-column">
										<!-- product img-->
										<div id="image-block">
											<a href="<s:if test='author.authorImg==null'>/images/no-author-pic.jpg</s:if><s:else><s:property value="author.authorImg"/></s:else>"
                                               rel="other-views" class="thickbox shown" title="<s:property value="author.authorName"/>">
												<img src="<s:if test='author.authorImg==null'>/images/no-author-pic.jpg</s:if><s:else><s:property value="author.authorImg"/></s:else>"
                                                     title="<s:property value="author.authorName"/>"
                                                     alt="<s:property value="author.authorName"/>"
                                                     id="bigpic" width="300" height="450" />
											</a>
										</div>
									</div>
									<!-- left infos-->
									<div id="pb-left-column">
										<div id="short_description_block">
											<div id="short_description_content" class="rte align_justify">


												<!--<h3>
													Publisher : <a id="publisher-link" href="#">Pan Macmillan</a> (2012)
												</h3>-->

												<br/>
												<table id="author-desc">
													<tr>
														<th><b>Genres : </b></th>
														<td>
                                                            <s:if test="author.authorGenresesByAuthorId==null || author.authorGenresesByAuthorId.size==0">N.A.</s:if>
                                                            <s:else>
                                                                <s:iterator value="author.authorGenresesByAuthorId" status="iteratorStatus">
                                                                    <a href="/search/LoadSearchResults.action?newRequest=true&excludeOutOfStock=false&pageNo=0&maxResults=7&sortBy=0&filterGenre=<s:property value="genresByGenreId.genreName"/>&filterLanguage=&filterPriceRange=5&searchQuery=">
                                                                        <s:property value="genresByGenreId.genreName"/></a>
                                                                    <s:if test="#iteratorStatus.last!=true">,</s:if>
                                                                </s:iterator>
                                                            </s:else>
														</td>
													</tr>
													<tr>
														<th><b>Gender : </b></th>
														<td>
                                                            <s:if test="author.authorGender==null">N.A.</s:if>
                                                            <s:else>
                                                                <s:if test='author.authorGender.equals("M")'>Male</s:if><s:else>Female</s:else>
                                                            </s:else>
														</td>
													</tr>
													<tr>
														<th><b>Born : </b></th>
														<td>
                                                            <s:if test="author.authorBorn==null">N.A.</s:if>
                                                            <s:else><s:date name="author.authorBorn" format="d',' MMM', 'yyyy" /></s:else>
                                                        </td>
													</tr>
                                                    <s:if test="author.authorDied!=null">
													    <tr>
														    <th><b>Died : </b></th>
														    <td>
                                                                <s:date name="author.authorDied" format="d',' MMM', 'yyyy" />
                                                            </td>
													    </tr>
                                                    </s:if>
													<tr>
														<th><b>Lives : </b></th>
														<td>
                                                            <s:if test='author.authorLives==null || author.authorLives.equals("")'>N.A.</s:if>
                                                            <s:else><s:property value="author.authorLives"/></s:else>
                                                        </td>
													</tr>
													<%--<tr>
														<th><b>Notable Work(s) : </b></th>
														<td><a href="#">Stories of Sherlock Holmes</a>, <a href="#">The Lost World</a></td>
													</tr>--%>
													<tr>
														<th><b>Website/Blog : </b></th>
														<td>
                                                            <s:if test='author.authorBlogLink==null || author.authorBlogLink.equals("")'>N.A.</s:if>
                                                            <s:else><s:property value="author.authorBlogLink"/></s:else>
                                                        </td>
													</tr>
												</table>
                                                <s:if test="%{#session==null || #session.isLoggedIn==null || #session.isLoggedIn==false}">
                                                    <a href="javascript:{}" class="button2 followButton" onclick="followRequest('notLoggedIn',null)">(+) Follow</a>
                                                </s:if>
                                                <s:elseif test="!following">
                                                    <a href="javascript:{}" id="Follow" class="button2 followButton" onclick="followRequest('Follow','<s:property value="author.authorId"/>')">(+) Follow</a>
                                                </s:elseif>
                                                <s:else>
                                                    <a href="javascript:{}" id="Unfollow" class="button2 followButton" onclick="followRequest('Unfollow','<s:property value="author.authorId"/>')">(-) Unfollow</a>
                                                </s:else>
											</div>
										</div>
									</div>
								</div>

								<!-- description and features -->
								<div id="more_info_block" class="clear">
									<ul id="more_info_tabs" class="idTabs idTabsShort">
										<li><a id="more_info_tab_more_info" href="#idTab1">About</a></li>
										<!--<li><a id="more_info_tab_data_sheet" href="#idTab2">Data sheet</a></li>-->
									</ul>
									<div id="more_info_sheets" class="tabs_content">
										<!-- full description -->
										<div id="idTab1">
                                            <s:if test='author.authorDescription==null || author.authorDescription.equals("")'>Not Available.</s:if>
                                            <s:else><s:property escape="false" value="author.authorDescription.replace(\"\n\", \" <br/>\")"/></s:else>
                                        </div>
									</div>
								</div>
								<br/>
							<br/>
							<h2 id="related-header">Books by <s:property value="author.authorName"/> (<s:property value="authorBooks.size()"/>) :</h2>
							<div id="related-products_block_center">
							<div class="related-carousel-container">

								<div class="related_btnprev" id="related_btnprev1" ><img src="/images/blank.png" width="12px" height="19px" alt="Prev" /></div>
								<div class="related_btnnext" id="related_btnnext1" ><img src="/images/blank.png" width="12px" height="19px" alt="Next" /></div>
								<div class="related_content" id="carousel1">
									<ul>
                                        <s:iterator value="authorBooks" status="iteratorStatus">
										<li class="ajax_block_product">
											<div>
												<h5 style="margin-bottom: 10px;"><a class="product_link ellipsis multiline" style="font-size: 1.1em;width: 115px;height: 40px;" href="/book/GetBookInfo.action?bookId=<s:property value="bookId"/>" title="<s:property value="bookTitle"/>"><s:property value="bookTitle"/></a></h5>


                                                    <div class="rating-div" id="rating-div<s:property value="bookId"/>" bookId="<s:property value="bookId"/>" style="float:left;width:92px;">
                                                    </div>
                                                    <script type="text/javascript">

                                                        var totalAverage= 0.0; //Average Rating of all books of the author.
                                                        var noOfRatedBooks = 0; //total books which are rated, will be used to get average of author's books

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

                                                                totalAverage += parseFloat(avgRating);
                                                                noOfRatedBooks++;
                                                            }

                                                            $('#rating-div'+<s:property value="bookId"/>).tooltipster({
                                                                animation: 'fade',
                                                                trigger:'hover',
                                                                content:'Avg. Rating : '+avgRating+'<br/>Total Votes : '+totalVotes<s:if test="userId!=null">+'<br/>Your Rating : '+userRating</s:if>
                                                            });

                                                            $('#rating-div'+<s:property value="bookId"/>).raty({
                                                                half: true,
                                                                readOnly : true,
                                                                hints : ['Bad','OK','Good','Nice','Superb'],
                                                                score:avgRating/*,
                                                                click: function(score, evt) {
                                                                    rateBook(score,$(this).attr('bookId'),'#rating-div'+<s:property value="bookId"/>);
                                                                }               */
                                                            });

                                                        });
                                                    </script>

                                                <br/>
												<span class="price">
                                                    <s:set var="breakPointsLoop" value="%{false}"/>
                                                    <s:if test="lendsByBookId !=null && lendsByBookId.size>=1">
                                                        <s:iterator value="lendsByBookId">
                                                            <s:if test="%{!#breakPointsLoop && lendStatus!=1}">
                                                                <s:property value="sharingPrice"/> points
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
                                                            <a id="add-to-cart-button<s:property value="%{#iteratorStatus.index}"/>" class="button2" href="javascript:{}" title="Add To Cart" onclick="addBookToCart(<s:property value="lendId"/>,'#add-to-cart-button<s:property value="%{#iteratorStatus.index}"/>')">Add To Cart</a>
                                                            <s:set var="breakLoop" value="%{true}"/>
                                                        </s:if>
                                                    </s:iterator>
                                                    <s:if test="%{!#breakLoop}">
                                                        <a id="request-book-button<s:property value="%{#iteratorStatus.index}"/>" class="button2" href="javascript:{}" title="Request Book" onclick="requestBook(<s:property value="bookId"/>,'#request-book-button<s:property value="%{#iteratorStatus.index}"/>')" >Request Book</a>
                                                    </s:if>
                                                </s:if>
                                                <s:else>
                                                    <a id="request-book-button<s:property value="%{#iteratorStatus.index}"/>" class="button2" href="javascript:{}" title="Request Book" onclick="requestBook(<s:property value="bookId"/>,'#request-book-button<s:property value="%{#iteratorStatus.index}"/>')" >Request Book</a>
                                                </s:else>

											</div>
											<img src="<s:if test='bookImgUrl==null'>/images/no-book-cover.jpg</s:if><s:else><s:property value="bookImgUrl"/></s:else>"
                                                 class="author-books" id="pro_img" alt="<s:property value="bookTitle"/>" />
										</li>
                                        </s:iterator>
									</ul>
									<div class="clearblock"></div>
								</div><!--related_content-->
							</div><!--related-carousel-container-->
							</div><!--related-products-block center-->

							<br/>
							<h1 id="author-rating">Average Rating of all books : &nbsp;
                                <!--Author's Average Ratings Div-->
                                <div></div>
							</h1>
                            <script type="text/javascript">
                                $(document).ready(function() {

                                    var averageAll = 0.0;
                                    if(noOfRatedBooks!=0)
                                        averageAll = (totalAverage/noOfRatedBooks).toFixed(1);

                                    $('#author-rating div').tooltipster({
                                        animation: 'fade',
                                        trigger:'hover',
                                        content:'Avg. Rating : '+averageAll
                                    });

                                    $('#author-rating div').raty({
                                        half: true,
                                        hints : ['Bad','OK','Good','Nice','Superb'],
                                        readOnly :true,
                                        score:averageAll
                                    });
                                });
                            </script>


						</div>
						<div id="center_column" style="border-radius:10px;">
							<!--COMMENTS-->

                            <s:if test="authorReviews!=null && authorReviews.size()!=0">
                                <h1 id="review">Comments :</h1>
                                <s:iterator value="authorReviews">
							<table class="comments_container">
								<tr class="comment_container">
									<td rowspan="4" class="gravatar" width="80">
                                        <img alt='<s:property value="userInfoByUserId.firstName"/> <s:property value="userInfoByUserId.lastName"/>'
                                             src='<s:if test='userInfoByUserId.userImg==null'>/images/no-profile-pic.png</s:if>
                                                    <s:else><s:property value="userInfoByUserId.userImg"/></s:else>'
                                             class='avatar avatar-80 photo'
                                             height='80'
                                             width='80'
                                        />
                                    </td>
									<td colspan="2" width="286">
                                        <a href="/user/UserProfile.action?userId=<s:property value="userInfoByUserId.userId"/>"
                                           title="<s:property value="userInfoByUserId.firstName"/> <s:property value="userInfoByUserId.lastName"/>">
                                            <s:property value="userInfoByUserId.firstName"/> <s:property value="userInfoByUserId.lastName"/>
									    </a> :
                                    </td>
									<td class="comment_date"><s:date name="timeOfReview" format="E','d MMM','yyyy" /></td>
								</tr>
								<tr>
									<td class="comment_title" colspan="3"><h2><s:property value="reviewTitle"/></h2></td>
								</tr>
								<tr>
									<td class="comment" colspan="3">
                                        <s:property escape="false" value="review.replace(\"\n\", \" <br/>\")"/>
									</td>
								</tr>
								<tr class="comment_bottom">
									<td colspan="2"></td>
									<td><s:if test="userId.equals(userInfoByUserId.userId)"><a href="/author/review/DeleteComment.action?authorId=<s:property value="author.authorId"/>">Delete</a></s:if></td>
								</tr>
							</table>
                            </s:iterator>
                            </s:if>
                            <s:else>
                                <br/><br/><br/><b>No Comments yet. Be the first to write comment for the Author.</b><br/><br/>
                            </s:else>

							<!--Write Comment Table-->
                            <s:if test="!userCommented && userId!=null">
							<form name="comment" action="/author/review/SaveComment.action" method="POST">
                                <input type="hidden" name="authorId" value="<s:property value="author.authorId"/>"/>
								<table class="write-comment">
									<tr>
										<td class="write-comment" colspan="2">
											<h2>Write your Comment here :</h2>
										</td>
									</tr>
									<tr>
										<td class="write-comment-title" colspan="2">
											<h2>Title&nbsp:&nbsp</h2>
											<input type="text" name="reviewTitle" class="write-comment-title" />
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<h2>Comment :</h2>
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
                            </s:if>
                            <s:elseif test="userId==null">
                                <b style="float: left;margin-top: 25px;">Log In to Write a Comment.</b>
                            </s:elseif>


						</div>
						<div class="clearblock"></div>
					</div><!--/Columns-->

					<div id="followers" class="right-column">

                        <h2>
                            Followers (
                            <s:if test="author.authorFollowsByAuthorId!=null && author.authorFollowsByAuthorId.size()>0">
                                <a href="#" id="no-of-followers" ><s:property value="author.authorFollowsByAuthorId.size()"/></a>
                            </s:if>
                            <s:else>0</s:else>
                            )
                        </h2>

                        <s:if test="author.authorFollowsByAuthorId!=null && author.authorFollowsByAuthorId.size()>0">
                            <s:set var="count" value="%{0}" />
						    <s:iterator value="author.authorFollowsByAuthorId">
                                <s:if test="%{#attr.count<6}">
                                    <s:set var="count" value="%{#attr.count + 1}"/>
                                    <a href="/user/UserProfile.action?userId=<s:property value="userInfoByUserId.userId"/>"
                                       class="suggestions">
                                        <img alt="<s:property value="name"/>"
                                             title="<s:property value="name"/>"
                                             src="<s:if test="userInfoByUserId.userImg==null">/images/no-profile-pic.png</s:if><s:else><s:property value="userInfoByUserId.userImg"/></s:else>"
                                                />
                                        <br/>

                                        <p><s:property value="userInfoByUserId.firstName"/> <s:property
                                                value="userInfoByUserId.lastName"/></p>
                                    </a>
                                </s:if>
                            </s:iterator>
                            <s:if test="author.authorFollowsByAuthorId.size()>6">
                                <a href="/author/ViewAllFollowers.action?authorId=<s:property value="author.authorId"/>" id="view-more">
                                    View All
                                </a>
                            </s:if>
                        </s:if>
                        <s:else><br/><center><b style="color: white;">No Followers.</b></center></s:else>
					</div>

					<div class="right-column-ad">
						<a href="#"><img src="/images/ad-banner.jpg" /></a>
					</div>
					
					<div class="right-column-top10">
						<h2>Popular Authors</h2>
						<ol type="1">
                            <s:iterator value="topTenAuthors">
                                <a href="/author/GetAuthorInfo.action?authorId=<s:property value="authorId"/>" title="<s:property value="authorName"/>" ><li><s:property value="authorName"/></li></a>
                            </s:iterator>
						</ol>
					</div>
				</div>

				<!-- Footer -->
                <s:include value="footer.jsp" />

			</div>
		</div>
	</div>
	<script type="text/javascript" src="/js/ga.js"></script>
</body>
</html>