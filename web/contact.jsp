<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sx" uri="/struts-dojo-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<title>Contact us - Readers' Hive</title>
	<meta name="description" content="Use our form to contact us" />
	<meta name="keywords" content="contact, form, e-mail" />
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
	<meta name="generator" content="PrestaShop" />
	<meta name="robots" content="index,follow" />
	<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />

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

    <!--Contact Us CSS-->
    <link href="/css/contact-us.css" rel="stylesheet" type="text/css" />
</head>
<body id="contact-form">
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
            <!-- Breadcrumb -->
            <div class="breadcrumb">
                <div class="breadcrumb_inner">
	                <a href="/index.jsp" title="Return to Home">Home</a>
                    <span class="navigation-pipe">&gt;</span>
                    <span class="navigation_page">Contact Us</span>
                </div>
            </div>
            <!-- /Breadcrumb -->

            <h1>Contact us</h1>
            <br/>
            <form id="contact-form" method="post" class="form" action="#" enctype="multipart/form-data">
                <div class="form-row">
                    <label for="contact-name" class="form-label">Your Name</label>
                    <div class="form-item">
                        <input type="text" name="uname" id="contact-name" class="small required" />
                    </div>
                </div>
                <div class="form-row">
                    <label for="contact-email" class="form-label">Your Email</label>
                    <div class="form-item">
                        <input type="text" name="email" id="contact-email" class="small required email" />
                    </div>
                </div>
                <div class="form-row">
                    <label for="contact-subject" class="form-label">Subject</label>
                    <div class="form-item">
                        <input type="text" name="subject" id="contact-subject" class="small required" />
                    </div>
                </div>
                <div class="form-row">
                    <label for="contact-message" class="form-label">Message</label>
                    <div class="form-item">
                        <textarea class="large required" cols="35" rows="5" name="message" id="contact-message" ></textarea>
                    </div>
                </div>
                <div class="button-row">
                    <input type="button" id="send-mail" value="Submit Query" onclick="sendMessage();" class="btn btn-success" />
                </div>
            </form>


            <%--<form action="contact.jsp" method="post" class="std" enctype="multipart/form-data">
                <fieldset>
                    &lt;%&ndash;<h3>Send a message</h3>&ndash;%&gt;
                    <p class="select">
                        <label for="contact-name"><b>Your Name :</b></label><br/>
                        <input type="text" id="contact-name" value=""/>
                    </p>

                    <p class="text">
                        <label for="email"><b>E-mail address :</b></label>
                        <input type="text" id="email" name="from" value=""/>
                    </p>

                    <p class="select">
                        <label for="subject"><b>Subject :</b></label>
                        <input type="text" id="subject" value=""/>
                    </p>

                    <p class="textarea">
                        <label for="message"><b>Message :</b></label>
                        <textarea id="message" name="message" rows="15" cols="20"></textarea>
                    </p>

                    <p class="submit">
                        <a href="javascript:{}" id="send-mail" class="button2">Send Message</a>
                    </p>

                    <h3>
                    </h3>

                    <h3>
                        Or Send Us mail at: contact@readershive.com
                    </h3>

                    <p class="submit">
                        <a href="mailto:contact@readershive.com" class="button2">Click to Send Mail</a>
                    </p>
                </fieldset>
            </form>--%>
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

<script type="text/javascript" src="js/ga.js"></script>

</body>
</html>
