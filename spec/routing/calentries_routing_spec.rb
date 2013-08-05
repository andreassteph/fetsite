require "spec_helper"

describe CalentriesController do
  describe "routing" do

    it "routes to #index" do
      get("/calentries").should route_to("calentries#index")
    end

    it "routes to #new" do
      get("/calentries/new").should route_to("calentries#new")
    end

    it "routes to #show" do
      get("/calentries/1").should route_to("calentries#show", :id => "1")
    end

    it "routes to #edit" do
      get("/calentries/1/edit").should route_to("calentries#edit", :id => "1")
    end

    it "routes to #create" do
      post("/calentries").should route_to("calentries#create")
    end

    it "routes to #update" do
      put("/calentries/1").should route_to("calentries#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/calentries/1").should route_to("calentries#destroy", :id => "1")
    end

  end
end
