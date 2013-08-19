require "spec_helper"

describe FetzneditionsController do
  describe "routing" do

    it "routes to #index" do
      get("/fetzneditions").should route_to("fetzneditions#index")
    end

    it "routes to #new" do
      get("/fetzneditions/new").should route_to("fetzneditions#new")
    end

    it "routes to #show" do
      get("/fetzneditions/1").should route_to("fetzneditions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/fetzneditions/1/edit").should route_to("fetzneditions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/fetzneditions").should route_to("fetzneditions#create")
    end

    it "routes to #update" do
      put("/fetzneditions/1").should route_to("fetzneditions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/fetzneditions/1").should route_to("fetzneditions#destroy", :id => "1")
    end

  end
end
