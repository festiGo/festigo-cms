namespace :republish_routes do
  desc "Rake task to republish all routes"
  task :republish_published => :environment do
    Route.all.each do |route|
      errors = route.validate_for_publishing
      if errors.empty?
        if route.published_key.blank?
          #We are only publishing published routes. If it's not published, don't publish it.
          break
        end
        delete_published_key = route.published_key
        renderer = Rabl::Renderer.new('route', route, {:format => 'json', :view_path => 'app/views/api'})
        route_json = renderer.render
        md5 = OpenSSL::Digest::MD5.new
        published_key = md5.hexdigest(route_json)
        route_json.sub! delete_published_key, published_key
        $redis.del delete_published_key if $redis.exists(delete_published_key)
        $redis.set published_key, route_json
        route.update_attribute :published_key, published_key
      else
        Rails.logger.warn("Could not publish route for following reason(s): #{errors}")
      end
    end
  end
end