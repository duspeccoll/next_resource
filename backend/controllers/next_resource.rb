class ArchivesSpaceService < Sinatra::Base

  Endpoint.post('/repositories/:repo_id/next_resource')
    .description("Gets the next collection number in a collecting area")
    .params(["repo_id", :repo_id],
            ["area", String, "The collecting area to which to limit our search"])
    .permissions(["view_repository"])
    .returns([200, "OK"]) \
  do
    json = next_resource_id(params[:area])

    json_response(json)
  end

  private

  def next_resource_id(area)
    json = {}
    dataset = CrudHelpers.scoped_dataset(Resource, {}).map{|rec| rec[:id_0]}.delete_if{|x| !x.start_with?(area)}
    dataset.delete_if{|x| x == "U901"} # ignoring placeholder ID U901

    if dataset.nil?
      json['error'] = "An invalid collecting area was selected"
    else
      id = (dataset.max.sub("#{area}", "").to_i)+1
      next_id = area.concat(id.to_s.rjust(3, '0'))
      json['id'] = next_id
    end

    json
  end

end
