office_clients = @office_clients.map do |office_client|
  staff_name = @staffs.find { |staff| staff.id == office_client.staff_id }.name

  {
    id: office_client.id,
    staff_name:,
    avatar_url: office_client.avatar_url,
    name: office_client.name,
    furigana: office_client.furigana,
    postal: office_client.postal,
    address: office_client.address,
    family: office_client.family,
    age: office_client.age
  }
end

json.set! :office_clients, office_clients
