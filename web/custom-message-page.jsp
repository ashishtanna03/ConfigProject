<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sx" uri="/struts-dojo-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <title><s:if test="resultHeader!=null"><s:property value="resultHeader"/></s:if><s:else><%=request.getParameter("resultHeader")%></s:else> - Readers' Hive</title>

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
                        <div class="inner_a">
                            <h1>
                                <s:if test="resultHeader!=null"><s:property value="resultHeader"/></s:if>
                                <s:else><%=request.getParameter("resultHeader")%></s:else>
                            </h1>
                            <hr/>

                            <p>
                                <s:if test="resultMessage!=null"><s:property escape="false" escapeJavaScript="false" value="resultMessage.replace(\"\n\", \" <br />\")" /></s:if>
                                <s:else><%=request.getParameter("resultMessage")%></s:else>
                            </p>

                        </div>

                    </div>
                    <div class="clearblock"></div>
                </div>

                <div class="right-column-ad" style="margin-top: 80px;">
                    <a href="#"><img src="/images/ad-banner.jpg" /></a>
                </div>

            </div>

            <!-- Footer -->
            <s:include value="footer.jsp" />

        </div>
    </div>
</div>
</div>
<script type="text/javascript" src="/js/ga.js"></script>
</body>
</html>