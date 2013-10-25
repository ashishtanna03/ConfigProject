<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sx" uri="/struts-dojo-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <title>Add New Book (Admin) - Readers' Hive</title>

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

    <style type="text/css">
        .add-new-book {margin-bottom: 5px;line-height: 14px;margin-left: 5px;}
        select.author-publisher-list {margin-bottom: 5px;margin-left: 5px;height: 70px;width: 350px;}
        div.chosen-container {margin-left: 6px;height: 35px;}
    </style>

    <!--Chosen Plugin for multi select-->
    <link href="/js/chosen/chosen.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/js/chosen/chosen.jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $(".author-publisher-list").chosen();
            $('#cropUploadedImage').lightbox();
        });
    </script>

    <!--Script for crop image-->
    <script type="text/javascript">
        var adminLightBoxNotOpened=true;//to prevent image from opening twice in lightbox
    </script>
    <script type="text/javascript" src="/lightbox-pages/crop-image.js"></script>

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
                                <span class="navigation_page">Add New Book</span></div>
                        </div>
                        <!-- /Breadcrumb -->

                        <div class="inner_a">
                            <h1>Add New Book (Admin)</h1>
                            <hr/>

                            <s:form name="addNewForm" action="AddNewBook" method="post" enctype="multipart/form-data">
                                <s:textfield label="Book Title" name="bookTitle" cssClass="add-new-book" />

                                <s:textfield label="Book SubTitle" name="bookSubTitle" cssClass="add-new-book" />

                                <s:file label="Book Cover" id="bookImg" name="bookImg" cssClass="add-new-book" accept="image/*" onchange="cropUploadedImage('bookImg');" />
                                <s:hidden name="imageX" id="imageX" />
                                <s:hidden name="imageY" id="imageY" />
                                <s:hidden name="imageW" id="imageW" />
                                <s:hidden name="imageH" id="imageH" />
                                <a href="/lightbox-pages/crop-image.jsp?lightbox[width]=800&lightbox[height]=600" style="display: none;" id="cropUploadedImage">Crop Uploaded Image</a>
                                <img id="uploadedImage" style="display: none;" />

                                <s:textfield label="ISBN 10" name="isbn10" cssClass="add-new-book" maxlength="10" />

                                <s:textfield label="ISBN 13" name="isbn13" cssClass="add-new-book" maxlength="13" />

                                <s:textarea label="Book Description" name="bookDescription" rows="5" cols="25" cssClass="add-new-book" />

                                <s:textfield label="No. Of Pages" name="noOfPages" cssClass="add-new-book" />

                                <s:textfield label="Book MRP" name="bookMrp" cssClass="add-new-book" />

                                <s:textfield label="Book Language" name="bookLanguage" cssClass="add-new-book" />

                                <s:textfield label="Book Format" name="bookFormat" cssClass="add-new-book" />

                                <s:select list="authorList" listKey="authorId" listValue="authorName" label="Author" data-placeholder="Choose an Author..." cssClass="author-publisher-list" name="authorIds" multiple="true" />
                                <s:select list="genreList" listKey="genreId" listValue="genreName" label="Genres" data-placeholder="Choose a Genre..." cssClass="author-publisher-list" name="genreIds" multiple="true" />
                                <s:select list="publisherList" listKey="publisherId" listValue="publisherName" label="Publisher" data-placeholder="Choose a Publisher..." cssClass="author-publisher-list" name="publisherId" />

                                <sx:datetimepicker label="Publishing Year" name="publishingDate" cssClass="add-new-book" />

                                <s:hidden name="verified" value="true"/>

                                <s:submit cssClass="button" value="Add Book" align="center" />
                            </s:form>



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
<script type="text/javascript" src="/js/ga.js"></script>
</body>
</html>