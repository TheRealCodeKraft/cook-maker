app = Doorkeeper::Application.create! :name => 'example', 
                                      :redirect_uri => 'http://www.example.com/callback',
                                      scopes: '', 
                                      uid: '49ebffad-37a8-4ee3-a044-faf175273db4', 
                                      secret: '087b859f-6c46-4b35-9b89-c7c7d9af78ed'
access_token = Doorkeeper::AccessToken.create!(:application_id => app.id, 
                                               expires_in: nil, 
                                               scopes: 'app')
access_token.token = '3f1d605b-3cf9-45d9-aee3-ad5f0b371676'
access_token.save

Codekraft::Api::Service::User.new.create({
  firstname: 'God',
  lastname: 'Admin',
  email: 'god@example.com',
  password: 'f1264430-e18c-40a5-b3db-8581e22126c2',
  password_confirm: 'f1264430-e18c-40a5-b3db-8581e22126c2',
  role: 'admin'
})

Codekraft::Api::Model::Page.create!({
  title: 'Home page',
  body: '<p>Praesent consectetur elit a molestie auctor. Aliquam eget mauris lobortis, tincidunt ex eu, euismod metus. Vestibulum nec malesuada libero. Cras consectetur ac nibh nec dignissim. Duis placerat euismod arcu at cursus. Fusce commodo massa ac lorem varius, in auctor elit efficitur. Sed tempus neque in risus rutrum, sed rutrum lorem congue.</p><p>Phasellus ornare lobortis velit et placerat. Suspendisse potenti. Curabitur at tempus sem. Morbi fringilla ligula lectus, at vehicula erat posuere id. Proin sagittis et sem in egestas. Vivamus ac massa ut velit lacinia congue ut sed libero. Nam ornare magna id ligula feugiat tincidunt. Integer in ex molestie, faucibus mi non, ultrices ligula. In hac habitasse platea dictumst.</p>',
  group: '',
  slug: '/',
  uid: 'home'
})

Codekraft::Api::Model::Page.create!({
  title: 'Lorem ipsum',
  body: '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent sed massa tellus. Quisque ornare, sem at tristique dictum, leo eros porttitor eros, non fermentum urna mauris sed nunc. Donec id nisl risus. Donec blandit placerat dui, ac semper augue euismod vitae. Vivamus id risus et augue tincidunt faucibus. Nulla facilisi. Vestibulum dapibus lectus dignissim, consequat eros vitae, rutrum nibh. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Sed quis sapien tempor, eleifend quam id, mattis mi. Praesent mollis, orci quis bibendum bibendum, mi lectus semper ipsum, vel volutpat tortor nisi ut lorem. Mauris congue elit ultricies, congue odio in, dictum ex. Morbi maximus odio sed tristique venenatis. Nam imperdiet diam eget ante pretium laoreet. Morbi interdum convallis magna, at lacinia ligula volutpat eu. Fusce consectetur turpis eu diam venenatis, vitae convallis arcu viverra.</p><p>Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nam cursus quam eu mauris tempus commodo. Integer nec neque massa. Maecenas sit amet tincidunt elit. Mauris scelerisque augue sed velit pellentesque, vestibulum molestie lacus tincidunt. Nunc in velit cursus, pharetra enim tempor, vulputate ligula. Suspendisse vitae felis eget mi placerat tempor. Integer efficitur mauris sodales diam dapibus tincidunt.</p><p>Cras vel nulla at nisl consectetur eleifend ut cursus augue. Suspendisse interdum fermentum justo, id cursus arcu fringilla et. Fusce lorem dui, lobortis quis dolor eget, dictum pretium nulla. Etiam elit nulla, fringilla pretium blandit ut, lacinia quis risus. Aliquam libero lacus, porttitor sed dignissim eu, dignissim at nunc. Maecenas ullamcorper elit sit amet metus porta lacinia. Aliquam sed auctor sapien, et dictum metus. Phasellus vitae ex mattis, blandit ante sit amet, ornare quam. Cras at aliquam velit. Suspendisse ac risus neque. Vivamus facilisis, diam nec commodo sagittis, metus est mattis purus, non elementum ligula lorem sed libero. Suspendisse semper, lectus a tempor ultrices, elit odio ornare orci, vitae congue lorem ipsum quis tellus. Phasellus in urna in enim rutrum malesuada quis eu leo.</p>',
  group: 'SIDE',
  slug: 'lorem-ipsum'
})

Codekraft::Api::Model::Page.create!({
  title: 'Dolor sit amet',
  body: '<p>Quisque ligula urna, rhoncus at lobortis non, maximus tempus lorem. Donec euismod dapibus sapien, in dictum erat bibendum eget. Aliquam metus nisl, vehicula eu consequat ut, pretium hendrerit enim. Etiam ligula nulla, condimentum nec iaculis vulputate, consequat vitae tellus. Duis feugiat turpis tellus, vitae sollicitudin augue ultricies ut. Mauris vestibulum eleifend risus sit amet vehicula. Mauris pretium velit scelerisque vulputate suscipit. Quisque ultrices nulla in turpis tempor laoreet. Integer egestas, erat et egestas sagittis, ante nisl aliquam erat, et semper odio sapien at arcu. Fusce felis nulla, accumsan vitae laoreet commodo, lobortis commodo nulla. Proin tristique, libero at efficitur commodo, arcu velit tempus purus, vitae vestibulum quam enim quis nibh.</p><p>Sed efficitur felis nulla, quis eleifend quam imperdiet id. Aliquam iaculis egestas dolor. Sed porta, dolor eget semper iaculis, nibh dolor mattis sem, in ultrices nisl erat eu elit. Nam nec diam vitae nunc suscipit vulputate. Phasellus tristique metus est, vitae tristique magna molestie in. In aliquet justo nec orci aliquet consectetur. Sed non augue elit. Nulla facilisi. Proin posuere, augue sed feugiat suscipit, elit libero consectetur odio, ac tincidunt nisl ex id urna. Nam posuere nunc non est lobortis, eget elementum est auctor. Nam placerat maximus auctor.</p><p>Donec non tincidunt nulla. Nulla pellentesque aliquam lacinia. Nullam ut ultrices odio. Fusce luctus justo ac quam convallis lacinia. Cras nisl ante, ornare et mauris et, tempus dignissim magna. Praesent ac aliquet quam. Sed malesuada purus nec sem ultricies elementum. Nunc facilisis fermentum dolor. Nulla egestas lectus id efficitur malesuada. Ut bibendum pretium mauris, at porta lectus placerat sit amet. Ut ac mauris ac orci dapibus sagittis. Phasellus bibendum dapibus consectetur. Vivamus congue vitae urna sit amet euismod. Cras eget lorem ornare, suscipit mi a, viverra nisi. Proin sagittis eu nunc non imperdiet. Duis pharetra viverra nisi, in rutrum massa maximus dapibus.</p>',
  group: 'SIDE',
  slug: 'dolor-sit-amet'
})
