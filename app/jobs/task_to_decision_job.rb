class TaskToDecisionJob < ApplicationJob
  queue_as :default

  #?Nasser: From Cursor - property_type being added.
  def perform(task_id, description, property_type, country, city, direction, meter_street, transaction_type, rent_duration, district, land_area, bedrooms, bathrooms, property_price, selected_language, price_per_meter)
    prompt_with_instruction = "You are an expert in real estate marketing. Your task is to provide a creative description for a property. Here are the details:\n\n" +
                              "- Property Type: #{property_type}\n" +
                              "- Location of the property: This property is located in the country of #{country}, within the city of #{city}, and specifically in the district of #{district}. For example, if the property is in Riyadh, the district could be 'قرطبة'.\n" +
                              "- Description of the property: #{description}\n" +
                              "- Direction of the property: The property is facing #{direction}. This means the main entrance or facade of the property is oriented towards this direction.\n" +
                              "- Street Width in front of the property: The street in front of the property is #{meter_street} meters wide.\n" +
                              "- Land Area: The property has a land area of #{land_area} square meters.\n" +
                              "- Bedrooms: The property has #{bedrooms} bedrooms.\n" +
                              "- Bathrooms: The property has #{bathrooms} bathrooms.\n" +
                              "- Property Price: The price of the property is #{property_price}.\n" +
                              "- Price per Meter: The price per meter of the property is #{price_per_meter}.\n" +
                              "- Selected Language: The output of the AI model should be in #{selected_language}.\n" +
                              "- Transaction Type: The property transaction type is #{transaction_type}.\n" +
                              "- Rent Duration: If the property transaction type is for rent, the duration of the rent is #{rent_duration} (if applicable).\n\n" +
                              "Please note the following requirements:\n\n" +
                              "- The result should be in Arabic, specifically in the Saudi Arabian dialect.\n" +
                              "- The result should be readable and less than 450 tokens long.\n" +
                              "- Ignore any values that are empty or equal to zero.\n" +
                              "- If the transaction type is 'for rent', include the rent duration in the description. If it's 'for sale', mention that the property is for sale.\n\n" +
                              "Please provide your output now."
    gpt_response = send_prompt_to_openai(prompt_with_instruction)
    gpt_text = parse_gpt_response(gpt_response)

    # prompt_with_instruction = "You're an expert in real estate marketing so provide a creative description for this property type \n#{property_type}\n in country \n#{country}\n in \n#{city}\n city in \n#{district}\n district\n
    #  with description \n#{description}\n where direction of the property \n#{direction}\n where the width of the street available in front of the property is \n#{meter_street}\n meter-street\n
    #  .If transcation of the property \n#{transaction_type}\n is for rent, then this's rent duration \n#{rent_duration}\n, otherwise it's for sale\n
    #  Provide in Arabic language especially Saudi Arabian dialect. \n Provide the whole creative description and make it readable in less than 250 tokens.\n"

    # return unless gpt_text
    Rails.logger.info("OpenAI Response: #{gpt_text}") # This will show up in your server logs
    # Just return the gpt_text with success indication
    #{ success: true, result: gpt_text } # The problem is turbostram don't display Openai results
    # Find the task and update its result with the gpt_text
    #? Nasser: From Cursor
    task = Task.find(task_id)
    task.update(result: gpt_text)
  end

  def send_prompt_to_openai(prompt_with_instruction)
    Faraday.post("https://api.openai.com/v1/chat/completions") do |req|
      req.headers["Authorization"] = "Bearer #{Rails.application.credentials.xi_api_key}"
      req.headers["Content-Type"] = "application/json"
      req.body = body_for_gpt(prompt_with_instruction)
    end
  end

  def body_for_gpt(prompt_with_instruction)
    {
      model: "gpt-3.5-turbo",
      messages: [
        {
          role: "system",
          content: "You are a helpful assistant.",
        },
        {
          role: "user",
          content: prompt_with_instruction,
        },
      ],
      # Tokens = words
      max_tokens: 500,
      temperature: 0.1,
      top_p: 1,
      frequency_penalty: 0,
      presence_penalty: 0,
    }.to_json
  end

  def parse_gpt_response(gpt_response)
    if gpt_response.status == 200
      JSON.parse(gpt_response.body)["choices"].first["message"]["content"]
    else
      puts "Error: #{gpt_response.status} - #{gpt_response.body}"
      nil
    end
  end
end
