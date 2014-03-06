require 'spec_helper'

describe IncumbentApi::API do
  before (:each) do
    #two incumbents
    create(:incumbent)
    create(:incumbent, :id => '002')
  end

  describe "GET /api/incumbents" do
    it "returns an json of incumbents" do
      get "/api/incumbents"
      response.status.should == 200
      incumbent = Incumbent.find_all
      response.body.should == 
        {
        results: {
          count: 2,
          total: 2,
          incumbents: incumbent
        }
      }.to_json
    end

    it "limit params should works" do
      get "/api/incumbents?limit=1"
      ress = JSON.parse(response.body)
      response.status.should == 200
      ress["results"]["count"].should == 2
      ress["results"]["total"].should == 1
    end

    it "offset params should works" do
      get "/api/incumbents?limit=10&offset=1"
      ress = JSON.parse(response.body)
      response.status.should == 200
      ress["results"]["count"].should == 2
      ress["results"]["total"].should == 1
      ress["results"]["incumbents"][0]['id'].should == "002"
    end

    it "should return single data incumbent" do
      get "/api/incumbents/002"
      ress = JSON.parse(response.body)
      response.status.should == 200
      ress["results"]["count"].should == 1
      ress["results"]["total"].should == 1
      ress["results"]["incumbents"]['id'].should == "002"
    end
    
  end

end