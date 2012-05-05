require "spec_helper"

describe StopwordsController do
  describe "routing" do

    it "routes to #index" do
      get("/stopwords").should route_to("stopwords#index")
    end

    it "routes to #new" do
      get("/stopwords/new").should route_to("stopwords#new")
    end

    it "routes to #show" do
      get("/stopwords/1").should route_to("stopwords#show", :id => "1")
    end

    it "routes to #edit" do
      get("/stopwords/1/edit").should route_to("stopwords#edit", :id => "1")
    end

    it "routes to #create" do
      post("/stopwords").should route_to("stopwords#create")
    end

    it "routes to #update" do
      put("/stopwords/1").should route_to("stopwords#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/stopwords/1").should route_to("stopwords#destroy", :id => "1")
    end

  end
end
