require "spec_helper"

describe FotosController do
  describe "routing" do

    it "routes to #index" do
      get("/fotos").should route_to("fotos#index")
    end

    it "routes to #new" do
      get("/fotos/new").should route_to("fotos#new")
    end

    it "routes to #show" do
      get("/fotos/1").should route_to("fotos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/fotos/1/edit").should route_to("fotos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/fotos").should route_to("fotos#create")
    end

    it "routes to #update" do
      put("/fotos/1").should route_to("fotos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/fotos/1").should route_to("fotos#destroy", :id => "1")
    end

  end
end
