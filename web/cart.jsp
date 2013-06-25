<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sx" uri="/struts-dojo-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <title>Your Cart - Reader's Hive</title>

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

    <sx:head />

    <script type="text/javascript" src="/js/ajax-request.js"></script>

    <script src="/js/top-panel-input.js" type="text/javascript"></script>

    <!--shopping cart table-->
    <style type="text/css">
        table#shopping-cart{width: 650px;text-align: center;}
        table#shopping-cart th{font-weight: bold;font-size: 16px;line-height: 40px;}
        table#shopping-cart tr.items {height: 55px;}
        table#shopping-cart td{vertical-align: middle;}
        table#shopping-cart td.book-title{max-width: 200px;}

        #separator {width: 650px;}

        div#cart-summary{float: right;padding-right: 58px;}
        div#cart-summary table{font-size: 14px;}
        div#cart-summary table tr{height: 20px;}
        div#cart-summary table th{text-align: right;}
        div#cart-summary table td{font-weight: bold;}
    </style>
    <!--/shopping cart table-->

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

<!--Top Panel-->
<s:include value="/top-panel.jsp"/>

<div id="wrapper4" style="min-height:1400px;">

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
        Shopping Cart
    </div>
</div>
<!-- /Breadcrumb -->
<div id="primary_block" class="clearfix" style="height:541px;">
<h1>Shopping Cart</h1>
<br/>
<br/>
<!-- right infos-->

<div>
    <s:if test="user.userCartsByUserId.size()>0">
    <table id="shopping-cart" width="600">
        <tr>
            <th>Sr. No.</th>
            <th colspan="2">Book</th>
            <th>Book Shared By</th>
            <th>Avail.</th>
            <th>Price</th>
            <th>&nbsp;</th>
        </tr>

        <s:set var="totalPoints" value="%{0}" />
        <s:set var="totalDeliveryCharges" value="%{0}" />

        <s:iterator value="user.userCartsByUserId" status="iteratorStatus">
        <s:if test="lendByLendId.lendStatus!=1">
        <tr class="items">
            <th><s:property value="%{#iteratorStatus.index+1}"/>.</th>
            <td><a href="/book/GetBookInfo.action?bookId=<s:property value="lendByLendId.bookInfoByBookId.bookId"/>">
                <img src="<s:if test="lendByLendId.bookInfoByBookId.bookImgUrl==null">/images/no-book-cover.jpg</s:if><s:else><s:property value="lendByLendId.bookInfoByBookId.bookImgUrl"/></s:else>"
                     alt="<s:property value="lendByLendId.bookInfoByBookId.bookTitle"/>"
                     width="34" height="47"/>
            </a>
            </td>
            <td class="book-title">
                <a href="#"><s:property value="lendByLendId.bookInfoByBookId.bookTitle"/></a>
                <s:if test="lendByLendId.bookInfoByBookId.bookAuthorsesByBookId!=null && lendByLendId.bookInfoByBookId.bookAuthorsesByBookId.size>0">
                    by&nbsp;
                    <s:iterator value="lendByLendId.bookInfoByBookId.bookAuthorsesByBookId" status="authorIteratorStatus">
                        <a href="/author/GetAuthorInfo.action?authorId=<s:property value="authorInfoByAuthorId.authorId"/>"
                           title="<s:property value="authorInfoByAuthorId.authorName"/>">
                            <s:property value="authorInfoByAuthorId.authorName"/>
                        </a>
                        <s:if test="#authorIteratorStatus.last!=true">,</s:if>
                    </s:iterator>
                </s:if>
            </td>
            <td>
                <a href="/user/UserProfile.action?emailId=<s:property value="lendByLendId.userInfoByUserId.loginInfoByEmailId.emailId"/>">
                    <s:property value="lendByLendId.userInfoByUserId.firstName"/>&nbsp;<s:property value="lendByLendId.userInfoByUserId.lastName"/>
                </a>
            </td>
            <td>
                <img src="/img/icon/available.png" alt="Available"/>
            </td>
            <td><s:property value="lendByLendId.sharingPrice"/> Points</td>
            <td><a href="/cart/DeleteItem.action?lendId=<s:property value="lendByLendId.lendId"/>"><img src="/js/rating/img/cancel-on.png" alt="Remove"/></a></td>
        </tr>

            <!--For total price & total delivery charges-->
            <s:set var="totalPoints" value="%{#attr.totalPoints + lendByLendId.sharingPrice}" />
            <s:set var="totalDeliveryCharges" value="%{#attr.totalDeliveryCharges + 50}" />
            </s:if>
        </s:iterator>
    </table>
    <hr id="separator"/>

    <div id="cart-summary">
        <table>
            <tr>
                <th>Total Books :&nbsp;</th>
                <td><s:property value="user.userCartsByUserId.size()"/></td>
            </tr>
            <tr>
                <th>Total Bill :&nbsp;</th>
                <td>
                    <s:property value="%{'' + #attr.totalPoints}" />
                    Points
                </td>
            </tr>

            <tr>
                <th>Total Delivery Charges :&nbsp;</th>
                <td>
                    <s:property value="%{'' + #attr.totalDeliveryCharges}" />Rs.
                </td>
            </tr>
        </table>

        <s:if test="%{#totalPoints<=user.userBalance}">
            <%--<a href="#" class="button2" style="float: right;">Checkout >></a>--%>
            <form action="/cart/Checkout.action" method="post">
                <a href="/lightbox-pages/shipping-address.jsp?lightbox[width]=362&lightbox[height]=300&address=<s:property value="user.userAddress"/>&contactNo=<s:property value="user.userContact"/>" class="button2"id="shipping-add">Checkout >></a>
            </form>
        </s:if>
        <s:else>
            <br/><b>You don't have enough points<br/>to buy these books.</b>
        </s:else>
    </div>
    </s:if>
    <s:else><b><center>You don't have any books in your cart.</center></b></s:else>
</div>
</div>


<br/>



<br/>
</div>

<div class="clearblock"></div>
</div>

<div class="right-column">
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
</div>

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