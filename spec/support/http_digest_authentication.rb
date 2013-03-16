require 'digest/md5'
module HTTPDigestAuthentication
  def authenticate_with_http_digest
    user = ENV['WINE_GUIDE_USERNAME']
    password = ENV['WINE_GUIDE_PASSWORD']
    realm = ENV['WINE_GUIDE_REALM']
    ActionController::Base.class_eval { include ActionController::Testing }
 
    unless @controller.methods.include?(:real_process_with_new_base_test)
      @controller.instance_eval %q{
        alias real_process_with_new_base_test process_with_new_base_test
      }
    end
 
    @controller.instance_eval %Q(
      def process_with_new_base_test(request, response)
        credentials = {
          :uri => request.url,
          :realm => "#{realm}",
          :username => "#{user}",
          :nonce => ActionController::HttpAuthentication::Digest.nonce(request.env['action_dispatch.secret_token']),
          :opaque => ActionController::HttpAuthentication::Digest.opaque(request.env['action_dispatch.secret_token'])
        }
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Digest.encode_credentials(request.request_method, credentials, "#{password}", false)
 
        real_process_with_new_base_test(request, response)
      end
    )
  end
end