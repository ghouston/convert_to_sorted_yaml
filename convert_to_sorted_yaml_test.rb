require 'json'
require './convert_to_sorted_yaml'

# Test case for deep_convert_to_json method
describe ConvertToSortedYaml do
  subject { ConvertToSortedYaml.new('not-used.file-name') }

  describe '#deep_convert_to_json' do
    it 'should convert a JSON string to a nested hash' do
      json_string = '{"name": "John", "age": 30, "city": "New York"}'
      expected_result = {"name" => "John", "age" => 30, "city" => "New York"}

      result = subject.send(:deep_convert_to_json,json_string)

      expect(result).to eq(expected_result)
    end

    it 'should handle nested JSON strings' do
      json_string = '{"name": "John", "age": "30", "address": "{\"street\": \"123 Main St\", \"city\": \"New York\"}"}'
      expected_result = {"name" => "John", "age" => "30", "address" => {"street" => "123 Main St", "city" => "New York"}}

      result = subject.send(:deep_convert_to_json,json_string)

      expect(result).to eq(expected_result)
    end

    it 'should handle JSON arrays' do
      json_string = '[1, 2, 3, 4]'
      expected_result = [1, 2, 3, 4]

      result = subject.send(:deep_convert_to_json,json_string)

      expect(result).to eq(expected_result)
    end

    it 'should handle mixed JSON types' do
      json_string = '{"name": "John", "age": 30, "hobbies": ["reading", "coding"], "address": {"street": "123 Main St", "city": "New York"}}'
      expected_result = {"name" => "John", "age" => 30, "hobbies" => ["reading", "coding"], "address" => {"street" => "123 Main St", "city" => "New York"}}

      result = subject.send(:deep_convert_to_json,json_string)

      expect(result).to eq(expected_result)
    end

    it 'should return the input if it cannot be parsed as JSON' do
        input = "This is not a valid JSON string"

        result = subject.send(:deep_convert_to_json,input)

        expect(result).to eq(input)
    end
  end

  describe '#deep_sort' do
    it 'should sort a nested hash' do
      hash = {"name" => "John", "age" => 30, "city" => "New York"}
      expected_result = {"age" => 30, "city" => "New York", "name" => "John"}

      result = subject.send(:deep_sort, hash)

      expect(result).to eq(expected_result)
    end

    it 'should sort a nested hash with nested arrays' do
      hash = {"name" => "John", "age" => 30, "hobbies" => ["reading", "coding"], "address" => {"street" => "123 Main St", "city" => "New York"}}
      expected_result = {"address" => {"city" => "New York", "street" => "123 Main St"}, "age" => 30, "hobbies" => ["coding", "reading"], "name" => "John"}

      result = subject.send(:deep_sort, hash)

      expect(result).to eq(expected_result)
    end

    it 'should sort an array of hashes' do
      array = [{"name" => "John", "age" => 30}, {"name" => "Alice", "age" => 25}]
      expected_result = [{"age" => 25, "name" => "Alice"}, {"age" => 30, "name" => "John"}]

      result = subject.send(:deep_sort, array)

      expect(result).to eq(expected_result)
    end

    it 'should sort an array of hashes with nested arrays' do
      array = [{"name" => "John", "age" => 30, "hobbies" => ["reading", "coding"]}, {"name" => "Alice", "age" => 25, "hobbies" => ["swimming", "painting"]}]
      expected_result = [{"age" => 25, "hobbies" => ["painting", "swimming"], "name" => "Alice"}, {"age" => 30, "hobbies" => ["coding", "reading"], "name" => "John"}]

      result = subject.send(:deep_sort, array)

      expect(result).to eq(expected_result)
    end

    it 'should return the input if it is not a hash or an array' do
      input = "This is not a hash or an array"

      result = subject.send(:deep_sort, input)

      expect(result).to eq(input)
    end
  end
end
