/***************************************************************
***                Edit these functions manually             ***
***             according with your business logic.          ***
***                                                          ***
****************************************************************/

function rpcProcessing(label, data){

  switch(label){

    /* Сохранение данных о пользователе */

    case "adm_save":
    
    break

    case "adm_save_skype":
    
    break

    case "adm_save_name":
    
    break

    case "adm_save_email":
    
    break

    case "adm_save_uuid":
    
    break

  }
}

/***************************************************************
***           Code beneath is generated automatically.       ***
***                  Please don not edit this.               ***
***                                                          ***
***************************************************************/

var rpcQueries = {}



rpcQueries.adm_save = {
  descr: "Сохранение данных о пользователе",
  params: [
    {
      name: "adm_save_skype",
      value: null,
      filter: "skype",
      onFailure: function(){rpcProcessing("adm_save_skype")}
    },
    {
      name: "adm_save_name",
      value: null,
      filter: "any",
      onFailure: function(){rpcProcessing("adm_save_name")}
    },
    {
      name: "adm_save_email",
      value: null,
      filter: "email",
      onFailure: function(){rpcProcessing("adm_save_email")}
    },
    {
      name: "adm_save_uuid",
      value: null,
      filter: "uuid",
      onFailure: function(){rpcProcessing("adm_save_uuid")}
    },
  ],
  onSuccess: 
    function(){
      $.getJSON("/cgi-bin/rpc.sh", this, function(data){
        rpcProcessing("adm_save", data)
      })
    }
}

$(function(){
  $("#adm_save_submit").click(function(){
    /* Сохранение данных о пользователе */
    var query = __.clone(rpcQueries["adm_save"])
    query.proc_id = "adm_save"
    __.bind(setRpcParams, query, [
      $("#adm_save_skype").val(),
      $("#adm_save_name").val(),
      $("#adm_save_email").val(),
      $("#adm_save_uuid").val(),
    ])()
    __(query).check()
  })

})