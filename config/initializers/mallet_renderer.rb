
Mime::Type.register 'text/plain', :mallet

ActionController::Renderers.add :mallet do |object, options|
  self.content_type ||= 'text/plain'
  self.response_body = object.map(&:to_mallet).join("\n")
end

