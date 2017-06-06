window.App ||= {}
class App.Users extends App.Base

  beforeAction: (action) =>
    return


  afterAction: (action) =>
    return


  index: =>
    return


  show: =>
    return


  new: =>
    return


  edit: =>
    new Utility.EasyAutocomplete
    
    $('.easy-autocomplete').attr("style","width: 1110px") # set company name easyAutocomplete field width

    # toggle company fields on edit profile form
    $('.add_company_bool input[type=radio]').on 'change', ->
      if this.value == "true"
        $('#company_fields').removeClass 'hide'
      else
        $('#company_fields').addClass 'hide'

    return
