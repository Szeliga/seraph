RSpec.shared_context "pepper set in configuration" do
  let(:pepper) { '9b8177d1d835fad6cc19b455d41ec64f6dcbe83a1af60eb598973f8fb6e29fb1' }
  before do
    Seraph.configure do |config|
      config.pepper = pepper
    end
  end
end
