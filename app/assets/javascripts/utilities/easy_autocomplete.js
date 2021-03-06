Utility.EasyAutocomplete = (function() {
  function EasyAutocomplete() {

    // options for easyAutocomplete initialization
    var options = {
      url: "/companies.json",

      getValue: "name",

      template: {
        type: "description",
        fields: {
          description: "website"
        }
      },

      list: {
        match: {
          enabled: true
        },
        sort: {
          enabled: true
        },
        onChooseEvent: function() {
          // get company data
          var company_id = $("#user_company_attributes_name").getSelectedItemData().id;
          var company_website = $("#user_company_attributes_name").getSelectedItemData().website;
          var company_country_code = $("#user_company_attributes_name").getSelectedItemData().country_code;
          var company_phone_no = $("#user_company_attributes_name").getSelectedItemData().phone_no;
          
          // insert company data in appropriate fields
          $("#user_selected_company_id").val(company_id);
          $("#user_company_attributes_website").val(company_website);
          $("#user_company_attributes_country_code").val(company_country_code);
          $("#user_company_attributes_phone_no").val(company_phone_no);
          // $("#user_company_attributes_phone_no").intlTelInput("setNumber", company_phone_no); // used intlTelInput to format number

          // disable fields
          $("#user_company_attributes_website").prop('disabled', true);
          $("#user_company_attributes_country_code").prop('disabled', true);
          $("#user_company_attributes_phone_no").prop('disabled', true);
        }
      },

      theme: "plate-dark"
    };

    // init easyAutocomplete
    $("#user_company_attributes_name").easyAutocomplete(options);

    // invokes function when company name input field changes
    $('#user_company_attributes_name').bind('input', function() {
      // clear company fields value each time text changes
      $("#user_selected_company_id").val(''); // so that we'd know if it's a new company or an existing one
      $("#user_company_attributes_website").val('');
      $("#user_company_attributes_country_code").val('');
      $("#user_company_attributes_phone_no").val('');

      // if value is empty
      if (this.value === "") {
        // disable fields
        $("#user_company_attributes_website").prop('disabled', true);
        $("#user_company_attributes_country_code").prop('disabled', true);
        $("#user_company_attributes_phone_no").prop('disabled', true);
      } else {
        // enable fields
        $("#user_company_attributes_website").prop('disabled', false);
        $("#user_company_attributes_country_code").prop('disabled', false);
        $("#user_company_attributes_phone_no").prop('disabled', false);
      }
    });

    return this;
  }

  return EasyAutocomplete;

})();