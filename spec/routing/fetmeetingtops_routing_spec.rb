require "spec_helper"

describe FetmeetingtopsController do
  describe "routing" do

    it "routes to #index" do
      get("/fetmeetingtops").should route_to("fetmeetingtops#index")
    end

    it "routes to #new" do
      get("/fetmeetingtops/new").should route_to("fetmeetingtops#new")
    end

    it "routes to #show" do
      get("/fetmeetingtops/1").should route_to("fetmeetingtops#show", :id => "1")
    end

    it "routes to #edit" do
      get("/fetmeetingtops/1/edit").should route_to("fetmeetingtops#edit", :id => "1")
    end

    it "routes to #create" do
      post("/fetmeetingtops").should route_to("fetmeetingtops#create")
    end

    it "routes to #update" do
      put("/fetmeetingtops/1").should route_to("fetmeetingtops#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/fetmeetingtops/1").should route_to("fetmeetingtops#destroy", :id => "1")
    end

  end
end
