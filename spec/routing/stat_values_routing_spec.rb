require "spec_helper"

describe StatValuesController do
  describe "routing" do

    it "routes to #index" do
      get("/stat_values").should route_to("stat_values#index")
    end

    it "routes to #new" do
      get("/stat_values/new").should route_to("stat_values#new")
    end

    it "routes to #show" do
      get("/stat_values/1").should route_to("stat_values#show", :id => "1")
    end

    it "routes to #edit" do
      get("/stat_values/1/edit").should route_to("stat_values#edit", :id => "1")
    end

    it "routes to #create" do
      post("/stat_values").should route_to("stat_values#create")
    end

    it "routes to #update" do
      put("/stat_values/1").should route_to("stat_values#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/stat_values/1").should route_to("stat_values#destroy", :id => "1")
    end

  end
end
