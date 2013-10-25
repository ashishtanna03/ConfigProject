function cropUploadedImage(fileId) {
    var fileElement = document.getElementById(fileId);
    var fileExtension = "";
    if (fileElement.value.lastIndexOf(".") > 0) {
        fileExtension = fileElement.value.substring(fileElement.value.lastIndexOf(".") + 1, fileElement.value.length);
    }
    if (fileExtension == "jpg" || fileExtension == "JPG" || fileExtension == "jpeg") {

        var imageReader = new FileReader();
        imageReader.onload = function(e) {
            $("#uploadedImage").attr("src", e.target.result);
            $("#cropUploadedImage")[0].click();
        };
        imageReader.readAsDataURL(fileElement.files[0]);

        return false;
    }
    else {
        return false;
    }
}