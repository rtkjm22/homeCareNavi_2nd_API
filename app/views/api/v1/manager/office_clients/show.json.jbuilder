staffs = @staffs.map do |staff|
  {
    id: staff.id,
    name: staff.name
  }
end

office_client = {
  id: @office_client.id,
  avatar_url: @office_client.avatar_url,
  name: @office_client.name,
  furigana: @office_client.furigana,
  postal: @office_client.postal,
  address: @office_client.address,
  family: @office_client.family,
  age: @office_client.age,
  staffs:
}

json.merge! office_client
