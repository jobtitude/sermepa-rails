require 'digest/sha1'

module Sermepa
  def signature(values, secret = nil)
    token = ""
    token += values[:DS_MERCHANT_AMOUNT].to_s
    token += values[:DS_MERCHANT_ORDER].to_s
    token += values[:DS_MERCHANT_MERCHANTCODE].to_s
    token += values[:DS_MERCHANT_CURRENCY].to_s
    token += values[:DS_MERCHANT_PAN].to_s
    token += values[:DS_MERCHANT_CVV2].to_s
    token += values[:DS_MERCHANT_TRANSACTIONTYPE].to_s
    token += values[:DS_MERCHANT_MERCHANTURL].to_s if config.merchant_url
    token += secret || config.secret

    Digest::SHA1.hexdigest(token)
  end

  def signature_valid?(values, secret = nil)
    token = ""
    token += values[:Ds_Amount].to_s
    token += values[:Ds_Order].to_s
    token += values[:Ds_MerchantCode].to_s
    token += values[:Ds_Currency].to_s
    token += values[:Ds_Response].to_s
    token += secret || config.secret
    Digest::SHA1.hexdigest(token).upcase == values[:Ds_Signature]
  end

end