<!-- Panel -->
<div id="toppanel">
    <div id="panel">
        <div id="loading-login" class="content clearfix">
            <img src="/images/ajax-loader.gif" alt="Loading..." />
        </div>
        <div id="before-login" class="content clearfix">
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
                    <p style="color:red;font-size:11px;display:none;" id="error-message">Username or Password is wrong.</p>
                    <label class="grey" >E=Mail ID:</label>
                    <input id="inner_username" class="field" type="text" name="log" value="" size="23" />
                    <label class="grey">Password:</label>
                    <input id="inner_password" class="field" type="password" name="pwd" size="23" />
                    <label><input name="rememberme" id="rememberme" type="checkbox" checked="checked" value="forever" /> &nbsp;Remember me</label>
                    <div class="clear"></div>
                    <a id="inner-login" class="bt_login" href="#" onclick="sendInnerLogInInfo();" >Login</a>
                    <a class="lost-pwd" href="#">Lost your password?</a>
                </form>
            </div>
            <div class="left right">
                <!-- Register Form -->
                <form action="#" method="post" id="register-form">
                    <h1>Not a member yet? Sign Up!</h1>

                    <input class="field" type="text" required="true" name="fname" id="fname" value="First Name" onfocus="clickonfname()" onblur="bluronfname()" />
                    <input class="field" type="text" required="true" name="lname" id="lname" value="Last Name" onfocus="clickonlname()" onblur="bluronlname()" />
                    <input class="field" type="email" required="true" name="email" id="email" value="E-Mail Address" onfocus="clickonemail()" onblur="bluronemail()" />
                    <input class="field" type="password" required="true" name="regpwd" id="regpwd" value="Password" onfocus="clickonregpwd()" onblur="bluronregpwd()" />
                    <%--<label>A password will be e-mailed to you.</label><br/>--%>
                    <!--Captcha-->
                    <img src='/simpleCaptcha.png' width="155" height="30" /><br/>
                    <input class="field" name="answer" id="answer" value="Enter Captcha Here" onfocus="clickoncaptcha()" onblur="bluroncaptcha()" /><br/>
                    <a href="#" name="submit" value="Register" class="bt_register" onclick="sendRegisterInfo()">Register</a>
                </form>
            </div>
        </div>
        <!--After Login-->
        <div id="after-login" class="content clearfix">
            <div class="left">
                <center><h1>Welcome, <a href="/profile.jsp" id="uname_head"><%--User Name--%></a></h1></center>
                <a href="/profile.jsp"><img id="head-user-img" class="head-pp-links" src="<%--user profile pic--%>" width="80" height="80"/></a>
                <a href="/user/UserProfile.action" class="head-pp-links">View Profile</a><br/>
                <a href="/user/EditUserProfile.action" class="head-pp-links">Edit Profile</a><br/>
                <a href="/change-pro-pic.htm" class="head-pp-links">Change Photo</a><br/><br/>
                <a id="logout" href="#" onclick="sendLogOutRequest();" class="head-pp-links">Logout</a><br/><br/>

                <h2 id="avail_points">Available Points : <b id="avail_points_value">2000</b></h2><br/>

                <h2></h2>
            </div>
            <div class="left">

                <div class="top-scrollbar">
                    <h1>Notification</h1>

                    <div class="top-scrollbar-container">
                        <ul id="notification-container">

                        </ul>

                    </div>
                    <!--/top-scrollbar-container-->
                </div>
                <!--/top-scrollbar-->
            </div>
            <div class="left right">
                <div  class="top-scrollbar">
                    <h1>Friends Activities</h1>

                    <div class="top-scrollbar-container">
                        <ul id="friends-activity-container">
                            <li>
                                <img src="/images/users/3.jpg"/>
                                <a href="#">Satyam Soni</a>
                                requested<br/>
                                <a href="#">Losing My Virginity</a>
                                by <a href="#">Richard Branson</a>.<br/>
                                by <a href="#">Richard Branson</a>.<br/>
                                Want to Share?<a href="#">Yes</a> or <a href="#">No</a>
                            </li>
                            <span>1st January, 2013</span>
                            <hr/>
                            <li>
                                <img src="/img/p/1-1-home.jpg"/>
                                <a href="#">Ashish Tanna</a>
                                marked <br/>
                                <a href="#">Losing My Virginity</a>
                                by <a href="#">Richard Branson</a>
                                as to read.
                            </li>
                            <span>21st December, 2012</span>
                            <hr/>
                            <li>
                                <img src="/img/p/1-1-home.jpg"/>
                                <a href="#">Ashish Tanna</a>
                                added <br/>
                                <a href="#">Losing My Virginity</a>
                                by <a href="#">Richard Branson</a>
                                to shelf : <a href="#">Shelf-Name</a>.
                            </li>
                            <span>21st December, 2012</span>
                            <hr/>
                        </ul>
                    </div>
                    <!--/top-scrollbar-container-->
                </div>
                <!--/top-scrollbar-->
            </div>
        </div><!--/after-login-->
    </div> <!-- /login -->

    <div class="tab">
        <form name="login-form-outer" class="login-form-outer" id="login-form-outer">
            <ul class="login">

                <li><input type="text" value="Username" id="j_username" onclick="clickonuname();" onblur="bluronuname();" /></li>
                <li><input type="text" value="Password" id="j_password" onclick="clickonpwd();" onblur="bluronpwd();"/></li>
                <li><a id="outer-login" class="open" href="#" onclick="sendLogInInfo();">Login</a></li>
                <li><a id="register" class="open" href="#" >Register</a></li>
                <li><a id="open" style="display:none;" class="open" href="#">Open Panel</a></li>
                <li id="toggle">
                    <a id="close" style="display: none;" class="close" href="#">Close Panel</a>
                </li>
            </ul>
        </form>
    </div> <!-- / tab -->
</div> <!--top-panel -->