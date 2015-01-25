module HTTPDigestAuthentication
  def authenticate_with_http_digest
    allow(controller).to receive(:authenticate)
  end
end
