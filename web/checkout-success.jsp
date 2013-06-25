<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <title>Successfully checked out - Reader's Hive</title>

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

    <script type="text/javascript" src="/js/ajax-request.js"></script>

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

    <script src="/js/slide.js" type="text/javascript"></script>

</head>
<body id="product">
<!--[if lt IE 7]><div style='clear:both;height:59px;padding:0 15px 0 15px;position:relative;z-index:10000;text-align:center;'><a href="http://www.microsoft.com/windows/internet-explorer/default.aspx?ocid=ie6_countdown_bannercode"><img src="http://www.theie6countdown.com/images/upgrade.jpg" border="0" height="42" width="820" alt="You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." /></a></div><![endif]-->
<div id="wrapper1">
<div id="wrapper2">
<div id="wrapper3">

<!-- Panel -->
<div id="toppanel">
    <div id="panel">
        <div class="content clearfix">
            <div class="left">
                <h1>Welcome to Reader's Hive</h1>
                <h2>Register Or Login to Enjoy the uncomparable services.</h2><br/>
                <p class="grey">Njoy  this new Concept of sharing Books </p>
                <h2></h2>
            </div>
            <div class="left">
                <!-- Login Form -->
                <form class="clearfix" action="#" method="post">
                    <h1>Member Login</h1>
                    <label class="grey" for="log">Username:</label>
                    <input class="field" type="text" name="log" id="log" value="" size="23" />
                    <label class="grey" for="pwd">Password:</label>
                    <input class="field" type="password" name="pwd" id="pwd" size="23" />
                    <label><input name="rememberme" id="rememberme" type="checkbox" checked="checked" value="forever" /> &nbsp;Remember me</label>
                    <div class="clear"></div>
                    <input type="submit" name="submit" value="Login" class="bt_login" />
                    <a class="lost-pwd" href="#">Lost your password?</a>
                </form>
            </div>
            <div class="left right">
                <!-- Register Form -->
                <form action="#" method="post">
                    <h1>Not a member yet? Sign Up!</h1>
                    <label class="grey" for="signup">Username:</label>
                    <input class="field" type="text" name="signup" id="signup" value="" size="23" />
                    <label class="grey" for="email">Email:</label>
                    <input class="field" type="text" name="email" id="email" size="23" />
                    <label>A password will be e-mailed to you.</label>
                    <input type="submit" name="submit" value="Register" class="bt_register" />
                </form>
            </div>
        </div>
    </div> <!-- /login -->
    <!-- The tab on top -->
    <div class="tab">
        <ul class="login">
            <li class="left">&nbsp;</li>
            <li>Hello Guest!</li>
            <li class="sep">|</li>
            <li id="toggle">
                <a id="open" class="open" href="#">Log In | Register</a>
                <a id="close" style="display: none;" class="close" href="#">Close Panel</a>
            </li>
            <li class="right">&nbsp;</li>
        </ul>
    </div> <!-- / top -->
</div> <!--panel -->

<div id="wrapper4">



<!-- Header -->
<div id="header">
    <a id="header_logo" href="/index.jsp" title="BOOKS STORE">
        <img class="logo" src="/img/logo.png" alt="BOOKS STORE" />
    </a>
    <div id="header_right">
        <br/>
        <br/>

        <div class="clearblock"></div>
        <div id="header_cart">
            <a href="/order.htm" title="Your Shopping Cart">Cart :</a>
            <span class="ajax_cart_quantity">1</span>
            <span class="ajax_cart_product_txt">product</span>
            <span class="ajax_cart_product_txt_s hidden">products</span>
            <span class="ajax_cart_no_product hidden">(empty)</span>
        </div>
        <!-- /Block user information module HEADER --><!-- Block search module TOP -->
        <div class="clearblock"></div>
        <div id="search_block_top">
            <form method="get" action="search.htm" id="searchbox">
                <input class="search_query" type="text" id="search_query_top" name="search_query" value="" />
                <a href="javascript:document.getElementById('searchbox').submit();"><img src="/img/search-button2.png" /></a>
                <input type="hidden" name="orderby" value="position" />
                <input type="hidden" name="orderway" value="desc" />
            </form>
        </div>
        <!-- /Block search module TOP --><!-- TM Categories -->
        <div class="clearblock"></div>

        <script type="text/javascript" src="/modules/tmcategories/superfish.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                $('ul.sf-menu').superfish({
                    delay: 100,
                    animation: {opacity:'show',height:'show'},
                    speed: 'fast',
                    autoArrows: false,
                    dropShadows: false
                });
            });
        </script>

        <div id="tmcategories">
            <ul id="cat" class="sf-menu">
                <li class="sub">
                    <a href="/category.htm" >Menu</a>
                    <ul class="subcat">
                        <li class="">
                            <a href="/category_2.htm" >Arts &amp; Photography</a>
                        </li>
                        <li class="">
                            <a href="/category_3.htm" >Audiobooks</a>
                        </li>
                        <li class="">
                            <a href="/category_4.htm" >Audible Audiobooks</a>
                        </li>
                        <li class="">
                            <a href="/category_5.htm" >Biographies &amp; Memoirs</a>
                        </li>
                        <li class="">
                            <a href="/category_6.htm" >Business &amp; Investing</a>
                        </li>
                        <li class="">
                            <a href="/category_7.htm" >Calendars</a>
                        </li>
                        <li class="">
                            <a href="/category_8.htm" >Children&#039;s Books</a>
                        </li>
                        <li class=" last">
                            <a href="/category_9.htm" >Christian Books</a>
                        </li>
                    </ul>
                </li>
                <li class="">
                    <a href="/product.jsp" >Book Page</a>
                </li>
                <li class="">
                    <a href="/profile.jsp" >Profile Page</a>
                </li>
                <li class="">
                    <a href="/author.jsp" >Author Page</a>
                </li>
                <li class=" last">
                    <a href="/search.jsp" >Search Page</a>
                </li>
            </ul>
        </div>
        <!-- /TM Categories -->
    </div>
</div>
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
        <div id="primary_block" class="clearfix" >
            <h1>Congratulations...!!!</h1>
            <br/>
            <br/>
            <!-- right infos-->

            <div>
                <p style="padding-left: 5px;color: black;">
                    Congratulations, your order is confirmed.<br/>
                    And, the books will be delivered to you soon.<br/>
                    Make sure the books you want to share are ready to be picked up by us and the payment<br/>(Delivery charges 50 Rs. per book) is ready.<br/><br/>
                    Thank you for using our service.<br/>
                    If you liked our service then please tell your friends,too.
                </p>
            </div>
        </div>

        <br/>
        <br/>
    </div>

    <div class="clearblock"></div>
</div>

<div class="right-column-ad" style="margin-top: 80px;">
    <a href="#"><img src="/images/ad-banner.jpg" /></a>
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