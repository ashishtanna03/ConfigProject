<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sx" uri="/struts-dojo-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <title>Your Cart - Reader's Hive</title>

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

    <sx:head />

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
    <script type="text/javascript">
        $(document).ready(function() {
            $('.tooltip').tooltipster({
                animation: 'fade',
                timer:2000,
                trigger:'custom'
            });

            $('.cart-tooltip').tooltipster({
                animation: 'fade',
                position:'bottom'
            });
        });
    </script>
    <!--/Tootip-->

    <!--for lightbox forms-->
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

<div id="wrapper4" >

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
        <s:set var="totalBooks" value="%{0}" /> <!--Total available books-->
        <s:set var="totalDeliveryCharges" value="%{0}" />

        <s:iterator value="user.userCartsByUserId" status="iteratorStatus">
        <%--<s:if test="lendByLendId.lendStatus!=1">--%>
        <tr class="items">
            <th><s:property value="%{#iteratorStatus.index+1}"/>.</th>
            <td><a href="/book/GetBookInfo.action?bookId=<s:property value="lendByLendId.bookInfoByBookId.bookId"/>">
                <img src="<s:if test="lendByLendId.bookInfoByBookId.bookImgUrl==null">/images/no-book-cover.jpg</s:if><s:else><s:property value="lendByLendId.bookInfoByBookId.bookImgUrl"/></s:else>"
                     alt="<s:property value="lendByLendId.bookInfoByBookId.bookTitle"/>"
                     width="34" height="47"/>
            </a>
            </td>
            <td class="book-title">
                <a href="/book/GetBookInfo.action?bookId=<s:property value="lendByLendId.bookInfoByBookId.bookId"/>"><s:property value="lendByLendId.bookInfoByBookId.bookTitle"/></a>
                <s:if test="lendByLendId.bookInfoByBookId.bookAuthorsesByBookId!=null && lendByLendId.bookInfoByBookId.bookAuthorsesByBookId.size>0">
                    by&nbsp;
                    <s:iterator value="lendByLendId.bookInfoByBookId.bookAuthorsesByBookId" status="authorIteratorStatus">
                        <a href="/author/GetAuthorInfo.action?authorId=<s:property value="authorInfoByAuthorId.authorId"/>"
                           title="<s:property value="authorInfoByAuthorId.authorName"/>">
                            <s:property value="authorInfoByAuthorId.authorName"/></a>
                        <s:if test="#authorIteratorStatus.last!=true">,</s:if>
                    </s:iterator>
                </s:if>
            </td>
            <td>
                <a href="/user/UserProfile.action?userId=<s:property value="lendByLendId.userInfoByUserId.userId"/>">
                    <s:property value="lendByLendId.userInfoByUserId.firstName"/>&nbsp;<s:property value="lendByLendId.userInfoByUserId.lastName"/>
                </a>
            </td>
            <td>
                <s:if test="lendByLendId.lendStatus!=1">
                    <img src="/img/icon/available.png" class="cart-tooltip" alt="Available" title="Book is available" />

                    <!--For total available books, total price & total delivery charges-->
                    <s:set var="totalPoints" value="%{#attr.totalPoints + lendByLendId.sharingPrice}" />
                    <s:set var="totalBooks" value="%{#attr.totalBooks + 1}" />
                    <s:if test="%{#totalBooks>1}">
                        <s:set var="totalDeliveryCharges" value="%{#attr.totalDeliveryCharges + 20}" />
                    </s:if>
                    <s:else>
                        <s:set var="totalDeliveryCharges" value="%{#attr.totalDeliveryCharges + 40}" />
                    </s:else>

                </s:if>
                <s:else>
                    <img src="/img/icon/not_available.png" class="cart-tooltip" alt="Not Available" title="The book you bought is sold.<br/>But, you can check if another user<br/>has shared the same book." />
                </s:else>
            </td>
            <td><s:property value="lendByLendId.sharingPrice"/> Points</td>
            <td><a href="/cart/DeleteItem.action?lendId=<s:property value="lendByLendId.lendId"/>"><img src="/js/rating/img/cancel-on.png" alt="Remove" title="Remove Book from Cart" /></a></td>
        </tr>
            <%--</s:if>--%>
        </s:iterator>
    </table>
    <hr id="separator"/>

    <div id="cart-summary">
        <table>
            <tr>
                <th>Total Available Books :&nbsp;</th>
                <td><s:property value="%{'' + #attr.totalBooks}" /></td>
            </tr>
            <tr>
                <th>Total Bill :&nbsp;</th>
                <td>
                    <s:property value="%{'' + #attr.totalPoints}" />
                    Points
                </td>
            </tr>

            <tr class="cart-tooltip" title="If you order more than 1 book,<br/>then delivery charges of 1 book will<br/>be 40 Rs. and for others will be 20 Rs.<br/>If only 1 available book is in cart then<br/>delivery charges will be 40 Rs.">
                <th>Total Delivery Charges :&nbsp;</th>
                <td>
                    <s:property value="%{'' + #attr.totalDeliveryCharges}" /> Rs.
                </td>
            </tr>
        </table>

        <s:if test="%{#totalPoints<=user.userBalance && #totalBooks>0}">
            <%--<a href="#" class="button2" style="float: right;">Checkout >></a>--%>
            <form action="/cart/Checkout.action" method="post">
                <a href="/lightbox-pages/shipping-address.jsp?lightbox[width]=362&lightbox[height]=350&address=<s:property value="user.userAddress"/>&contactNo=<s:property value="user.userContact"/>&pincode=<s:property value="user.userPostalCode"/>"
                   class="button2 cart-tooltip" id="shipping-add"
                   title="Only the books which are currently<br/>available will be added in the final<br/>order. And, the books which are not<br/>available will be removed from the cart."
                        >Checkout >></a>
            </form>
        </s:if>
        <s:elseif test="%{#totalBooks==0}">
            <br/><b>You don't have any books available in your cart.</b>
        </s:elseif>
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

    <div class="right-column-ad" style="margin-top: 80px;">
        <a href="#"><img src="/images/ad-banner.jpg" /></a>
    </div>

    <div class="right-column-top10">
        <h2>Popular Books</h2>
        <ol type="1">
            <s:iterator value="topTenBooks">
                <a href="/book/GetBookInfo.action?bookId=<s:property value="bookId"/>" title="<s:property value="bookTitle"/>"><li><s:property value="bookTitle"/></li></a>
            </s:iterator>
        </ol>
    </div>

</div><!--/wrapper4-->

    <!-- Footer -->
    <s:include value="footer.jsp" />

</div>
</div>
</div>
<script type="text/javascript" src="/js/ga.js"></script>
</body>
</html>