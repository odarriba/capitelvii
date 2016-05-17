Rails.application.config.x.cms['menu_items'] = [
  Admin::PagesController,
  Admin::GalleriesController,
  Admin::ContactRequestsController,
  Admin::UsersController
]

Rails.application.config.x.cms['routes'] = {
  'galleries' => 'nuestros-trabajos',
  'contact_requests' => 'contacta',
  'terms' => 'proteccion-de-datos',
  'cookies' => 'politica-de-cookies'
}
