require 'openssl'
require 'base64'

class Obfuscate
  def self.included(base)
    base.extend self
  end

  def decrypt(value)
    begin
    c = cipher.decrypt
    c.key = Digest::SHA256.digest(cipher_key)
    c.update(Base64.decode64(value.to_s)) + c.final
    rescue
      return
    end

  end

  def encrypt(value)
    c = cipher.encrypt
    c.key = Digest::SHA256.digest(cipher_key)
    Base64.encode64(c.update(value.to_s) + c.final)
  end

  private
  def cipher
    OpenSSL::Cipher::Cipher.new('aes-256-cbc')
  end

  def cipher_key
    'K3ep1ng_It-Reel!'
  end

end