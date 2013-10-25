<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sx" uri="/struts-dojo-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <title>List of Books in Pick Up Process (Admin) - Readers' Hive</title>

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

    <!--orders table-->
    <style type="text/css">
        table#orders-table{width: 650px;text-align: center;}
        table#orders-table th{font-weight: bold;font-size: 16px;line-height: 40px;}
        table#orders-table tr.items {height: 55px;}
        table#orders-table td{vertical-align: middle;}
        table#orders-table td.book-title{max-width: 200px;}
    </style>
    <!--/orders table-->

    <script type="text/javascript">
        /*----------Mark Selected Books as Picked Up--------------*/

        function markBooksAsPickedUp() {
            var pickedUpReq;
            var pickedUpResJson;
            var pickedUpRes;
            var pickedUpUrl="/admin/orders/MarkAsPickedUp.action?";

            var selectedBorrowIds = "";

            $("input:checkbox[name=picked-up]:checked").each(function() {
                selectedBorrowIds += "selectedBorrowIds="+$(this).val()+"&";
            });
            //removing "&" from the end
            selectedBorrowIds  = selectedBorrowIds.substring(0, selectedBorrowIds.length-1);
            //appending selected ids values to the url
            pickedUpUrl+=selectedBorrowIds;

            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                pickedUpReq = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                pickedUpReq = new ActiveXObject("Microsoft.XMLHTTP");
            }

            pickedUpReq.onreadystatechange = function () {
                if (pickedUpReq.readyState == 4 && pickedUpReq.status == 200) {
                    pickedUpRes=pickedUpReq.response;
                    pickedUpResJson = JSON && JSON.parse(pickedUpRes) || $.parseJSON(pickedUpRes);

                    if(pickedUpResJson.result=="success"){
                        location.reload();
                    } else {
                        window.location.href = "http://localhost:8080/error.jsp";
                    }
                }
            };

            pickedUpReq.open('POST',pickedUpUrl,true);
            pickedUpReq.send();
        }

        /*----------/Mark Selected Books as Picked Up--------------*/

        /*----------Mark Selected Books as Not Picked Up--------------*/

        function markBooksAsNotAvailable() {
            var notAvailableReq;
            var notAvailableResJson;
            var notAvailableRes;
            var notAvailableUrl="/admin/orders/MarkAsNotAvailable.action?";

            var selectedBorrowIds = "";

            $("input:checkbox[name=picked-up]:checked").each(function() {
                selectedBorrowIds += "selectedBorrowIds="+$(this).val()+"&";
            });
            //removing "&" from the end
            selectedBorrowIds  = selectedBorrowIds.substring(0, selectedBorrowIds.length-1);
            //appending selected ids values to the url
            notAvailableUrl+=selectedBorrowIds;

            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                notAvailableReq = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                notAvailableReq = new ActiveXObject("Microsoft.XMLHTTP");
            }

            notAvailableReq.onreadystatechange = function () {
                if (notAvailableReq.readyState == 4 && notAvailableReq.status == 200) {
                    notAvailableRes=notAvailableReq.response;
                    notAvailableResJson = JSON && JSON.parse(notAvailableRes) || $.parseJSON(notAvailableRes);

                    if(notAvailableResJson.result=="success"){
                        location.reload();
                    } else {
                        window.location.href = "http://localhost:8080/error.jsp";
                    }
                }
            };

            notAvailableReq.open('POST',notAvailableUrl,true);
            notAvailableReq.send();
        }

        /*----------/Mark Selected Books as Not Picked Up--------------*/

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

                <div id="columns">

                    <!-- Center -->
                    <div id="center_column" class="center_column" style="width:650px;padding: 0 30px 30px 30px;">
                        <!-- Breadcrumb -->
                        <div class="breadcrumb">
                            <div class="breadcrumb_inner">
                                <a href="/admin/" title="Admin Panel Home">Admin Home</a>
                                <span class="navigation-pipe">&gt;</span>
                                <span class="navigation_page">List of Books in Pick Up Process</span></div>
                        </div>
                        <!-- /Breadcrumb -->

                        <div class="inner_a">
                            <h1>List of Books in Pick Up Process (Admin)</h1>
                            <hr/>

                            <table id="orders-table" width="600">
                                <tr>
                                    <th>Order Id</th>
                                    <th colspan="2">Book</th>
                                    <th>Book Shared By</th>
                                    <th>&nbsp;</th>
                                </tr>

                                <s:iterator value="inPickUpProcessList" status="iteratorStatus">
                                    <tr class="items">
                                        <th><s:property value="borrowId"/>.</th>
                                        <td>
                                            <a href="/book/GetBookInfo.action?bookId=<s:property value="bookInfoByBookId.bookId"/>">
                                                <img src="<s:if test="bookInfoByBookId.bookImgUrl==null">/images/no-book-cover.jpg</s:if><s:else><s:property value="bookInfoByBookId.bookImgUrl"/></s:else>"
                                                     alt="<s:property value="bookInfoByBookId.bookTitle"/>"
                                                     width="34" height="47"/>
                                            </a>
                                        </td>
                                        <td class="book-title">
                                            <a href="/book/GetBookInfo.action?bookId=<s:property value="bookInfoByBookId.bookId"/>"><s:property value="bookInfoByBookId.bookTitle"/></a>
                                            <s:if test="bookInfoByBookId.bookAuthorsesByBookId!=null && bookInfoByBookId.bookAuthorsesByBookId.size>0">
                                                by&nbsp;
                                                <s:iterator value="bookInfoByBookId.bookAuthorsesByBookId" status="authorIteratorStatus">
                                                    <a href="/author/GetAuthorInfo.action?authorId=<s:property value="authorInfoByAuthorId.authorId"/>"
                                                       title="<s:property value="authorInfoByAuthorId.authorName"/>">
                                                        <s:property value="authorInfoByAuthorId.authorName"/></a>
                                                    <s:if test="#authorIteratorStatus.last!=true">,</s:if>
                                                </s:iterator>
                                            </s:if>

                                            <br/>
                                            <b>Publisher : </b><s:property value="bookInfoByBookId.publisherInfoByPublisherId.publisherName" />
                                        </td>
                                        <td>
                                            <a href="/user/UserProfile.action?userId=<s:property value="lendByLendId.userInfoByUserId.userId"/>">
                                                <s:property value="lendByLendId.userInfoByUserId.firstName"/>&nbsp;<s:property value="lendByLendId.userInfoByUserId.lastName"/>
                                            </a>

                                            <br/>
                                            <b>Shipping Address :</b><br/>
                                            <s:property value="orderInfoByOrderId.shippingAddress" />
                                        </td>

                                        <td>
                                            <input name="picked-up" type="checkbox" checked="checked" value="<s:property value="borrowId"/>" />
                                        </td>

                                    </tr>
                                </s:iterator>

                                <!--For total price & total delivery charges-->
                            </table>

                            <br/>
                            <br/>

                            <a href="javascript:{}" class="button2" onclick="markBooksAsPickedUp()">Mark selected books as Picked Up</a>
                            <a href="javascript:{}" class="button2" onclick="markBooksAsNotAvailable()">Mark selected books as Not Available</a>

                        </div>

                    </div>
                    <div class="clearblock"></div>
                </div>

            </div>

            <!-- Footer -->
            <s:include value="/footer.jsp" />

        </div>
    </div>
</div>
</body>
</html>