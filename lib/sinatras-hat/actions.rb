Sinatra::Hat::Maker.class_eval do
  action :new, '/new' do |request|
    data = model.new(request.params)
    responder.handle(:new, request, data)
  end
  
  action :show, '/:id' do |request|
    data = model.find(request.params)
    
    responder.handle(:show, request, data)
  end
  
  action :create, '/', :verb => :post do |request|
    data = model.new(request.params)
    data.save
    responder.handle(:create, request, data) do |response|
      response.redirect(request, resource_path("/:id", data))
    end
  end
  
  action :index, '/' do |request|
    data = model.all(request.params)
    responder.handle(:index, request, data)
  end
end