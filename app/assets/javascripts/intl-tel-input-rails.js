$(document).ready(function () { // document ready

  // get the country data from the plugin
  var countryData = $.fn.intlTelInput.getCountryData(),
    telInput = $(".mobile_no_easyautocomplete"),
    addressDropdown = $(".country_code_easyautocomplete"),
    errorMsg = $("#error-msg"),
    validMsg = $("#valid-msg");

  // init plugin
  telInput.intlTelInput({
    formatOnInit: true,
    separateDialCode: true,
    initialCountry: "auto",
    geoIpLookup: function(callback) {
      $.get('http://ipinfo.io', function() {}, "jsonp").always(function(resp) {
        var countryCode = (resp && resp.country) ? resp.country : "";
        callback(countryCode);
      });
    }
  });

  // populate the country dropdown
  $.each(countryData, function(i, country) {
    addressDropdown.append($("<option></option>").attr("value", country.iso2).text(country.name));
  });

  // set it's initial value
  var initialCountry = telInput.intlTelInput("getSelectedCountryData").iso2;
  addressDropdown.val(initialCountry);

  // listen to the telephone input for changes
  telInput.on("countrychange", function(e, countryData) {
    addressDropdown.val(countryData.iso2);
  });

  // listen to the address dropdown for changes
  addressDropdown.change(function() {
    telInput.intlTelInput("setCountry", $(this).val());
  });

  var reset = function() {
    telInput.removeClass("error");
    errorMsg.addClass("hide");
    validMsg.addClass("hide");
  };

  // on blur: validate
  telInput.blur(function() {
    reset();
    if ($.trim(telInput.val())) {
      if (telInput.intlTelInput("isValidNumber")) {
        validMsg.removeClass("hide");
      } else {
        telInput.addClass("error");
        errorMsg.removeClass("hide");
      }
    }
  });

  // on keyup / change flag: reset
  telInput.on("keyup change", reset);

  // submitting the full international number when in nationalMode or separateDialCode set to true
  $("form").submit(function() {
    telInput.val(telInput.intlTelInput("getNumber"));
  });

}); // document ready END