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
			var $coll_id = [];
			$results.empty();
			$.each(json, function(i, value) {
				$coll_id.push(value.replace($range, ""));
			});
			var $max_range = Math.max.apply( Math, $coll_id );
			$max_range++;
			var $pad = "000";
			$max_range = ($pad + $max_range).slice(-$pad.length);
			$results.append(AS.renderTemplate("next_collection_results", {range: $range, max_range: $max_range}));
		}
	});
})			
