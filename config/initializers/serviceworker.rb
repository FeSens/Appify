# frozen_string_literal: true

Rails.application.configure do
  config.serviceworker.routes.draw do
    # map to assets implicitly
    match '/serviceworker-register.js' => 'serviceworker-register.js', pack: true,
      headers: { "Service-Worker-Allowed" => "/" }
    match '/serviceworker.js' => 'serviceworker.js', pack: true,
      headers: { "Service-Worker-Allowed" => "/" }

    match '/serviceworker-register-aplicatify.js' => 'serviceworker-register-aplicatify.js', pack: true,
      headers: { "Service-Worker-Allowed" => "/" }
    match '/aplicatify-serviceworker.js' => 'aplicatify-serviceworker.js', pack: true,
      headers: { "Service-Worker-Allowed" => "/" }
    match '/aplicatify-serviceworker-internal.js' => 'aplicatify-serviceworker-internal.js', pack: true,
      headers: { "Service-Worker-Allowed" => "/" }

    match '/yampi.js' => 'yampi.js', pack: true
    # Examples
    #
    # map to a named asset explicitly
    # match "/proxied-serviceworker.js" => "nested/asset/serviceworker.js"
    # match "/nested/serviceworker.js" => "another/serviceworker.js"
    #
    # capture named path segments and interpolate to asset name
    # match "/captures/*segments/serviceworker.js" => "%{segments}/serviceworker.js"
    #
    # capture named parameter and interpolate to asset name
    # match "/parameter/:id/serviceworker.js" => "project/%{id}/serviceworker.js"
    #
    # insert custom headers
    # match "/header-serviceworker.js" => "another/serviceworker.js",
    #   headers: { "X-Resource-Header" => "A resource" }
    #
    # anonymous glob exposes `paths` variable for interpolation
    # match "/*/serviceworker.js" => "%{paths}/serviceworker.js"
  end
end
