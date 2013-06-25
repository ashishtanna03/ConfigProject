<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sx" uri="/struts-dojo-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <sx:head />
    <title>Edit Profile- ReadersHive</title>
    <meta name="description" content="Use our form to contact us"/>
    <meta name="keywords" content="contact, form, e-mail"/>
    <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8"/>
    <meta name="generator" content="PrestaShop"/>
    <meta name="robots" content="index,follow"/>
    <link rel="icon" type="image/vnd.microsoft.icon" href="/img/favicon.ico"/>
    <link rel="shortcut icon" type="image/x-icon" href="/img/favicon.ico"/>
    <link href='http://fonts.googleapis.com/css?family=PT+Sans' rel='stylesheet' type='text/css'>
    <link href="/css/edit-prof.css" rel="stylesheet" type="text/css" media="screen"/>
    <link href="/css/global.css" rel="stylesheet" type="text/css" media="all"/>
    <script type="text/javascript" src="/js/jquery/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.easing.1.3.js"></script>
    <script type="text/javascript" src="/js/tools.js"></script>
    <!-- Javascript files -->
    <script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="/js/edit-prof.js"></script>
    <script type="text/javascript" src="/js/ajax-request.js"></script>

    <sx:head />

    <script src="/js/top-panel-input.js" type="text/javascript"></script>

    <!--Top panel-->
    <script src="/js/slide.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/css/style.css" type="text/css" media="screen" />
    <link rel="stylesheet" href="/css/slide.css" type="text/css" media="screen" />

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

</head>
<body id="contact-form">
<!--[if lt IE 7]>
<div style='clear:both;height:59px;padding:0 15px 0 15px;position:relative;z-index:10000;text-align:center;'><a
        href="http://www.microsoft.com/windows/internet-explorer/default.aspx?ocid=ie6_countdown_bannercode"><img
        src="http://www.theie6countdown.com/images/upgrade.jpg" border="0" height="42" width="820"
        alt="You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today."/></a>
</div><![endif]-->
<div id="wrapper1">
<div id="wrapper2">
<div id="wrapper3">

<!--Top Panel-->
<s:include value="/top-panel.jsp"/>

<div id="wrapper4">
<!-- Header -->
<jsp:include page="/header.jsp" flush="true"/>

<div id="columns">
<!-- Left -->
<div id="left_column" class="column">
<script type="text/javascript">
    var CUSTOMIZE_TEXTFIELD = 1;
    var customizationIdMessage = 'Customization #';
    var removingLinkText = 'remove this product from my cart';
</script>
<!-- MODULE Block cart -->


<!--edit-prof js-->

<script type="text/javascript">

    $(document).ready(function () {
        var counter = 2;
        $("#addButton").click(function () {

            if (counter > 10) {
                alert("Only 10 textboxes allow");
                return false;
            }
            /*
             var newTextBoxDiv = $(document.createElement('div')).attr("id", 'TextBoxDiv' + counter);
             newTextBoxDiv.appendTo("#TextBoxesGroup");
             newTextBoxDiv.after('<label>Textbox #' + counter + ' : </label>' + '<input type="text" name="textbox' + counter + '" id="textbox' + counter + '" value="" />');
             */

            var $Div = $('<div id="TextBoxDiv' + counter + '"></div>')
            $Div.append('<p class="text">' + '<label><b>Add Book </b>' + ' : </label>' + '<input type="text" name="textbox' + counter + '" id="textbox' + counter + '" value="" />' + '</p>');
            $('#TextBoxesGroup').append($Div);
            //alert("wel2");
            counter++;
        });

        $("#removeButton").click(function () {
            if (counter == 1) {
                alert("No more textbox to remove");
                return false;
            }
            counter--;
            $("#TextBoxDiv" + counter).remove();
        });

    });
</script>
<!--/edit prof curent & shelve -->
<!-- Center -->
<div id="center_column" class="center_column">

<!-- Breadcrumb -->
<div class="breadcrumb">
    <div class="breadcrumb_inner">
        <a href="/prestashop_37364.html" title="return to Home">Home</a><span class="navigation-pipe">&gt;</span><span
            class="navigation_page">Contact</span></div>
</div>
<!-- /Breadcrumb --><h1>My Account</h1>
<a href="/user/UserProfile.action" id="view-pro" class="button_small">See My Profile</a>

<div class="mainContainer">
<div class="htmltabs">
<!-- The tabs -->
<ul class="tabs">
    <li class="tab1">
        <a class="tab1 tab">
            Profile
        </a>
    </li>
    <li class="tab2">
        <a class="tab2 tab">
            Settings
        </a>
    </li>
    <li class="tab3">
        <a class="tab3 tab">
            Currently Reading & Shelves
        </a>
    </li>


</ul>
<!-- tab 1 -->
<div class="tab1 tabsContent">
    <div>
        <form action="edit-profile.jsp" method="post" class="std" enctype="multipart/form-data">
            <fieldset>
                <h3>Personal Settings</h3>

                <p class="text">
                    <label><b>First Name :</b></label>
                    <input type="text" id="fname" name="f-name" value="<s:property value="user.firstName"/>"/>
                </p>

                <p class="text">
                    <label><b>Last Name :</b></label>
                    <input type="text" id="lname" name="l-name" value="<s:property value="user.lastName"/>"/>
                </p>

                <p id="settings-gender" class="radio">
                    <label><b>Gender :</b></label>
                        <input name="gender" type="radio" value="M">&nbsp;Male</input>
                        <input name="gender" type="radio" value="F">&nbsp;Female</input>

                    <script type="text/javascript">
                        var userGender = "<s:property value="user.userGender"/>";
                        if(userGender =="M"){
                            document.getElementsByName("gender")[0].checked=true;
                        }else{
                            document.getElementsByName("gender")[1].checked=true;
                        }
                    </script>

                </p>
                <p class="text">
                    <label><b>BirthDate :</b></label>
                    <sx:datetimepicker id="birth-date" name="userBirthdate" displayFormat="dd/MM/yyyy" value="user.userBirthdate" />
                </p>

                <p class="text">
                    <label><b>City :</b></label>
                    <%--<input type="text" id="city-name" name="city_name" value="<s:property value="user.userCity"/>"/>--%>
                    <select name="city-name" id="city-name">

                        <option value=""></option>
                        <option value="Ahmedabad">Ahmedabad</option>
                        <option value="Vadodra">Vadodra</option>
                        <option value="Surat">Surat</option>
                        <option value="Jamnagar">Jamnagar</option>
                        <script type="text/javascript">
                            $("#city-name option[value='<s:property value="user.userCity"/>']").attr("selected", true);
                        </script>
                    </select>
                </p>

                <p class="text">
                    <label><b>Postal Code :</b></label>
                    <input type="text" id="postal-code" name="p-code" value="<s:property value="user.userPostalCode"/>"/>
                </p>

                <p class="text">
                    <label><b>Occupation :</b></label>
                    <input type="text" id="occuname" name="o-name" value="<s:property value="user.userOccupation"/>"/>
                </p>

                <p class="text">
                    <label><b>Favourite Genres:</b></label>
                    <input type="text" id="favgen" name="f-genre"
                           value='<s:iterator value="user.userFavGenresesByUserId" status="iteratorStatus"><s:property value="genresByGenreId.genreName"/><s:if test="#iteratorStatus.last!=true">,</s:if></s:iterator>'
                            />
                </p>

                <p class="text">
                    <label><b>Website/Blog:</b></label>
                    <input type="text" id="web-blo" name="w-b" value="<s:property value="user.userWebsite"/>"/>
                </p>

                <p class="text">
                    <label><b>Contact No :</b></label>
                    <input type="text" id="contact-no" name="contact-no"value="<s:property value="user.userContact"/>"/>
                </p>

                <p class="textarea">
                    <label><b>Address :</b></label>
                    <textarea id="user-add" name="abt_me" rows="5" cols="50"><s:property value="user.userAddress"/></textarea>
                </p>

                <p class="submit">
                    <a name="savechange" href="javascript:{}" id="save-changes" class="button_small tooltip" onclick="saveProfileChanges();" title="">Save Changes</a>
                    <input type="submit" name="cancel" id="cancel-changes" value="Cancel" class="button_small"/>
                </p>

        </form>
    </div>
</div>
<!-- end of t1 -->
<!-- tab 2 -->
<div class="tab2 tabsContent">
    <div>
        <form action="edit-profile1.htm" method="post" class="std" enctype="multipart/form-data">
            <fieldset>
                <h3>Change Password</h3>

                <p class="password">
                    <label><b>Old Password :</b></label>
                    <input type="password" id="old_pwd" name="old-pwd" value=""/>
                </p>

                <p class="password">
                    <label><b>New Password :</b></label>
                    <input type="password" id="new_pwd" name="new-pwd" value=""/>
                </p>

                <p class="password">
                    <label><b>Confirm Password :</b></label>
                    <input type="password" id="conf_pwd" name="conf-pwd" value=""/>
                </p>

                <%--<h3>Privacy Settings</h3>

                <p class="radio">
                    <label><b>Who Can View My Profile ??</b></label><br/><br/>
                    <input type="radio" id="anyone" name="viewprof" value=""/><b>Anyone can see</b><br/>
                    <input type="radio" id="anyone" name="viewprof" value=""/><b>Readershive Members</b><br/>
                    <input type="radio" id="anyone" name="viewprof" value=""/><b>Only Friends</b>
                </p>

                <p class="radio">
                    <label for="reqbk"><b>Who Can Request For Book ??</b></label><br/><br/>
                    <input type="radio" id="anyone1" name="reqbk" value=""/><b>Readershive Members</b><br/>
                    <input type="radio" id="anyone1" name="reqbk" value=""/><b>Only Friends</b><br/>

                </p>

                <p class="radio">
                    <label for="recbk"><b>Who Can Recommand a Book ??</b></label><br/><br/>
                    <input type="radio" id="anyone2" name="recbk" value=""/><b>Readershive Members</b><br/>
                    <input type="radio" id="anyone2" name="recbk" value=""/><b>Only Friends</b><br/>

                </p>--%>

                <p class="submit">
                    <a name="savechange" href="javascript:{}" id="save-changes2" class="button_small tooltip" onclick="changePassword();">Save Changes</a>
                    <input type="submit" id="cancel-changes2" name="cancel" value="Cancel" class="button_small"/>
                </p>
            </fieldset>
        </form>

    </div>
</div>
<!-- end of t2 -->
<!-- tab 3 -->
<div class="tab3 tabsContent">
    <div>
        <form action="edit-profile2.htm" method="post" class="std" enctype="multipart/form-data">
            <fieldset>
                <h3>Currently Reading</h3>

                <p class="text">
                    <label><b>Book Name:</b></label>
                    <input type="text" id="cr_name" name="cr-name" value="Loosing my Virginity"/>
                </p>

                <h3>Shelves</h3>

                <p class="text">
                    <label><b>Shelf Name:</b></label>
                    <input type="text" id="sh_name" name="sh-name" value=""/>
                </p>

                <div id='TextBoxesGroup'>
                    <div id="TextBoxDiv1">
                        <p class="text">
                            <label><b>Add Book: </b></label><input type='text' id='textbox1'/>
                        </p>
                    </div>
                </div>
                <p class="submit">
                    <input type='button' value='Add' id='addButton' class="button_small"/>
                    <input type='button' value='Remove' id='removeButton' class="button_small"/>
                </p>

                <p class="submit">
                    <input type="submit" name="savechange" id="save-changes3" value="Save Changes"
                           class="button_small"/>
                    <input type="submit" name="cancel" id="cancel-changes3" value="Cancel" class="button_small"/>
                </p>
            </fieldset>
        </form>
    </div>
</div>
<!-- end of t3 -->


</div>
<!-- tabbed ends here-->
</div>
<!-- mainContainer ends here-->

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
                    <li><a href="/contact-form.htm">Contact</a></li>
                    <li><a href="/cms.htm">Delivery</a></li>
                    <li><a href="/cms_2.htm">Legal Notice</a></li>
                    <li><a href="/cms_3.htm">Terms and conditions</a></li>
                    <li><a href="/cms_4.htm">About us</a></li>
                </ul>
            </div>
            <div>
                <h4>Our offers</h4>
                <ul>
                    <li><a href="/new-products.htm">New products</a></li>
                    <li><a href="/best-sales.htm">Top sellers</a></li>
                    <li><a href="/search.jsp">Specials</a></li>
                    <li><a href="/manufacturer.htm">Manufacturers</a></li>
                    <li><a href="/supplier.htm">Suppliers</a></li>
                </ul>
            </div>
            <div>
                <h4>Your Account</h4>
                <ul>
                    <li><a href="http://livedemo00.template-help.com/prestashop_37364/my-account.php">Your Account</a>
                    </li>
                    <li><a href="http://livedemo00.template-help.com/prestashop_37364/identity.php">Personal
                        information</a></li>
                    <li><a href="http://livedemo00.template-help.com/prestashop_37364/addresses.php">Addresses</a></li>
                    <li><a href="http://livedemo00.template-help.com/prestashop_37364/discount.php">Discount</a></li>
                    <li><a href="http://livedemo00.template-help.com/prestashop_37364/history.php">Order history</a>
                    </li>
                </ul>
            </div>
            <p>&copy; 2012 Powered by <a href="../www.prestashop.com/www_prestashop_default_2.html">PrestaShop</a>&trade;.
                All rights reserved</p>
        </div>
        <!-- tmsocial -->
        <div id="tmsocial">

            <a class="banner1" href='http://livedemo00.template-help.com/twitter.com/twitter_default_2.html'><img
                    src='/modules/tmsocial/slides/slide_00.png' alt="" title=""/></a>
            <a class="banner2" href='http://facebook.com'><img src='/modules/tmsocial/slides/slide_01.png' alt=""
                                                               title=""/></a>
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
