require 'swagger_helper'

describe 'Todo API' do

  path '/todos' do

    post 'Creates a todo' do
      tags 'Todos'
      consumes 'application/json', 'application/xml'
      parameter name: :todo, in: :body, schema: {
        type: :object,
        properties: {
          created_at: { type: :string },
          created_by: { type: :string },
          id: { type: :integer },
          title: { type: :string}
        },
        required: [ 'title', 'created_by' ]
      }

      response '201', 'todo created' do
        let(:todo) { { title: 'Veridis Quo', created_by: 'Daft Punk' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:todo) { { title: 'foo' } }
        run_test!
      end
    end
  end

  path '/todos/{id}' do

    get 'Retrieves a todo' do
      tags 'Todos'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'todo found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            title: { type: :string },
            created_by: { type: :string }
          },
          required: [ 'id', 'title', 'created_by' ]

        let(:id) { Todo.create(title: 'Same Old Mistakes', created_by: 'Tame Impala').id }
        run_test!
      end

      response '404', 'todo not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
