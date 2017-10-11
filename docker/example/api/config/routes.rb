Rails.application.routes.draw do
  scope 'v1' do
    use_doorkeeper
  end
  mount Base, at: "/"
  mount GrapeSwaggerRails::Engine => '/docs'
end

