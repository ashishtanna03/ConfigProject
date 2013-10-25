<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sx" uri="/struts-dojo-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <title>Error - Reader's Hive</title>

    <meta name="description" content="" />
    <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
    <meta name="generator" content="PrestaShop" />
    <meta name="robots" content="index,follow" />

    <meta content="text/html;charset=utf-8" http-equiv="Content-Type"/>
    <meta content="utf-8" http-equiv="encoding"/>

    <link rel="shortcut icon" type="image/x-icon" href="/img/favicon.ico" />

    <link href="/css/global.css" rel="stylesheet" type="text/css" media="all" />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css' />

    <link href="/css/jquery.fancybox-1.3.4.css" rel="stylesheet" type="text/css" media="screen" />

    <script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.easing.1.3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.fancybox-1.3.4.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.idTabs.modified.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.scrollTo-1.4.2-min.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.serialScroll-1.2.2-min.js"></script>

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

    <!--for lightbox forms-->
    <link rel="stylesheet" type="text/css" href="/js/lightbox/jquery.lightbox.css" />
    <!--[if IE 6]><link rel="stylesheet" type="text/css" href="/javascript/lightbox/themes/default/jquery.lightbox.ie6.css" /><![endif]-->
    <script type="text/javascript" src="/js/lightbox/jquery.lightbox.js"></script>
    <script type="text/javascript">
        jQuery(document).ready(function(){
            jQuery('#shipping-add').lightbox();
        });
    </script>

</head>
<body id="product">
<!--[if lt IE 7]><div style='clear:both;height:59px;padding:0 15px 0 15px;position:relative;z-index:10000;text-align:center;'><a href="http://www.microsoft.com/windows/internet-explorer/default.aspx?ocid=ie6_countdown_bannercode"><img src="http://www.theie6countdown.com/images/upgrade.jpg" border="0" height="42" width="820" alt="You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." /></a></div><![endif]-->
<div id="wrapper1">
    <div id="wrapper2">
        <div id="wrapper3">

            <div id="wrapper4" >

                <!-- Header -->
                <div id="header">
                    <a id="header_logo" style="top:11px!important;left:3px!important;" href="/index.jsp" title="Readers Hive">
                        <img class="logo" style="width:340px!important;" src="/img/logo.png" alt="Readers Hive" title="Readers Hive" />
                    </a>
                    <div id="header_right">
                        <br/>
                        <br/>

                        <div class="clearblock"></div>
                        <div id="header_cart">
                            <a href="/cart/ViewCart.action" title="Your Shopping Cart">Cart :</a>
            <span class="ajax_cart_quantity">
                (Empty)
            </span>
                        </div>

                        <!-- /Block user information module HEADER --><!-- Block search module TOP -->
                        <div class="clearblock"></div>
                        <%--<div id="search_block_top">
                            <form method="POST" action="/search/LoadSearchResults.action" id="searchbox" name="searchForm" accept-charset="UTF-8" >
                                &lt;%&ndash;<sx:autocompleter cssClass="search_query" id="search_query_top" name="searchQuery" list="suggestions" href="/list/GenerateList.action"
                                                  loadOnTextChange="true" searchType="substring" showDownArrow="false" autoComplete="false" loadMinimumCount="1" resultsLimit="5" />&ndash;%&gt;
                                <input type="hidden" name="pageNo" value="0" />
                                <input type="hidden" name="maxResults" value="7" />
                                <input type="hidden" name="newRequest" value="true" />
                                <input type="hidden" name="sortBy" value="0" />
                                <input type="hidden" name="filterGenre" value="" />
                                <input type="hidden" name="filterLanguage" value="" />
                                <input type="hidden" name="filterPriceRange" value="5" />
                                <a href="javascript:document.searchForm.submit();"><img src="/img/search-button2.png" /></a>
                            </form>
                        </div>--%>
                        <!-- /Block search module TOP --><!-- TM Categories -->
                        <div class="clearblock"></div>

                        <div id="tmcategories" style="padding: 110px 65px 0 0">
                            <ul id="cat" class="sf-menu">
                                <li class="">
                                    <a href="/index.jsp" >Home</a>
                                </li>
                                <li class="">
                                    <a href="/how-it-works.jsp" >How It Works</a>
                                </li>
                                <li class="">
                                    <a href="/about-us.jsp" >About Us</a>
                                </li>
                                <li class="">
                                    <a href="/faq.jsp" >F.A.Q.</a>
                                </li>
                                <li class=" last">
                                    <a href="/contact.jsp" >Contact Us</a>
                                </li>
                            </ul>
                        </div>
                        <!-- /TM Categories -->
                    </div>
                </div>

                <div id="columns" class="center_column" style="width:720px;">

                    <!-- Center -->
                    <div id="center_column" style="width:900px;">

                        <div id="primary_block" class="clearfix" style="height:auto;">

                            <img src="/images/error/Sorry.jpg"/>
                        </div>


                        <br/>



                        <br/>
                    </div>

                    <div class="clearblock"></div>
                </div>


            </div><!--/wrapper4-->

            <!-- Footer -->
            <style type="text/css">
                div#tmsocial a img {height: 50px;}
                a.banner1 {margin-right: 0!important;}
            </style>

            <div id="footer_wrapper">
                <div id="footer">
                    <div id="tmfooterlinks" style="width: 974px;">
                        <div style="padding-left: 10px;padding-right: 0;">
                            <h4>Information</h4>
                            <ul>
                                <li><a href="/index.jsp">Home</a></li>
                                <li><a href="/how-it-works.jsp">How it Works</a></li>
                                <li><a href="/about-us.jsp">About Us</a></li>
                                <li><a href="/faq.jsp">F.A.Q</a></li>
                                <li><a href="/contact.jsp">Contact Us</a></li>
                            </ul>
                        </div>
                        <div style="margin-left: -60px;">
                            <h4>&nbsp;</h4>
                            <ul>
                                <li><a href="/terms-condition.jsp">Terms & Conditions</a></li>
                                <li><a href="/privacy-policy.jsp">Privacy Policy</a></li>
                                <li><a href="/sitemap.jsp">Sitemap</a></li>
                            </ul>
                        </div>
                        <div>
                            <h4>Help</h4>
                            <ul>
                                <li><a href="/faq.jsp#1_1">Earn Points</a></li>
                                <li><a href="/faq.jsp#1_2">Request Book</a></li>
                                <li><a href="/faq.jsp#1_3">Share Book</a></li>
                                <li><a href="/faq.jsp#1_4">Set Price of Book</a></li>
                                <li><a href="/faq.jsp#1_5">Pick-up/Delivery</a></li>
                            </ul>
                        </div>
                        <div class="left right">

                        </div>
                        <!-- tmsocial -->
                        <div id="tmsocial" style="clear:left; margin-top: 15px;">
                            <a class="banner1" href='http://facebook.com/ReadersHive'><img src='/modules/tmsocial/slides/facebook.png' title="Like us on Facebook" alt="Our Facebook Page" /></a>
                            <a class="banner2" href='http://twitter.com/ReadersHive'><img src='/modules/tmsocial/slides/twitter.png' title="Follow us on Twitter" alt="Our Twitter Account" /></a>
                            <a class="banner3" href='http://plus.google.com/ReadersHive'><img src='/modules/tmsocial/slides/google_plus.png' title="+1 us on Google+" alt="Our Google+ Page" /></a>
                        </div>
                        <!-- /tmsocial -->
                        <p style="margin: 23px 0 0 -240px;float: left;">
                            &copy; 2013 Powered by <a href="http://www.jusdias.com" target="_blank">JUSDIAS Inc</a>. All rights reserved.
                        </p>
                        <p style="margin: 23px 35px 0 0;float: right;">Designed by <a href="http://www.innovplex.com" target="_blank">Innovplex Inc</a>.</p>
                    </div>
                    <!-- [[%FOOTER_LINK]] -->
                </div>
            </div>

        </div>
    </div>
</div>
</body>
</html>