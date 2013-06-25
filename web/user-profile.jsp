<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sx" uri="/struts-dojo-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<title><s:property value="user.firstName"/> <s:property value="user.lastName"/> - Reader's Hive</title>
	<meta name="description" content="It gives knowledge, excerpts on the process of development of your personality. For a long period of time books were very rare and because of such confines only some &quot;esoteric&quot; people could afford them. And you know what? Books always have some notes of mysticism. The unique smell of old and new pages, soft cover and so on. Yeah, they are worth our admiring." />
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
	<meta name="generator" content="PrestaShop" />
	<meta name="robots" content="index,follow" />
	<link rel="icon" type="image/vnd.microsoft.icon" href="/img/favicon.ico" />
	<link rel="shortcut icon" type="image/x-icon" href="/img/favicon.ico" />
	
	<link href="/css/global.css" rel="stylesheet" type="text/css" media="all" />
	<link href="/css/jquery.fancybox-1.3.4.css" rel="stylesheet" type="text/css" media="screen" />

	<script type="text/javascript" src="/js/jquery/jquery-1.4.4.min.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery.easing.1.3.js"></script>
	<script type="text/javascript" src="/js/tools.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery.fancybox-1.3.4.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery.idTabs.modified.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery.scrollTo-1.4.2-min.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery.serialScroll-1.2.2-min.js"></script>
	<!--<script type="text/javascript" src="js/tools.js"></script>-->
	<script type="text/javascript" src="/js/product.js"></script>

    <sx:head />

    <script type="text/javascript" src="/js/ajax-request.js"></script>

    <script src="/js/top-panel-input.js" type="text/javascript"></script>

	<script src="/js/slide.js" type="text/javascript"></script>
	<link rel="stylesheet" href="/css/style.css" type="text/css" media="screen" />
  	<link rel="stylesheet" href="/css/slide.css" type="text/css" media="screen" />

    <!--Carousel-->
    <script type="text/javascript">
        var steps=Math.floor((<s:property value="user.lendsByUserId.size()"/>/4)-0.0001);
    </script>
    <script type="text/javascript" src="/js/jquery/shared-carousel.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $(".ajax_block_product").hover(function() {
                $(this).find(".author-books").stop().animate({ "marginLeft" : "-120px"}, 300);
            }, function() {
                $(this).find(".author-books").stop().animate({ "marginLeft":"0px"}, 200);
            });
        });
    </script>
	
	<!--Carousel-->
	<script type="text/javascript" src="/js/jquery/shelf-carousel1.js"></script>
	<script type="text/javascript" src="/js/jquery/shelf-carousel2.js"></script>
	<script type="text/javascript" src="/js/jquery/shelf-carousel3.js"></script>
	
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
								
								<div id="primary_block" class="clearfix">
									<h1><s:property value="user.firstName"/> <s:property value="user.lastName"/>'s Profile</h1>
									<a href="/user/EditUserProfile.action" id="go-edit-prof" class="button_small">Edit Profile</a>
									
									
									<br/>
									<!-- right infos-->
									<div id="profile-pic">
										<!-- product img-->
										<div>
											<a href="<s:if test='user.userImg==null'>/images/no-profile-pic.png</s:if><s:else><s:property value="user.userImg"/></s:else>" rel="other-views" class="thickbox shown" title="Ashish Tanna">
												<img src="<s:if test='user.userImg==null'>/images/no-profile-pic.png</s:if><s:else><s:property value="user.userImg"/></s:else>"
                                                     title="<s:property value="user.firstName"/> <s:property value="user.lastName"/>"
                                                     alt="<s:property value="user.firstName"/> <s:property value="user.lastName"/>"
                                                     id="bigpic" width="135" height="155" />
											</a>
											<center><a href="#" id="change-pp" class="button">Change Picture</a></center>
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
														<th><b>Favorite Genres : </b></th>
														<td>
                                                            <s:if test="user.userFavGenresesByUserId==null || user.userFavGenresesByUserId.size==0">N.A.</s:if>
                                                            <s:else>
                                                                <s:iterator value="user.userFavGenresesByUserId" status="iteratorStatus">
                                                                    <a href="#">
                                                                        <s:property value="genresByGenreId.genreName"/>
                                                                    </a>
                                                                    <s:if test="#iteratorStatus.last!=true">,</s:if>
                                                                </s:iterator>
                                                            </s:else>
														</td>
													</tr>
													<tr>
														<th><b>Age : </b></th>
														<td><s:if test="userAge==null">N.A.</s:if><s:else><s:property value="userAge"/></s:else></td>
													</tr>
													<tr>
														<th><b>Gender : </b></th>
														<td>
                                                            <s:if test="user.userGender==null">N.A.</s:if>
                                                            <s:else>
                                                                <s:if test='user.userGender.equals("M")'>Male</s:if><s:else>Female</s:else>
                                                            </s:else>
                                                        </td>
													</tr>
													<tr>
														<th><b>Lives : </b></th>
														<td><s:if test="user.userCity==null">N.A.</s:if><s:else><s:property value="user.userCity"/></s:else></td>
													</tr>
													<tr>
														<th><b>Occupation : </b></th>
														<td><s:if test="user.userOccupation==null">N.A.</s:if><s:else><s:property value="user.userOccupation"/></s:else></td>
													</tr>
													<tr>
														<th><b>Studying : </b></th>
														<td><a href="#">B.E.</a> <a href="#">8th Sem</a> (<a href="#">Gujarat Technologicaal University</a>)</td>
													</tr>
													<tr>
														<th><b>Website/Blog : </b></th>
														<td><s:if test="user.userWebsite==null">N.A.</s:if>
                                                            <s:else><a href="<s:property value="user.userWebsite"/>"><s:property value="user.userWebsite"/></a></s:else>
                                                        </td>
													</tr>
												</table>
													<div id="user-rated-value">6.5</div>
											</div>
										</div>
									</div>
								</div>

                                <!-- description and features -->
                                <!-- description and features -->
                                <div id="more_info_block" class="clear">
                                    <ul id="more_info_tabs" class="idTabs idTabsShort">
                                        <li><a id="more_info_tab_more_info" href="#idTab1">Shared Books</a></li>
                                        <!--<li><a id="more_info_tab_data_sheet" href="#idTab2">Data sheet</a></li>-->
                                    </ul>
                                    <div id="more_info_sheets" class="tabs_content currently-reading currently-parent">
                                        <!-- full description -->
                                        <div id="idTab1">

                                            <div id="related-products_block_center">
                                                <div class="related-carousel-container" style="width:646px;">

                                                    <div class="related_btnprev" id="related_btnprev1" style="margin-left:10px;" ><img src="/images/blank.png" width="12px" height="19px" alt="Prev" /></div>
                                                    <div class="related_btnnext" style="float: right;margin-left:20px;margin-right: 20px;" id="related_btnnext1" ><img src="/images/blank.png" width="12px" height="19px" alt="Next" /></div>
                                                    <div class="related_content" id="carousel1" style="margin-left: 30px;">
                                                        <ul>
                                                            <s:iterator value="user.lendsByUserId">
                                                                <li class="ajax_block_product" style="margin:0 16px 0 0;">
                                                                    <div>
                                                                        <h5><a class="product_link ellipsis" style="font-size: 1.2em;width: 115px;height: 35px" href="/book/GetBookInfo.action?bookId=<s:property value="bookInfoByBookId.bookId"/>" title="<s:property value="bookInfoByBookId.bookTitle"/>"><s:property value="bookInfoByBookId.bookTitle"/></a></h5>
                                                                        <h3>
                                                                            <img src="/img/star.png" style="padding-right: 2px;float:left;height:14px;width:14px;" alt="star"/>
                                                                            <img src="/img/star.png" style="padding-right: 2px;float:left;height:14px;width:14px;" alt="star"/>
                                                                            <img src="/img/star.png" style="padding-right: 2px;float:left;height:14px;width:14px;" alt="star"/>
                                                                            <img src="/img/star.png" style="padding-right: 2px;float:left;height:14px;width:14px;" alt="star"/>
                                                                            <img src="/img/star.png" style="padding-right: 2px;float:left;height:14px;width:14px;" alt="star"/>
                                                                        </h3>
                                                                        <span class="price"><s:property value="sharingPrice"/> Points</span>
                                                                        <a class="button2" href="#" title="Add to cart">Remove Book</a>
                                                                    </div>
                                                                    <img src="<s:if test='bookInfoByBookId.bookImgUrl==null'>/images/no-book-cover.jpg</s:if><s:else><s:property value="bookInfoByBookId.bookImgUrl"/></s:else>"
                                                                         class="author-books" id="pro_img" alt="<s:property value="bookInfoByBookId.bookTitle"/>" />
                                                                </li>
                                                            </s:iterator>
                                                        </ul>
                                                        <div class="clearblock"></div>
                                                    </div><!--related_content-->
                                                </div><!--related-carousel-container-->
                                            </div><!--related-products-block center-->

                                        </div><!--/idtab1-->
                                    </div><!--/more info sheets-->
                                </div><!--/more info block-->

								<!-- description and features -->
								<!-- description and features -->
								<div id="more_info_block" class="clear">
									<ul id="more_info_tabs" class="idTabs idTabsShort">
										<li><a id="more_info_tab_more_info" href="#idTab1">Currently Reading</a></li>
										<!--<li><a id="more_info_tab_data_sheet" href="#idTab2">Data sheet</a></li>-->
									</ul>
									<div id="more_info_sheets" class="tabs_content currently-reading currently-parent">
										<!-- full description -->
										<div id="idTab1">
											<div class="currently-reading" >
												<img src="/img/p/1-1-home.jpg" />
												<h3>&nbsp;</h3><a href="#">What the Thunder Said</a>
												<br/>
												<h3>&nbsp;by&nbsp;</h3><a href="#">Author Name</a>
												<br/>
												<h3>&nbsp;Genres :&nbsp;</h3><a href="#">Genre 1</a><h3>&nbsp;,&nbsp;</h3><a href="#">Genre 2</a>
												<br/>
												<h3>&nbsp;Rating :&nbsp;</h3>
												<h3 class="rating-stars">
													<img src="/img/star.png"/>
													<img src="/img/star.png"/>
													<img src="/img/star.png"/>
													<img src="/img/star.png"/>
													<img src="/img/star.png"/>
												</h3>
												<br/><br/>
												<h3>&nbsp;</h3><a href="#" class="button_large" id="cust-rew">Customer Review(5)</a>
												

											</div><!--/Currently Reading-->
											
											
												<a href="#" class="button_small" id="edit-cur-rea">Edit</a>
												
											
										</div><!--/idtab1-->
									</div><!--/more info sheets-->
								</div><!--/more info block-->
								
						</div>
						<div id="center_column" style="border-radius:10px;">
							<div id="more_info_block">
									<ul id="more_info_tabs" class="idTabs idTabsShort">
										<li><a id="more_info_tab_more_info" href="#idTab1"><s:property value="user.firstName"/> <s:property value="user.lastName"/>'s Shelves</a></li>
										
										<!--<li><a id="more_info_tab_data_sheet" href="#idTab2">Data sheet</a></li>-->
									</ul>
									<a href="#" class="button_small" id="edit-shelf">Edit</a>
									<div id="more_info_sheets" class="tabs_content shelves-container-parent">
										<!-- full description -->
										<div id="idTab1" class="shelves-container">
											<!--Shelf #1-->
											<div class="shelf">
												<div id="related-products_block_center">
												<div class="related-carousel-container">
													<div class="related_btnprev" id="related_btnprev4" ><img src="/images/blank.png" width="12px" height="19px" alt="Prev" /></div>
													<div class="related_btnnext" id="related_btnnext4" ><img src="/images/blank.png" width="12px" height="19px" alt="Next" /></div>
													<div class="related_content" id="carousel4">
														<ul>
															<li class="ajax_block_product">
																<img src="/img/p/1-1-home.jpg" id="pro_img" alt="Sed at libero lobortis donec mauris" />
															</li>
															<li class="ajax_block_product">
																<img src="/img/p/2-4-home.jpg" alt="Sapien blandit eget urna" />
															</li>
															<li class="ajax_block_product">
																<img src="/img/p/3-7-home.jpg" alt="Aliquam tempor venenatis" />
															</li>
															<li class="ajax_block_product">
																<img src="/img/p/4-10-home.jpg" alt="Suspendisse quis sem leo" />
															</li>
															<li class="ajax_block_product">
																<img src="/img/p/5-13-home.jpg" alt="Aliquam erat velit" />
															</li>
															<li class="ajax_block_product">
																<img src="/img/p/6-16-home.jpg" alt="Sodales id felis nullam" />
															</li>
														</ul>
														<div class="clearblock"></div>
													</div><!--related_content-->
												</div><!--related-carousel-container-->
												</div><!--related-products-block center-->
												<h3 class="shelf-header">Favorite</h3>
											</div><!--shelf-->
											<!--/Shelf #1>
											
											<!--Shelf #2-->
											<div class="shelf">
												<div id="related-products_block_center">
												<div class="related-carousel-container">
													<div class="related_btnprev" id="related_btnprev2" ><img src="/images/blank.png" width="12px" height="19px" alt="Prev" /></div>
													<div class="related_btnnext" id="related_btnnext2" ><img src="/images/blank.png" width="12px" height="19px" alt="Next" /></div>
													<div class="related_content" id="carousel2">									
														<ul>
															<li class="ajax_block_product">
																<img src="/img/p/1-1-home.jpg" id="pro_img" alt="Sed at libero lobortis donec mauris" />
															</li>
															<li class="ajax_block_product">
																<img src="/img/p/2-4-home.jpg" alt="Sapien blandit eget urna" />
															</li>
															<li class="ajax_block_product">
																<img src="/img/p/3-7-home.jpg" alt="Aliquam tempor venenatis" />
															</li>
															<li class="ajax_block_product">
																<img src="/img/p/4-10-home.jpg" alt="Suspendisse quis sem leo" />
															</li>
															<li class="ajax_block_product">
																<img src="/img/p/5-13-home.jpg" alt="Aliquam erat velit" />
															</li>
															<li class="ajax_block_product">
																<img src="/img/p/6-16-home.jpg" alt="Sodales id felis nullam" />
															</li>
														</ul>
														<div class="clearblock"></div>
													</div><!--related_content-->
												</div><!--related-carousel-container-->
												</div><!--related-products-block center-->
												<h3 class="shelf-header">Want to Read</h3>
											</div><!--shelf-->
											<!--/Shelf #2-->
											
											<!--Shelf #3-->
											<div class="shelf">
												<div id="related-products_block_center">
												<div class="related-carousel-container">
													<div class="related_btnprev" id="related_btnprev3" ><img src="/images/blank.png" width="12px" height="19px" alt="Prev" /></div>
													<div class="related_btnnext" id="related_btnnext3" ><img src="/images/blank.png" width="12px" height="19px" alt="Next" /></div>
													<div class="related_content" id="carousel3">									
														<ul>
															<li class="ajax_block_product">
																<img src="/img/p/1-1-home.jpg" id="pro_img" alt="Sed at libero lobortis donec mauris" />
															</li>
															<li class="ajax_block_product">
																<img src="/img/p/2-4-home.jpg" alt="Sapien blandit eget urna" />
															</li>
															<li class="ajax_block_product">
																<img src="/img/p/3-7-home.jpg" alt="Aliquam tempor venenatis" />
															</li>
															<li class="ajax_block_product">
																<img src="/img/p/4-10-home.jpg" alt="Suspendisse quis sem leo" />
															</li>
															<li class="ajax_block_product">
																<img src="/img/p/5-13-home.jpg" alt="Aliquam erat velit" />
															</li>
															<li class="ajax_block_product">
																<img src="/img/p/6-16-home.jpg" alt="Sodales id felis nullam" />
															</li>
														</ul>
														<div class="clearblock"></div>
													</div><!--related_content-->
												</div><!--related-carousel-container-->
												</div><!--related-products-block center-->
												<h3 class="shelf-header">Currently Having</h3>
												
											</div><!--shelf-->
											<!--/Shelf #3-->
											
										</div><!--/idtab1 & /shelves-container-->
										
									</div><!--/more info sheets-->
								</div><!--/more info block-->
								
							
						</div>
						<div class="clearblock"></div>
					</div><!--/Columns-->

                    <div id="followers" class="right-column">
                        <h2>Friends (
                            <a href="#" id="no-of-followers" class="no-of-friends" >
                                <script type="text/javascript">
                                    var count = 0;
                                </script>
                            </a>
                            )
                        </h2>
                        <s:if test="user.friendshipMappingsByUserId!=null && user.friendshipMappingsByUserId.size()>0">
                            <s:iterator value="user.friendshipMappingsByUserId">
                                <s:if test="status==2">
                                    <script type="text/javascript">count++;</script>
                                    <a href="/user/UserProfile.action?emailId=<s:property value="userInfoByUser2.loginInfoByEmailId.emailId"/>" class="suggestions">
                                        <img    alt="<s:property value="userInfoByUser2.firstName"/> <s:property value="userInfoByUser2.lastName"/>"
                                                title="<s:property value="userInfoByUser2.firstName"/> <s:property value="userInfoByUser2.lastName"/>"
                                                src="<s:if test="userInfoByUser2.userImg==null">/images/no-profile-pic.png</s:if><s:else><s:property value="userInfoByUser2.userImg"/></s:else>"
                                                />
                                        <br/>
                                        <p><s:property value="userInfoByUser2.firstName"/> <s:property value="userInfoByUser2.lastName"/></p>
                                    </a>
                                </s:if>
                            </s:iterator>
                        </s:if>
                        <s:if test="user.friendshipMappingsByUserId_0!=null && user.friendshipMappingsByUserId_0.size()>0">
                            <s:iterator value="user.friendshipMappingsByUserId_0">
                                <s:if test="status==2">
                                    <script type="text/javascript">count++;</script>
                                    <a href="/user/UserProfile.action?emailId=<s:property value="userInfoByUser1.loginInfoByEmailId.emailId"/>" class="suggestions">
                                        <img    alt="<s:property value="userInfoByUser1.firstName"/> <s:property value="userInfoByUser1.lastName"/>"
                                                title="<s:property value="userInfoByUser1.firstName"/> <s:property value="userInfoByUser1.lastName"/>"
                                                src="<s:if test="userInfoByUser1.userImg==null">/images/no-profile-pic.png</s:if><s:else><s:property value="userInfoByUser1.userImg"/></s:else>"
                                                />
                                        <br/>
                                        <p><s:property value="userInfoByUser1.firstName"/> <s:property value="userInfoByUser1.lastName"/></p>
                                    </a>
                                </s:if>
                            </s:iterator>
                        </s:if>
                        <s:if test="(user.friendshipMappingsByUserId.size()+user.friendshipMappingsByUserId_0.size())>6">
                            <a href="/lightbox-pages/more-friends.htm?lightbox[width]=390&lightbox[height]=300"
                               class="more-friends" id="view-more">
                                View More
                            </a>
                        </s:if>
                        <s:if test="(user.friendshipMappingsByUserId_0==null || user.friendshipMappingsByUserId_0.size()=0) && (user.friendshipMappingsByUserId==null || user.friendshipMappingsByUserId.size()=0)"><br/><center><b style="color: white;">No Friends Yet.</b></center></s:if>
                        <script type="text/javascript">document.getElementsByClassName("no-of-friends")[0].innerHTML=count;</script>
                    </div>

                    <div id="followers" class="right-column followers2">
                        <h2>
                            Follows (
                            <s:if test="user.authorFollowsByUserId!=null && user.authorFollowsByUserId.size()>0">
                                <a href="#" id="no-of-followers" ><s:property value="user.authorFollowsByUserId.size()"/></a>
                            </s:if>
                            <s:else>0</s:else>
                            )
                        </h2>

                        <s:if test="user.authorFollowsByUserId!=null && user.authorFollowsByUserId.size()>0">
                            <s:iterator value="user.authorFollowsByUserId">
                                <a href="/author/GetAuthorInfo.action?authorId=<s:property value="authorInfoByAuthorId.authorId"/>" class="suggestions">
                                    <img    alt="<s:property value="authorInfoByAuthorId.authorName"/>"
                                            title="<s:property value="authorInfoByAuthorId.authorName"/>"
                                            src="<s:if test="authorInfoByAuthorId.authorImg==null">/images/no-author-pic.jpg</s:if><s:else><s:property value="authorInfoByAuthorId.authorImg"/></s:else>"
                                            />
                                    <br/>
                                    <p><s:property value="authorInfoByAuthorId.authorName"/></p>
                                </a>
                            </s:iterator>
                            <s:if test="user.authorFollowsByUserId.size()>3">
                                <a href="#" id="view-more">View More</a>
                            </s:if>
                        </s:if>
                        <s:else><br/><center><b style="color: white;">Following No one yet.</b></center></s:else>
                    </div><!--/#followers /right-column-->
					
					
					
					
										
				</div>

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