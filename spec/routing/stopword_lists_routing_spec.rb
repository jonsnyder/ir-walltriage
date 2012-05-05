require "spec_helper"

describe StopwordListsController do
  describe "routing" do

    it "routes to #index" do
      get("/stopword_lists").should route_to("stopword_lists#index")
    end

    it "routes to #new" do
      get("/stopword_lists/new").should route_to("stopword_lists#new")
    end

    it "routes to #show" do
      get("/stopword_lists/1").should route_to("stopword_lists#show", :id => "1")
    end

    it "routes to #edit" do
      get("/stopword_lists/1/edit").should route_to("stopword_lists#edit", :id => "1")
    end

    it "routes to #create" do
      post("/stopword_lists").should route_to("stopword_lists#create")
    end

    it "routes to #update" do
      put("/stopword_lists/1").should route_to("stopword_lists#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/stopword_lists/1").should route_to("stopword_lists#destroy", :id => "1")
    end

  end
end
