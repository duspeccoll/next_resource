class ArchivesSpaceService < Sinatra::Base

  Endpoint.get('/repositories/:repo_id/next_resource')
    .description("Gets the next collection number in a collecting area")
    .params(["repo_id", :repo_id],
            ["range", String, "The collecting area to which to limit our search"])
    .permissions(["view_repository"])
    .returns([200, "OK"]) \
  do
    dataset = CrudHelpers.scoped_dataset(Resource, {}).map { |rec| rec[:id_0] }.delete_if { |x| !x.start_with?(params[:range]) }
    dataset.delete_if { |x| x == "U901" } # we use U901 as a placeholder; here we ignore it

    json_response({:max => dataset.max})
  end

end
