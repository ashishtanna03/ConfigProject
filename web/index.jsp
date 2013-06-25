<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sx" uri="/struts-dojo-tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>

	<title>BOOKS STORE</title>

	<%--<meta content="text/html;charset=utf-8" http-equiv="Content-Type">
	<meta content="utf-8" http-equiv="encoding">--%>
	
	<link rel="icon" type="image/vnd.microsoft.icon" href="img/favicon.ico" />
	<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />

	<link rel="stylesheet" href="css/style.css" type="text/css" media="screen" />
	<link rel="stylesheet" href="css/diapo.css" type="text/css" media="screen" />
  	<link rel="stylesheet" href="css/slide.css" type="text/css" media="screen" />

	<link href="css/global.css" rel="stylesheet" type="text/css" media="all" />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css'>

	<script type="text/javascript" src="js/jquery/jquery-1.4.4.min.js"></script>
	<script type="text/javascript" src="js/jquery/jquery.easing.1.3.js"></script>
	<script type="text/javascript" src="js/tools.js"></script>

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
	
	<script src="js/slide.js" type="text/javascript"></script>
	<script src="js/top-panel-input.js" type="text/javascript"></script>

	<script type="text/javascript" src="js/jquery/carousel1.js"></script>
	<script type="text/javascript" src="js/jquery/carousel2.js"></script>

    <!--Ajax Login Request-->
    <script type="text/javascript" src="js/ajax-request.js"></script>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".ajax_block_product").hover(function() {
				$(this).find("img").stop().animate({ "marginLeft" : "-147px"}, 300);
			}, function() {
				$(this).find("img").stop().animate({ "marginLeft":"0px"}, 200);
			});

		});
	</script>

    <!--Scrollbar-->
    <link rel="stylesheet" href="css/jquery.jscrollpane.css" type="text/css" media="screen"/>
    <script src="js/jquery/jquery.mousewheel.js" type="text/javascript"></script>
    <script src="js/jquery/jquery.jscrollpane.min.js" type="text/javascript"></script>

    <!--ellipsis-->
    <script type="text/javascript" src="/js/jquery.dotdotdot-1.5.6.js"></script>
    <script type="text/javascript">
        $(function() {
             $(".ellipsis").dotdotdot();
        });
    </script>

    <style>
            /*scrollpane custom CSS*/
        .jspVerticalBar {
            width: 8px;
            background: transparent;
            right: 10px;
        }

        .jspHorizontalBar {
            bottom: 5px;
            width: 100%;
            height: 8px;
            background: transparent;
            visibility: hidden;
        }

        .jspTrack {
            background: transparent;
        }

        .jspDrag {
            background: grey;
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
        }

            /*.jspHorizontalBar .jspTrack,.jspHorizontalBar .jspDrag {float: left;height: 100%;}*/

        .jspCorner {
            display: none
        }
    </style>
	
	<!--JS for Diapo-->
	<script>
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
							<div id="left-side-menu">
								<h3>All Categories</h3><br/>
								<a href="#">Business</a><br/>
								<a href="#">Fiction</a><br/>
								<a href="#">Cookery</a><br/>
								<a href="#">Mystery & Thriller</a><br/>
								<a href="#">Sports</a><br/>
								<a href="#">Kids</a><br/>
								<a href="#">Romance</a>
								<p><a href="#">Graphics & Story Books</a></p>
							</div>
							
							<!-- MODULE Home Featured Products -->
							<div id="featured-products_block_center">
							<div class="carousel-container">
								<div class="btnprev" id="btnprev1" ><img src="img/previous_button.png" alt="Prev" /></div>
								<div class="btnnext" id="btnnext1" ><img src="img/next_button.png" alt="Next" /></div>
								<div class="block_content" id="carousel1">
									<ul>
										<li class="ajax_block_product">
											<div>
												<h5><a class="product_link ellipsis" style="height: 30px;width:127px;" href="product.jsp" title="Sed at libero lobortis donec...">Sed at libero lobortis donec mauris</a></h5>
												<p><a class="product_descr ellipsis" style="width:128px;height:3.5em;float: left;overflow: visible;" href="product.jsp" title="More"> Well, reading books as a hobby was always a noble,Well, reading books as a hobby was always a noble,Well, reading books as a hobby was always a noble,</a></p>
												<span class="price">9,74 $</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_1" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=1&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
											<img src="img/p/1-1-home.jpg" id="pro_img" alt="Sed at libero lobortis donec mauris" />
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_2.htm" title="Sapien blandit eget urna"><img src="img/p/2-4-home.jpg" alt="Sapien blandit eget urna" /></a>
											<div>
												<h5><a class="product_link" href="product_2.htm" title="Sapien blandit eget urna">Sapien blandit eget urna</a></h5>
												<p><a class="product_descr" href="product_2.htm" title="More">It gives knowledge, excerpts on the process of...</a></p>
												<span class="price">18,73 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_2" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=2&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_3.htm" title="Aliquam tempor venenatis"><img src="img/p/3-7-home.jpg" alt="Aliquam tempor venenatis" /></a>
											<div>
												<h5><a class="product_link" href="product_3.htm" title="Aliquam tempor venenatis">Aliquam tempor venenatis</a></h5>
												<p><a class="product_descr" href="product_3.htm" title="More">For a long period of time books were very rare and...</a></p>
												<span class="price">20,23 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_3" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=3&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_4.htm" title="Suspendisse quis sem leo"><img src="img/p/4-10-home.jpg" alt="Suspendisse quis sem leo" /></a>
											<div>
												<h5><a class="product_link" href="product_4.htm" title="Suspendisse quis sem leo">Suspendisse quis sem leo</a></h5>
												<p><a class="product_descr" href="product_4.htm" title="More">And you know what? Books always have some notes of...</a></p>
												<span class="price">7,49 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_4" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=4&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_5.htm" title="Aliquam erat velit"><img src="img/p/5-13-home.jpg" alt="Aliquam erat velit" /></a>
											<div>
												<h5><a class="product_link" href="product_5.htm" title="Aliquam erat velit">Aliquam erat velit</a></h5>
												<p><a class="product_descr" href="product_5.htm" title="More">Just remember that special atmosphere of solitude in the...</a></p>
												<span class="price">8,99 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_5" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=5&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_6.htm" title="Sodales id felis nullam"><img src="img/p/6-16-home.jpg" alt="Sodales id felis nullam" /></a>
											<div>
												<h5><a class="product_link" href="product_6.htm" title="Sodales id felis nullam">Sodales id felis nullam</a></h5>
												<p><a class="product_descr" href="product_6.htm" title="More">The unique smell of old and new pages, soft cover and so...</a></p>
												<span class="price">13,49 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_6" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=6&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_7.htm" title="Lacinia nibh magna accumsan"><img src="img/p/7-19-home.jpg" alt="Lacinia nibh magna accumsan" /></a>
											<div>	
												<h5><a class="product_link" href="product_7.htm" title="Lacinia nibh magna accumsan">Lacinia nibh magna accumsan</a></h5>
												<p><a class="product_descr" href="product_7.htm" title="More">Yeah, they are worth our admiring. But those times are...</a></p>
												<span class="price">6,74 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_7" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=7&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_8.htm" title="Varius purus imperdiet"><img src="img/p/8-22-home.jpg" alt="Varius purus imperdiet" /></a>
											<div>
												<h5><a class="product_link" href="product_8.htm" title="Varius purus imperdiet">Varius purus imperdiet</a></h5>
												<p><a class="product_descr" href="product_8.htm" title="More">But those times are long gone and we live in 21 century...</a></p>
												<span class="price">20,98 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_8" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=8&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_9.htm" title="Eget molestie "><img src="img/p/9-25-home.jpg" alt="Eget molestie " /></a>
											<div>
												<h5><a class="product_link" href="product_9.htm" title="Eget molestie ">Eget molestie </a></h5>
												<p><a class="product_descr" href="product_9.htm" title="More">Books became more available. On-line book stores can...</a></p>
												<span class="price">11,99 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_9" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=9&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_10.htm" title="Placerat pellentesque"><img src="img/p/10-28-home.jpg" alt="Placerat pellentesque" /></a>
											<div>
												<h5><a class="product_link" href="product_10.htm" title="Placerat pellentesque">Placerat pellentesque</a></h5>
												<p><a class="product_descr" href="product_10.htm" title="More">On-line book stores can offer you a great assortment of...</a></p>
												<span class="price">33,71 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_10" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=10&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_11.htm" title="Sed sollicitudin tortor"><img src="img/p/11-31-home.jpg" alt="Sed sollicitudin tortor" /></a>
											<div>
												<h5><a class="product_link" href="product_11.htm" title="Sed sollicitudin tortor">Sed sollicitudin tortor</a></h5>
												<p><a class="product_descr" href="product_11.htm" title="More">Can you imagine a world of knowledge without limits? You...</a></p>
												<span class="price">29,22 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_11" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=11&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_12.htm" title="Proin congue convallis"><img src="img/p/12-34-home.jpg" alt="Proin congue convallis" /></a>
											<div>
												<h5><a class="product_link" href="product_12.htm" title="Proin congue convallis">Proin congue convallis</a></h5>
												<p><a class="product_descr" href="product_12.htm" title="More">We have tremendous variety of products, here you can find...</a></p>
												<span class="price">9,59 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_12" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=12&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_13.htm" title="Maecenas scelerisque"><img src="img/p/13-37-home.jpg" alt="Maecenas scelerisque" /></a>
											<div>
												<h5><a class="product_link" href="product_13.htm" title="Maecenas scelerisque">Maecenas scelerisque</a></h5>
												<p><a class="product_descr" href="product_13.htm" title="More">Actually we do understand that our activity is very...</a></p>
												<span class="price">9,74 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_13" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=13&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_14.htm" title="Velit condimentum"><img src="img/p/14-40-home.jpg" alt="Velit condimentum" /></a>
											<div>
												<h5><a class="product_link" href="product_14.htm" title="Velit condimentum">Velit condimentum</a></h5>
												<p><a class="product_descr" href="product_14.htm" title="More">Our business is very noble and it has many traditions....</a></p>
												<span class="price">18,73 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_14" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=14&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_15.htm" title="Phasellus augue diam"><img src="img/p/15-43-home.jpg" alt="Phasellus augue diam" /></a>
											<div>
												<h5><a class="product_link" href="product_15.htm" title="Phasellus augue diam">Phasellus augue diam</a></h5>
												<p><a class="product_descr" href="product_15.htm" title="More">That is why we have such a great number of devoted...</a></p>
												<span class="price">22,48 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_15" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=15&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_16.htm" title="Rutrum sollicitudin"><img src="img/p/16-46-home.jpg" alt="Rutrum sollicitudin" /></a>
											<div>
												<h5><a class="product_link" href="product_16.htm" title="Rutrum sollicitudin">Rutrum sollicitudin</a></h5>
												<p><a class="product_descr" href="product_16.htm" title="More">It is a great pleasure to give people the knowledge and...</a></p>
												<span class="price">7,49 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_16" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=16&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_17.htm" title="Elementum nec risus"><img src="img/p/17-49-home.jpg" alt="Elementum nec risus" /></a>
											<div>
												<h5><a class="product_link" href="product_17.htm" title="Elementum nec risus">Elementum nec risus</a></h5>
												<p><a class="product_descr" href="product_17.htm" title="More">We all must remember that our forefathers didn't have...</a></p>
												<span class="price">8,99 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_17" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=17&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_18.htm" title="Proin lacus purus"><img src="img/p/18-52-home.jpg" alt="Proin lacus purus" /></a>
											<div>
												<h5><a class="product_link" href="product_18.htm" title="Proin lacus purus">Proin lacus purus</a></h5>
												<p><a class="product_descr" href="product_18.htm" title="More">The diversity of our products is unbelievable because we...</a></p>
												<span class="price">13,49 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_18" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=18&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_19.htm" title="Adipiscing tristique"><img src="img/p/19-55-home.jpg" alt="Adipiscing tristique" /></a>
											<div>
												<h5><a class="product_link" href="product_19.htm" title="Adipiscing tristique">Adipiscing tristique</a></h5>
												<p><a class="product_descr" href="http://livedemo00.template-help.com/prestashop_37364/product_19.htm" title="More">If you have some questions about our products, terms and...</a></p>
												<span class="price">6,74 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_19" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=19&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="http://livedemo00.template-help.com/prestashop_37364/product_20.htm" title="Morbi metus dolor"><img src="img/p/20-58-home.jpg" alt="Morbi metus dolor" /></a>
											<div>
												<h5><a class="product_link" href="http://livedemo00.template-help.com/prestashop_37364/product_20.htm" title="Morbi metus dolor">Morbi metus dolor</a></h5>
												<p><a class="product_descr" href="http://livedemo00.template-help.com/prestashop_37364/product_20.htm" title="More">Well, reading books as a hobby was always a noble,...</a></p>
												<span class="price">20,98 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_20" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=20&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="http://livedemo00.template-help.com/prestashop_37364/product_20.htm" title="Morbi metus dolor"><img src="img/p/20-58-home.jpg" alt="Morbi metus dolor" /></a>
											<div>
												<h5><a class="product_link" href="http://livedemo00.template-help.com/prestashop_37364/product_20.htm" title="Morbi metus dolor">Morbi metus dolor</a></h5>
												<p><a class="product_descr" href="http://livedemo00.template-help.com/prestashop_37364/product_20.htm" title="More">Well, reading books as a hobby was always a noble,...</a></p>
												<span class="price">20,98 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_20" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=20&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
									</ul>
									<div class="clearblock"></div>
								</div>
								<h3>Recently Added</h3>
							</div>
							<div class="carousel-container">
								<!-- 2nd Carousel -->
								<div class="btnprev" id="btnprev2" ><img src="img/previous_button.png" alt="Prev" /></div>
								<div class="btnnext" id="btnnext2" ><img src="img/next_button.png" alt="Next" /></div>
								<div class="block_content" id="carousel2">
									<ul>
										<li class="ajax_block_product">
											<div>
												<h5><a class="product_link" href="product.jsp" title="Sed at libero lobortis donec...">Sed at libero lobortis donec mauris</a></h5>
												<p><a class="product_descr" href="product.jsp" title="More"> Well, reading books as a hobby was always a noble,...</a></p>
												<span class="price">9,74 $</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_1" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=1&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
											<img src="img/p/1-1-home.jpg" id="pro_img" alt="Sed at libero lobortis donec mauris" />
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_2.htm" title="Sapien blandit eget urna"><img src="img/p/2-4-home.jpg" alt="Sapien blandit eget urna" /></a>
											<div>
												<h5><a class="product_link" href="product_2.htm" title="Sapien blandit eget urna">Sapien blandit eget urna</a></h5>
												<p><a class="product_descr" href="product_2.htm" title="More">It gives knowledge, excerpts on the process of...</a></p>
												<span class="price">18,73 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_2" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=2&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_3.htm" title="Aliquam tempor venenatis"><img src="img/p/3-7-home.jpg" alt="Aliquam tempor venenatis" /></a>
											<div>
												<h5><a class="product_link" href="product_3.htm" title="Aliquam tempor venenatis">Aliquam tempor venenatis</a></h5>
												<p><a class="product_descr" href="product_3.htm" title="More">For a long period of time books were very rare and...</a></p>
												<span class="price">20,23 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_3" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=3&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_4.htm" title="Suspendisse quis sem leo"><img src="img/p/4-10-home.jpg" alt="Suspendisse quis sem leo" /></a>
											<div>
												<h5><a class="product_link" href="product_4.htm" title="Suspendisse quis sem leo">Suspendisse quis sem leo</a></h5>
												<p><a class="product_descr" href="product_4.htm" title="More">And you know what? Books always have some notes of...</a></p>
												<span class="price">7,49 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_4" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=4&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_5.htm" title="Aliquam erat velit"><img src="img/p/5-13-home.jpg" alt="Aliquam erat velit" /></a>
											<div>
												<h5><a class="product_link" href="product_5.htm" title="Aliquam erat velit">Aliquam erat velit</a></h5>
												<p><a class="product_descr" href="product_5.htm" title="More">Just remember that special atmosphere of solitude in the...</a></p>
												<span class="price">8,99 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_5" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=5&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_6.htm" title="Sodales id felis nullam"><img src="img/p/6-16-home.jpg" alt="Sodales id felis nullam" /></a>
											<div>
												<h5><a class="product_link" href="product_6.htm" title="Sodales id felis nullam">Sodales id felis nullam</a></h5>
												<p><a class="product_descr" href="product_6.htm" title="More">The unique smell of old and new pages, soft cover and so...</a></p>
												<span class="price">13,49 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_6" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=6&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_7.htm" title="Lacinia nibh magna accumsan"><img src="img/p/7-19-home.jpg" alt="Lacinia nibh magna accumsan" /></a>
											<div>	
												<h5><a class="product_link" href="product_7.htm" title="Lacinia nibh magna accumsan">Lacinia nibh magna accumsan</a></h5>
												<p><a class="product_descr" href="product_7.htm" title="More">Yeah, they are worth our admiring. But those times are...</a></p>
												<span class="price">6,74 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_7" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=7&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_8.htm" title="Varius purus imperdiet"><img src="img/p/8-22-home.jpg" alt="Varius purus imperdiet" /></a>
											<div>
												<h5><a class="product_link" href="product_8.htm" title="Varius purus imperdiet">Varius purus imperdiet</a></h5>
												<p><a class="product_descr" href="product_8.htm" title="More">But those times are long gone and we live in 21 century...</a></p>
												<span class="price">20,98 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_8" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=8&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_9.htm" title="Eget molestie "><img src="img/p/9-25-home.jpg" alt="Eget molestie " /></a>
											<div>
												<h5><a class="product_link" href="product_9.htm" title="Eget molestie ">Eget molestie </a></h5>
												<p><a class="product_descr" href="product_9.htm" title="More">Books became more available. On-line book stores can...</a></p>
												<span class="price">11,99 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_9" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=9&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_10.htm" title="Placerat pellentesque"><img src="img/p/10-28-home.jpg" alt="Placerat pellentesque" /></a>
											<div>
												<h5><a class="product_link" href="product_10.htm" title="Placerat pellentesque">Placerat pellentesque</a></h5>
												<p><a class="product_descr" href="product_10.htm" title="More">On-line book stores can offer you a great assortment of...</a></p>
												<span class="price">33,71 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_10" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=10&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_11.htm" title="Sed sollicitudin tortor"><img src="img/p/11-31-home.jpg" alt="Sed sollicitudin tortor" /></a>
											<div>
												<h5><a class="product_link" href="product_11.htm" title="Sed sollicitudin tortor">Sed sollicitudin tortor</a></h5>
												<p><a class="product_descr" href="product_11.htm" title="More">Can you imagine a world of knowledge without limits? You...</a></p>
												<span class="price">29,22 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_11" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=11&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_12.htm" title="Proin congue convallis"><img src="img/p/12-34-home.jpg" alt="Proin congue convallis" /></a>
											<div>
												<h5><a class="product_link" href="product_12.htm" title="Proin congue convallis">Proin congue convallis</a></h5>
												<p><a class="product_descr" href="product_12.htm" title="More">We have tremendous variety of products, here you can find...</a></p>
												<span class="price">9,59 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_12" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=12&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_13.htm" title="Maecenas scelerisque"><img src="img/p/13-37-home.jpg" alt="Maecenas scelerisque" /></a>
											<div>
												<h5><a class="product_link" href="product_13.htm" title="Maecenas scelerisque">Maecenas scelerisque</a></h5>
												<p><a class="product_descr" href="product_13.htm" title="More">Actually we do understand that our activity is very...</a></p>
												<span class="price">9,74 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_13" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=13&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_14.htm" title="Velit condimentum"><img src="img/p/14-40-home.jpg" alt="Velit condimentum" /></a>
											<div>
												<h5><a class="product_link" href="product_14.htm" title="Velit condimentum">Velit condimentum</a></h5>
												<p><a class="product_descr" href="product_14.htm" title="More">Our business is very noble and it has many traditions....</a></p>
												<span class="price">18,73 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_14" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=14&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_15.htm" title="Phasellus augue diam"><img src="img/p/15-43-home.jpg" alt="Phasellus augue diam" /></a>
											<div>
												<h5><a class="product_link" href="product_15.htm" title="Phasellus augue diam">Phasellus augue diam</a></h5>
												<p><a class="product_descr" href="product_15.htm" title="More">That is why we have such a great number of devoted...</a></p>
												<span class="price">22,48 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_15" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=15&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_16.htm" title="Rutrum sollicitudin"><img src="img/p/16-46-home.jpg" alt="Rutrum sollicitudin" /></a>
											<div>
												<h5><a class="product_link" href="product_16.htm" title="Rutrum sollicitudin">Rutrum sollicitudin</a></h5>
												<p><a class="product_descr" href="product_16.htm" title="More">It is a great pleasure to give people the knowledge and...</a></p>
												<span class="price">7,49 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_16" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=16&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_17.htm" title="Elementum nec risus"><img src="img/p/17-49-home.jpg" alt="Elementum nec risus" /></a>
											<div>
												<h5><a class="product_link" href="product_17.htm" title="Elementum nec risus">Elementum nec risus</a></h5>
												<p><a class="product_descr" href="product_17.htm" title="More">We all must remember that our forefathers didn't have...</a></p>
												<span class="price">8,99 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_17" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=17&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_18.htm" title="Proin lacus purus"><img src="img/p/18-52-home.jpg" alt="Proin lacus purus" /></a>
											<div>
												<h5><a class="product_link" href="product_18.htm" title="Proin lacus purus">Proin lacus purus</a></h5>
												<p><a class="product_descr" href="product_18.htm" title="More">The diversity of our products is unbelievable because we...</a></p>
												<span class="price">13,49 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_18" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=18&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="product_19.htm" title="Adipiscing tristique"><img src="img/p/19-55-home.jpg" alt="Adipiscing tristique" /></a>
											<div>
												<h5><a class="product_link" href="product_19.htm" title="Adipiscing tristique">Adipiscing tristique</a></h5>
												<p><a class="product_descr" href="http://livedemo00.template-help.com/prestashop_37364/product_19.htm" title="More">If you have some questions about our products, terms and...</a></p>
												<span class="price">6,74 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_19" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=19&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
										<li class="ajax_block_product">
											<a class="product_image" href="http://livedemo00.template-help.com/prestashop_37364/product_20.htm" title="Morbi metus dolor"><img src="img/p/20-58-home.jpg" alt="Morbi metus dolor" /></a>
											<div>
												<h5><a class="product_link" href="http://livedemo00.template-help.com/prestashop_37364/product_20.htm" title="Morbi metus dolor">Morbi metus dolor</a></h5>
												<p><a class="product_descr" href="http://livedemo00.template-help.com/prestashop_37364/product_20.htm" title="More">Well, reading books as a hobby was always a noble,...</a></p>
												<span class="price">20,98 €</span>
												<a class="exclusive ajax_add_to_cart_button" rel="ajax_id_product_20" href="http://livedemo00.template-help.com/prestashop_37364/cart.php?qty=1&amp;id_product=20&amp;token=897c850e54f52674bef4b37874d61063&amp;add" title="Add to cart">Add to cart</a>
											</div>
										</li>
									</ul>
									<div class="clearblock"></div>
								</div>
								<h3>Bestseller</h3>
							</div>	
							</div>
							<!-- /MODULE Home Featured Products -->
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
				</div>
			</div>
		</div>
	</div>
	

</body>
</html>
