# frozen_string_literal: true

module ResponseSupport
  # response.parsed_bodyの返り値のハッシュを、キーをシンボルにして返す。主に分割代入するために使用する。
  # @return [Hash{Symbol => Any}]
  # @example
  #   post new_api_v1_user_session_path, params: { email: client.email, password: client.password }
  #   response_symbolized_body[:data] => { id:, name: }
  #   expect(id).to eq client.id
  def response_symbolized_body
    response.parsed_body.deep_symbolize_keys
  end
end
