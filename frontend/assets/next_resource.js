$(function() {

	var $searchForm = $("#resolve_next_resource");
	var $results = $("#results");

	$searchForm.ajaxForm({
		dataType: 'json',
		type: 'get',
		beforeSubmit: function() {
			if (!$("#next-resource-range", $searchForm).val()) {
				return false;
			}

			$(".btn", $searchForm).attr("disabled", "disabled").addClass("disabled").addClass("busy");
		},
		success: function(json) {
			$(".btn", $searchForm).removeAttr("disabled").removeClass("disabled").removeClass("busy");
			var $range = $("#next-resource-range", $searchForm).val();
			$results.empty();
			$id = json.max.replace($range, "");
			$id++;
			var $pad = "000";
			$id = $range.concat(($pad + $id).slice(-$pad.length));
			$results.append(AS.renderTemplate("next_collection_results", {id: $id}));
		}
	});
})
