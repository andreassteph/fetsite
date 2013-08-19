require "spec_helper"

describe MembershipsController do
  describe "routing" do

    it "routes to #index" do
      get("/memberships").should route_to("memberships#index")
    end

    it "routes to #new" do
      get("/memberships/new").should route_to("memberships#new")
    end

    it "routes to #show" do
      get("/memberships/1").should route_to("memberships#show", :id => "1")
    end

    it "routes to #edit" do
      get("/memberships/1/edit").should route_to("memberships#edit", :id => "1")
    end

    it "routes to #create" do
      post("/memberships").should route_to("memberships#create")
    end

    it "routes to #update" do
      put("/memberships/1").should route_to("memberships#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/memberships/1").should route_to("memberships#destroy", :id => "1")
    end

  end
end
