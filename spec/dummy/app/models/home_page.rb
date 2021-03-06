class HomePage < Fae::StaticPage

  @slug = 'home'

  # required to set the has_one associations, Fae::StaticPage will build these associations dynamically
  def self.fae_fields
    {
      header: {
        type: Fae::TextField,
        validates: { presence: true }
        },
      hero: Fae::TextField,
      email: {
        type: Fae::TextField,
        validates: {
          format: {
            with: /\A[^@]+@[^@]+\z/,
            message: 'should look like an email address, right?'
            },
          allow_blank: true
          }
        },
      introduction: {
        type: Fae::TextArea,
        validates: {
          presence: true,
          length: { maximum: 100 }
          }
        },
      body: Fae::TextArea,
      hero_image: Fae::Image,
      welcome_pdf: Fae::File
    }
  end

end
