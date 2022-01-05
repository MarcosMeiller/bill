class BillService

  def initialize(params_bill)
    @bill = params_bill
  end

  def self.call(*args, &block)
    new(*args, &block).call
  end

  def call
    url = "https://chita.cl/api/v1/pricing/simple_quote?client_dni=#{@bill["rut_emisor"]}&debtor_dni=#{@bill["rut_deudor"]}&document_amount=#{@bill["monto"]}&folio=#{@bill["folio"]}&expiration_date=#{@bill["date"]}"
    result = get(url)
    response(result)
  end

  def get(url)
    HTTParty.get(url,
                  headers: { 'X-Api-Key'  => 'UVG5jbLZxqVtsXX4nCJYKwtt' })
  end

  def response(result)
    if result.code == 200
      JSON.parse(result.body)
    else
      'API failed, try again later'
    end
  end

end