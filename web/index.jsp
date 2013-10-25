<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sx" uri="/struts-dojo-tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>

	<title>Readers Hive</title>

	<%--<meta content="text/html;charset=utf-8" http-equiv="Content-Type">
	<meta content="utf-8" http-equiv="encoding">--%>
	
	<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />

	<link rel="stylesheet" href="css/diapo.css" type="text/css" media="screen" />

	<link href="css/global.css" rel="stylesheet" type="text/css" media="all" />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css'>

	<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="js/jquery/jquery.easing.1.3.js"></script>

    <sx:head />

    <!--PNG Fix For IE6-->
	<script type="text/javascript" src="js/jquery/jquery.pngFix.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$(document).pngFix();
		});
	</script>
	
	<link rel='stylesheet' id='style-css'  href='diapo.css' type='text/css' media='all'> 
	<!--[if !IE]><!--><script type='text/javascript' src='scripts/jquery.mobile-1.0rc2.customized.min.js'></script><!--<![endif]-->
	<script type='text/javascript' src='scripts/jquery.hoverIntent.minified.js'></script> 
	<script type='text/javascript' src='scripts/diapo.js'></script>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".ajax_block_product").hover(function() {
				$(this).find(".book-image").stop().animate({ "marginLeft" : "-147px"}, 300);
			}, function() {
				$(this).find(".book-image").stop().animate({ "marginLeft":"0px"}, 200);
			});

		});
	</script>

    <script type="text/javascript" src="js/jquery/carousel1.js"></script>
    <script type="text/javascript" src="js/jquery/carousel2.js"></script>
    <script type="text/javascript" src="js/jquery/carousel3.js"></script>
    <script type="text/javascript" src="js/jquery/carousel4.js"></script>


	
	<!--JS for Diapo-->
	<script type="text/javascript">
		$(function(){
		    $('.pix_diapo').diapo();
		});
	</script>
</head>

<body id="index">
	<!--[if lt IE 7]><div style='clear:both;height:59px;padding:0 15px 0 15px;position:relative;z-index:10000;text-align:center;'><a href="http://www.microsoft.com/windows/internet-explorer/default.aspx?ocid=ie6_countdown_bannercode"><img src="http://www.theie6countdown.com/images/upgrade.jpg" border="0" height="42" width="820" alt="You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." /></a></div><![endif]-->
	<div id="wrapper1">
		<div id="wrapper2">
			<div id="wrapper3">

            <!--Top Panel-->
            <s:include value="/top-panel.jsp"/>
			
				<div id="wrapper4">

                <!-- Header -->
                <jsp:include page="/header.jsp" flush="true"/>

					<div id="columns">
						<!-- Center -->
						<div id="center_column" class="center_column">
							
							<!--SlideShow-->
							<section> 
    
								<div class="div_diapo"> 
									<div class="pix_diapo">
										
										<div data-thumb="images/thumbs/megamind1048.jpg">
											<img src="images/slides/1.jpg" />
											<div class="caption elemHover fromLeft">
												This is a simple sliding image with caption. You can have more than one caption and decide the layout of the caption via css.
											</div>
										</div>
					
										<%--<div data-thumb="images/thumbs/megamind_07.jpg">
											<img src="images/slides/megamind_07.jpg" /> 
											<div class="caption elemHover fromRight" style="bottom:65px; padding-bottom:5px; color:#ff0; text-transform:uppercase">
												Here you can see two captions.
											</div>
											<div class="caption elemHover fromLeft" style="padding-top:5px;">
												The first are loaded immediately before than the second one
											</div>
										</div>--%>
					
										<%--<div data-thumb="images/thumbs/wall-e.jpg" data-time="7000">
											<img src="images/slides/wall-e.jpg" />--%>
											<%--<div class="elemHover caption fromLeft" style="bottom:70px; width:auto; -webkit-border-top-right-radius: 6px; -webkit-border-bottom-right-radius: 6px; -moz-border-radius-topright: 6px; -moz-border-radius-bottomright: 6px; border-top-right-radius: 6px; border-bottom-right-radius: 6px;">
												You can also get the same effect as the caption with:
											</div>--%>
										<%--	<div class="elemHover button fromTop" data-easing="easeOutExpo" style="left:388px; bottom:78px;">
												A button
											</div>--%>
											<%--<div class="elemHover button button2 fromBottom" data-easing="easeOutExpo" style="left:512px; bottom:78px;">
												Or two buttons
											</div>--%>
										<%--	<div class="elemHover fadeIn" style="left:600px; bottom:auto; top:0; padding-top:50px; color:#ff0; font-size:13px; line-height:20px; width:auto; -webkit-border-top-right-radius: 6px; -webkit-border-bottom-right-radius: 6px; -moz-border-radius-topright: 6px; -moz-border-radius-bottomright: 6px; border-top-right-radius: 6px; border-bottom-right-radius: 6px; background:url(images/demo/arrow_caption.png) no-repeat 230px 30px">
												Or any other html element...<br>
												and you can decide the transition time of any slide
											</div>
										</div>--%>
                   
								<%--		<div data-thumb="images/thumbs/up-official-trailer-fake.jpg">
											<iframe width="940" height="470" src="http://www.youtube.com/embed/qas5lWp7_R0?wmode=transparent&autoplay=1" data-fake="images/slides/up-official-trailer-fake.jpg" frameborder="0" allowfullscreen></iframe>
											<div class="elemHover caption fromLeft elemToHide" style="bottom: 350px; width:auto; -webkit-border-top-right-radius: 6px; -webkit-border-bottom-right-radius: 6px; -moz-border-radius-topright: 6px; -moz-border-radius-bottomright: 6px; border-top-right-radius: 6px; border-bottom-right-radius: 6px; left:0">
												You can also display videos, but it requires a "fake image"... read the documentation please
											</div>
										</div>--%>
					
										<%--<div data-thumb="images/thumbs/big_buck_bunny.jpg" data-time="7000">
											<div style="position:absolute; top:0; left:0; width:900px; height:430px; padding:20px; background:#fff; color:#222;">
												<div style="float:left; width:300px;">
													<p><br><br>You can display any html element directly in the slider, but pay attention, with many elements the transition effect could be slowed.<br>
														In this case you can see a Vimeo video and a price table</p>
													<iframe src="http://player.vimeo.com/video/1084537?title=0&amp;byline=0&amp;portrait=0&amp;color=f0bc00&amp;autoplay=1" data-fake="images/slides/big_buck_bunny.jpg" width="300" height="169" frameborder="0"></iframe>
												</div>
												<div class="price_table">
													<div>
														<div class="price_column highlighted" style="top:0; left:190px; height:387px; background:#fff; -moz-box-shadow: 0 1px 4px #666;	-webkit-box-shadow: 0 1px 4px #666; box-shadow: 0 1px 4px #666;">
															<div>
															</div>
														</div><!-- .price_column --> 
														<div class="price_column" style="top:0; left:0; height:383px; background:#ddd; -moz-box-shadow: 0 1px 4px #666;	-webkit-box-shadow: 0 1px 4px #666; box-shadow: 0 1px 4px #666;">
															<div> 
															</div>
														</div><!-- .price_column --> 
														<div class="price_column" style="top:0; left:380px; height:383px; background:#ddd; -moz-box-shadow: 0 1px 4px #666;	-webkit-box-shadow: 0 1px 4px #666; box-shadow: 0 1px 4px #666;">
															<div>
															</div>
														</div><!-- .price_column -->
														<div class="price_column highlighted fadeIn" style="top:0; left:190px;">
															<div>
																<div class="price_title">Standard</div><!-- .price_title --> 
																<div class="price_price">$9/mo.</div><!-- .price_price --> 
																<div class="price_explanation">And as the day advanced and the engine drivers</div><!-- .price_explanation --> 
																<div class="pix_check">Check sign</div><!-- .pix_check --> 
																<div class="pix_check">Check sign</div><!-- .pix_check --> 
																<div class="pix_check">Check sign</div><!-- .pix_check --> 
																<div class="pix_error">Error sign</div><!-- .pix_error --> 
																<div>
																	<a class="button button3" href="#">Purchase</a>
																</div>
															</div>
														</div><!-- .price_column --> 
														<div class="price_column fromTop" style="top:0; left:0">
															<div> 
																<div class="price_title">Basic</div><!-- .price_title --> 
																<div class="price_price">Free</div><!-- .price_price --> 
																<div class="price_explanation">And as the day advanced and the engine drivers</div><!-- .price_explanation --> 
																<div class="pix_check">Check sign</div><!-- .pix_check --> 
																<div class="pix_error">Error sign</div><!-- .pix_error --> 
																<div class="pix_check">Check sign</div><!-- .pix_check --> 
																<div class="pix_error">Error sign</div><!-- .pix_error --> 
																<div>
																	<a class="button" href="#">Purchase</a>
																</div> 
															</div>
														</div><!-- .price_column --> 
														<div class="price_column fromBottom" style="top:0; left:380px;">
															<div>
																<div class="price_title">Professional</div><!-- .price_title --> 
																<div class="price_price">$19/mo.</div><!-- .price_price --> 
																<div class="price_explanation">And as the day advanced and the engine drivers</div><!-- .price_explanation --> 
																<div class="pix_check">Check sign</div><!-- .pix_check --> 
																<div class="pix_check">Check sign</div><!-- .pix_check --> 
																<div class="pix_check">Check sign</div><!-- .pix_check --> 
																<div class="pix_check">Check sign</div><!-- .pix_check --> 
																<div>
																	<a class="button" href="#">Purchase</a>
																</div> 
															</div>
														</div><!-- .price_column --> 
													</div>
												</div><!-- price_table -->
											</div>
										</div>
                    
										<div data-thumb="images/thumbs/ratatouille2.jpg">
											<img src="images/slides/ratatouille2.jpg" />
										</div>--%>
									</div><!-- #pix_diapo -->
								</div>
							</section> 
							
							<!--Left side Menu-->

							
							<!-- MODULE Home Featured Products -->
							<s:action name="HomePageShelves" namespace="/" executeResult="true" />
							<!-- /MODULE Home Featured Products -->
						</div>
						<div class="clearblock"></div>
					</div>
				</div>

				<!-- Footer -->
                <s:include value="footer.jsp" />

				<%--<div id="footer_wrapper">
					<div id="footer">
						<div id="tmfooterlinks">
							<div>
								<h4>Information</h4>
								<ul>
									<li><a href="http://livedemo00.template-help.com/prestashop_37364/contact-form.htm">Contact</a></li>
									<li><a href="http://livedemo00.template-help.com/prestashop_37364/cms.htm">Delivery</a></li>
									<li><a href="http://livedemo00.template-help.com/prestashop_37364/cms_2.htm">Legal Notice</a></li>
									<li><a href="http://livedemo00.template-help.com/prestashop_37364/cms_3.htm">Terms and conditions</a></li>
									<li><a href="http://livedemo00.template-help.com/prestashop_37364/cms_4.htm">About us</a></li>
								</ul>
							</div>
							<div>
								<h4>Our offers</h4>
								<ul>
									<li><a href="http://livedemo00.template-help.com/prestashop_37364/new-products.htm">New products</a></li>
									<li><a href="http://livedemo00.template-help.com/prestashop_37364/best-sales.htm">Top sellers</a></li>
									<li><a href="http://livedemo00.template-help.com/prestashop_37364/prices-drop.htm">Specials</a></li>
									<li><a href="http://livedemo00.template-help.com/prestashop_37364/manufacturer.htm">Manufacturers</a></li>
									<li><a href="http://livedemo00.template-help.com/prestashop_37364/supplier.htm">Suppliers</a></li>
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
							<a class="banner1" href='http://livedemo00.template-help.com/twitter.com/twitter_default_2.html'><img src='modules/tmsocial/slides/slide_00.png'alt="" title="" /></a>
							<a class="banner2" href='http://facebook.com'><img src='modules/tmsocial/slides/slide_01.png'alt="" title="" /></a>
						</div>
						<!-- /tmsocial -->
						<!-- [[%FOOTER_LINK]] -->
					</div>
				</div>--%>
			</div>
		</div>
	</div>
	

</body>
</html>