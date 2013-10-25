<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Crop Profile Picture</title>

    <script src="/js/jquery.Jcrop.js"></script>
    <script type="text/javascript">

        jQuery(function($){

            if (!lightBoxNotOpened) {
                jQuery(".jcrop-holder").remove();
//                jQuery("#uploadedImage").attr("value",jQuery("#uploaded-image").attr("src"));
                jQuery("#target").attr("src", jQuery("#uploaded-image").attr("src"));//setting target image source
                jQuery("#preview-pane .preview-container img").attr("src", jQuery("#uploaded-image").attr("src"));//setting target image source
                // Create variables (in this scope) to hold the API and image size
                var jcrop_api,
                        boundx,
                        boundy,

                // Grab some information about the preview pane
                        $preview = $('#preview-pane'),
                        $pcnt = $('#preview-pane .preview-container'),
                        $pimg = $('#preview-pane .preview-container img'),

                        xsize = $pcnt.width(),
                        ysize = $pcnt.height();

                console.log('init', [xsize, ysize]);
                $('#target').Jcrop({
                    onChange: updatePreview,
                    onSelect: updatePreview,
                    aspectRatio: xsize / ysize
                }, function () {
                    // Use the API to get the real image size
                    var bounds = this.getBounds();
                    boundx = bounds[0];
                    boundy = bounds[1];
                    // Store the API in the jcrop_api variable
                    jcrop_api = this;

                    // Move the preview into the jcrop container for css positioning
                    //$preview.appendTo(jcrop_api.ui.holder);
                });
            }
            else {
                lightBoxNotOpened = false;
            }

            function updatePreview(c)
            {
                $('#imgX').val(c.x);
                $('#imgY').val(c.y);
                $('#imgW').val(Math.floor(c.w)-1);
                $('#imgH').val(Math.floor(c.h)-1);
                if (parseInt(c.w) > 0)
                {
                    var rx = xsize / c.w;
                    var ry = ysize / c.h;

                    $pimg.css({
                        width: Math.round(rx * boundx) + 'px',
                        height: Math.round(ry * boundy) + 'px',
                        marginLeft: '-' + Math.round(rx * c.x) + 'px',
                        marginTop: '-' + Math.round(ry * c.y) + 'px'
                    });
                }
            }


        });

        function submitCropImageForm() {
            document.cropImageForm.submit();
        }

    </script>
    <link rel="stylesheet" href="/css/jcrop/main.css" type="text/css" />
    <link rel="stylesheet" href="/css/jcrop/demos.css" type="text/css" />
    <link rel="stylesheet" href="/css/jcrop/jquery.Jcrop.css" type="text/css" />
    <style type="text/css">

            /* Apply these styles only when #preview-pane has
               been placed within the Jcrop widget */

        .jcrop-holder {
            vertical-align:middle;
            display:inline-block;
        }

        #preview-pane {
            display: block;
            position: absolute;
            z-index: 2000;
            margin-top: -230px;
            margin-left: 495px;
            padding: 6px;
            border: 1px rgba(0,0,0,.4) solid;
            background-color: white;

            -webkit-border-radius: 6px;
            -moz-border-radius: 6px;
            border-radius: 6px;

            -webkit-box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2);
            -moz-box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2);
            box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2);
        }

            /* The Javascript code will set the aspect ratio of the crop
               area based on the size of the thumbnail preview,
               specified here */
        #preview-pane .preview-container {
            width: 165px;
            height: 165px;
            overflow: hidden;
        }

        #target {
            max-height:280px;
            max-width:280px;
        }

        a.button2:hover {text-decoration: none!important;}

    </style>

</head>
<body>

<div class="container">
    <div class="row">
        <div class="span12">
            <div class="jc-demo-box">

                <div class="page-header">
                    <h1 style="text-align: center;">Crop Profile Picture</h1>
                </div>

                <h2 style="width: 125px; display: inline; margin-left: 78px;line-height: 40px;">Original</h2>
                <h2 style="width: 125px; display: inline; float: right; margin-top: 52px; margin-right: 91px;line-height: 40px;">Preview</h2>
                <div style="width:280px;height:280px;margin-left:5px;line-height:280px;border:1px solid black;text-align: center;">
                    <img src="" id="target" alt="Uploaded Image" />
                </div>

                <div id="preview-pane">
                    <div class="preview-container">
                        <img src="" id="preview-image" class="jcrop-preview" alt="Preview Thumbnail" />
                    </div>
                </div>

                <div style="text-align: center;float: left;width: 750px;">
                    <a href="javascript:submitCropImageForm()" style="float: none;margin-top: 67px;display: inline-block;" class="button2" >Crop & Upload Image</a>
                </div>

                <div class="clearfix"></div>

            </div>
        </div>
    </div>
</div>

</body>
</html>

