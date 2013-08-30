module HTTPDigestAuthentication
  def authenticate_with_http_digest
    controller.stub(:authenticate)
  end
end
