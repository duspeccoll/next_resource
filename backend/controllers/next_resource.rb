class ArchivesSpaceService < Sinatra::Base

  Endpoint.get('/repositories/:repo_id/next_resource')
    .description("Gets the next collection number in a collecting area")
    .params(["repo_id", :repo_id],
            ["area", String, "The collecting area to which to limit our search"])
    .permissions(["view_repository"])
    .returns([200, "OK"]) \
  do
    dataset = CrudHelpers.scoped_dataset(Resource, {}).map { |rec| rec[:id_0] }.delete_if { |x| !x.start_with?(params[:area]) }
    dataset.delete_if { |x| x == "U901" } # we use U901 as a placeholder; here we ignore it
    id = dataset.max.sub("#{params[:area]}", "").to_i
    id = id + 1
    next_id = params[:area].concat(id.to_s.rjust(3, '0'))
    json_response({:id => next_id})
  end

end
