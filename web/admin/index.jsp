<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sx" uri="/struts-dojo-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <title>Admin Home - Readers' Hive</title>

    <meta name="description" content="<s:property value="book.bookDescription"/>" />
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

                <div id="columns">

                    <!-- Center -->
                    <div id="center_column" class="center_column" style="width:650px;padding: 0 30px 30px 30px;">
                        <!-- Breadcrumb -->
                        <div class="breadcrumb">
                            <div class="breadcrumb_inner">
                                <a href="/admin/" title="Admin Panel Home">Admin Home</a>
                                <%--<span class="navigation-pipe">&gt;</span>--%>
                                <%--<span class="navigation_page">About Us</span></div>--%>
                        </div>
                        <!-- /Breadcrumb -->

                        <div class="inner_a">
                            <h1>Admin Home</h1>
                            <hr/>

                            <ol>
                                <li>
                                    <a href="/admin/AddNewBookPage.action" class="button2">Add New Book</a>
                                </li>
                                <li>
                                    <a href="/admin/AddNewAuthorPage.action" class="button2">Add New Author</a>
                                </li>
                                <li>
                                    <a href="/admin/add-new-publisher.jsp" class="button2">Add New Publisher</a>
                                </li>
                                <li>
                                    <a href="/admin/add-new-genre.jsp" class="button2">Add New Genre</a>
                                </li>
                            </ol>

                            <br/>
                            <br/>
                            <br/>
                            <br/>
                            <br/>

                            <a href="/admin/orders/ToBePickedUp.action" class="button2" >List of To Be Picked Up</a>

                            <br/>
                            <br/>
                            <br/>

                            <a href="/admin/orders/InPickUpProcess.action" class="button2" >List of Books in Pick Up Process</a>

                            <br/>
                            <br/>
                            <br/>

                            <a href="/admin/orders/PickedUpBooks.action" class="button2" >List of Picked Up Books</a>

                            <br/>
                            <br/>
                            <br/>

                            <a href="/admin/orders/InDeliveryProcess.action" class="button2" >List of Books in Delivery Process</a>

                        </div>

                    </div>
                    <div class="clearblock"></div>
                </div>

            </div>
                </div>

            <!-- Footer -->
            <s:include value="/footer.jsp" />

    </div>
</div>
</div>
<script type="text/javascript" src="/js/ga.js"></script>
</body>
</html>