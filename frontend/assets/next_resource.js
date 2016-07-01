$(function() {
  var $resourceForm = $("#next_resource_form");
  var $resourceResults = $("#next_resource_results");
  var $createResource = $("#create_resource");

  $resourceForm.ajaxForm({
    dataType: "json",
    type: "GET",
    beforeSubmit: function() {
      if(!$("#next-resource-area", $resourceForm).val()) {
        return false;
      }
      $(".btn", $resourceForm).attr("disabled", "disabled").addClass("disabled").addClass("busy");
    },
    success: function(json) {
      $(".btn", $resourceForm).removeAttr("disabled").removeClass("disabled").removeClass("busy");
      $resourceResults.empty();
      $resourceResults.append(AS.renderTemplate("next_resource_id_template", {id: json["id"]}));
    }
  });
})
